'use strict'

angular.module 'app'
  .factory 'Sml', (_) ->

    newLookup = () ->
      index: 0
      table: {}

    getVar = (key, lookup) ->
      found = lookup.table[key]
      if found
        return found
      else
        new_entry = '?x' + lookup.index++
        lookup.table[key] = new_entry
        new_entry

    toClasses = (mapping, table) ->
      classes = ('a ' + c.prefixedName[0] for c in mapping.classes[table])
      if _.isEmpty classes
        return '\n'
      else
        return _.foldl classes, ((x, y) -> (x + ";\n").concat(y))

    toProperties = (mapping, table, lookup) ->
      columns = _.keys mapping.properties[table]
      properties = (mapping.properties[table][c].prefixedName[0] + ' ' + getVar(c, lookup) for c in columns)
      if _.isEmpty properties
        return '\n'
      else
        return _.foldl properties, ((x, y) -> (x + ";\n").concat(y))

    columnToVar = (column) ->
      '?' + column.substring(1, column.length-1)

    subjectTemplate = (mapping, table) ->
      if _.isEmpty mapping.subjectTemplate
        if _.isEmpty mapping.baseUri
          return """?s = uri(tns:#{table})\n""" # TODO: independently refer to primary key column
        else
          return """?s = bNode(concat('#{table}', '_')\n""" # TODO: independently refer to primary key column
      else
        template = mapping.subjectTemplate
        template = template.replace /{[^}]*}/g, (i) -> ';$;' + (columnToVar i) + ';$;'
        template = template.split ';$;'
        template = _.filter template, (i) -> !(_.isEmpty i)
        template = _.map template, (i) ->
          if i[0] == '?'
            i
          else
            "'" + i + "'"
        template = 'concat(' + template + ')'

        if _.isEmpty mapping.baseUri
          return '?s = bNode(' + template + ')' # TODO!
        else
          return '?s = uri(tns, ' + template + ')' # TODO!

    propertyLiterals = (mapping, table, lookup) ->
      literals = mapping.literals
      types = mapping.literalTypes

      columns = _.keys mapping.properties[table]
      columns = _.filter columns, (i) ->
        property = mapping.properties[table][i].prefixedName[0]
        return (literals[property] and types[property])
      
      properties = _.map columns, (i) ->
        property = mapping.properties[table][i].prefixedName[0]
        switch literals[property]
          when 'Blank Node' then lookup[property] = getVar(i, lookup) + ' = bNode(?' + i + ')'
          when 'Plain Literal' then lookup[property] = getVar(i, lookup) + ' = plainLiteral(?' + i + ')'
          when 'Typed Literal' then lookup[property] = getVar(i, lookup) + ' = typedLiteral(?' + i + ', ' + types[property] + ')'
          else ''

      return _.foldl properties, ((x, y) -> (x + "\n").concat(y))

    {
      toSml: (mapping) ->
        table = 'products'

        lookup = newLookup()

        return """
Prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
Prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
Prefix xsd: <http://www.w3.org/2001/XMLSchema#>
Prefix tns: <#{mapping.baseUri}>

Create View #{table} As
    Construct {
        ?s 
#{toClasses mapping, table};
#{toProperties mapping, table, lookup}.
    }
    With
#{subjectTemplate mapping, table}
#{propertyLiterals mapping, table, lookup}
    From #{table}
        """
    }

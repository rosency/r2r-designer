<div ng-controller="PlaygroundCtrl">
  <h3>Playground</h3>

  <div class="panel panel-default">
    <div class="panel-body">
      <p align="right">
        <button class="btn btn-primary" ng-click="ask(table, columns)">
          Ask the Oracle!
        </button>
      </p>
    </div>

    <table class="table table-scrollable">
      <tr>
        <th><button type="button" class="btn btn-primary btn-sm btn-block">{{table}}</button></th>
        <th ng-repeat="column in suggestions.columns"><button type="button" class="btn btn-default btn-sm btn-block">{{column.name}}</button></th>
      </tr>

      {{table}}
      {{columns}}
      {{tableTag}}
      {{columnTags}}
      <tr>
        <td><input type="text" class="table-input" placeholder="{{table}}" ng-model="tableTag" /></td>
        <td ng-repeat="column in suggestions.columns"><input type="text" class="table-input" placeholder="{{column.name}}" ng-model="columnTags[$index]"/></td>
      </tr>

      <tr>
        <td>
          <div class="list-group">
            <a href="#" class="list-group-item" ng-repeat="i in suggestions.table.recommend">
              {{i.prefixedName[0]}}
              <span class="score">{{i.score}}</span>
            </a>
          </div>
        </td>
        <td ng-repeat="column in suggestions.columns">
          <div class="list-group">
            <a href="#" class="list-group-item" ng-repeat="i in column.recommend">
              {{i.prefixedName[0]}}
              <span class="score">{{i.score}}</span>
            </a>
          </div>
        </td>
      </tr>
    </table>

  <!-- <table class="table table&#45;scrollable"> -->
  <!--   <tr ng&#45;repeat="table in tables"> -->
  <!--     <th class="btn&#45;th"> -->
  <!--       <button type="button"  -->
  <!--               class="btn btn&#45;primary btn&#45;sm table&#45;btn"  -->
  <!--               ng&#45;class="{active: isSelectedTable(table)}" -->
  <!--               ng&#45;click="toggleSelectTable(table)">  -->
  <!--         {{table}} -->
  <!--       </button> -->
  <!--     </th> -->
  <!--     <td> -->
  <!--       <button ng&#45;repeat="column in tableColumns[table]"  -->
  <!--               type="button"  -->
  <!--               class="btn btn&#45;default btn&#45;sm table&#45;btn" -->
  <!--               ng&#45;class="{disabled: !isSelectedTable(table), active: isSelectedColumn(table, column)}" -->
  <!--               ng&#45;click="toggleSelectColumn(table, column)"> -->
  <!--           {{column}} -->
  <!--       </button> -->
  <!--     </td> -->
  <!--   </tr> -->
  <!-- </table> -->

  <!-- <div> -->
  <!--   <b>Tables:</b> -->
  <!--   <table class="table table&#45;scrollable"> -->
  <!--     <tr> -->
  <!--       <th ng&#45;repeat="i in tables"> -->
  <!--         {{i}} -->
  <!--       </th> -->
  <!--     </tr> -->
  <!--   </table> -->
  <!-- </div> -->
</div>
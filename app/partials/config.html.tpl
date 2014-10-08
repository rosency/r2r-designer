<div ng-controller="ConfigCtrl"> 
  <form class="form-horizontal" role="form">
    <div class="form-group">
      <label for="datasourceNameInput" class="col-md-4 control-label">Data Source Name</label>
      <div id="datasourceNameInput" class="col-md-8">
        <input type="text" class="form-control" ng-model="datasource.name" />
      </div>

      <label for="subprotocolInput" class="col-md-4 control-label">Protocol</label>
      <div id="subprotocolInput" class="col-md-8">
        <input type="text" class="form-control" ng-model="datasource.subprotocol" />
      </div>

      <label for="subnameInput" class="col-md-4 control-label">Subname</label>
      <div id="subnameInput" class="col-md-8">
        <input type="text" class="form-control" ng-model="datasource.subname" />
      </div>

      <label for="userInput" class="col-md-4 control-label">Username</label>
      <div id="userInput" class="col-md-8">
        <input type="text" class="form-control" ng-model="datasource.username" />
      </div>

      <label for="passwordInput" class="col-md-4 control-label">Password</label>
      <div id="passwordInput" class="col-md-8">
        <input type="password" class="form-control" ng-model="datasource.password" />
      </div>
    </div>

    <div align="right">
      <button type="button" class="btn btn-default" ng-click="test()">Test</button>
      <button type="button" class="btn btn-primary" ng-click="apply()">Apply</button>
    </div>
  </form>
</div>

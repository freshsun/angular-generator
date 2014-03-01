tankApp = angular.module 'tankApp',['actionHelper', 'websocket']
#keyboardHelper = angular.module 'keyboardHelper', []

tankApp
  .controller('appCtrl', ($scope, $log, ws)->
    $scope.$on 'keypress', (onEvent,keypressEvent)->
      keyCode = keypressEvent.which
      action = switch keyCode
        when 119 then 'up'
        when 97 then 'left'
        when 115 then 'down'
        when 100 then 'right'
        when 106 then 'fire'
        else 'none'
      actionList = ['up', 'left', 'down','right', 'fire']
      ws.send({type:'action',content:{action:action}}) if action in actionList
  )

  .factory('boot', ->
    registerUser: ->
    getAllUsers: ->
      'id1':
        name: 'John'
      'id2':
        name: 'Harry'
  )

  .run((boot,ws)->
    users = boot.getAllUsers()
    console.log(users)
    console.log(ws)
  )

  .config((wsProvider)->
    wsProvider.setAddress 'ws://localhost:8080/ws'
  )

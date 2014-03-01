angular.module('websocket', [])
  .provider 'ws', ->
    address = 'ws://localhost:8080/ws'

    setAddress: (addr)->
      address = addr
    $get: ->
      new WebSocket(address)

angular.module('tankApp')
  .directive 'tank', ->
    templateUrl: 'app/tank/tanktpl.html'
    restrict: 'A'
    scope:
      left: '='
      top: '='
    replace: true
    link: ($scope, $ele, $attr)->
      $scope.tankname = '123'


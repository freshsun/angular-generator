angular.module('actionHelper', [])
  .directive 'keypress',
    ['$document'
      '$rootScope'
      ($document, $rootScope)->
        restrict:'A'
        link:()->
          $document.bind 'keypress', (e)->
            console.log 'Got keypress:', e.which
            $rootScope.$broadcast 'keypress', e
    ]

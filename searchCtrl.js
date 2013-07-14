/*global todomvc */
'use strict';

/**
 * The main controller for the app. The controller:
 * - retrieves and persist the model via the todoStorage service
 * - exposes the model to the template and provides event handlers
 */
bbfcapp.controller('SearchCtrl', ['$scope', 'angularFire',
  function SearchCtrl($scope, angularFire) {
    var url = "https://bbfc.firebaseIO.com/words";
    var promise = angularFire(url, $scope, 'words', {});
    $scope.results = [];

    promise.then( function() {
      $scope.doSearch = function() {
        $scope.results = []
        for (var word in $scope.words) {
          if (word.indexOf($scope.term) == 0) {
            for (var f in $scope.words[word].releases) {
              $scope.results.push($scope.words[word].releases[f]);
            }
          }
        }
      }
    });
  }
]);

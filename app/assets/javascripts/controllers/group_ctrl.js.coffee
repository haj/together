lab01Core.controller 'GroupCtrl', ['$scope', '$q', 'Group', '$routeParams', '$location', 
  (($scope, $q, Group, $routeParams, $location) ->
    $scope.path = $location.path()

    getGroup = Group.get($routeParams.groupId).then (value) ->
      $scope.group = value
      
  )]

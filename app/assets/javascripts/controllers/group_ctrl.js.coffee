lab01Core.controller 'GroupCtrl', ['$scope', 'Group', '$routeParams', '$location', 
  (($scope, Group, $routeParams, $location) ->
    $scope.path = $location.path()

    getGroup = Group.get($routeParams.groupId).then (value) ->
      $scope.group = value
      
  )]

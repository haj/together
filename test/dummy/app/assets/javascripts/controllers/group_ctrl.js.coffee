dummy.controller 'GroupCtrl', ['$scope', 'Group', '$routeParams', 
  (($scope, Group, $routeParams) ->
    $scope.group = Group.get($routeParams.groupId)
  )]

dummy.controller 'MainCtrl', ['$scope', 'Group', 'Profile', (($scope, Group, Profile) ->
  $scope.myGroups = Profile.myGroups


  $scope.$on 'updateMyGroups', ->
    $scope.myGroups = Group.query({scope: 'my_groups'})
)]

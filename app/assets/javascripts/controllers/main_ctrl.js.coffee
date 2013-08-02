lab01Core.controller 'MainCtrl', ['$scope', 'Group', 'utils', '$routeParams', 
  (($scope, Group, utils, $routeParams) ->

    $scope.me = utils.currentUser()

    $scope.$on 'updateMyGroups', =>
      @updateMyGroups()
    
    @updateMyGroups = ->
      $scope.myGroups = Group.query({scope: 'my_groups'})

    @updateMyGroups()
  )]

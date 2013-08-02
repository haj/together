lab01Core.controller 'MembershipsNewCtrl', ['$scope', 'Group', 'Membership', 'utils', '$location',
  (($scope, Group, Membership, utils, $location) ->
    $scope.newMembership = new Membership
      userId: utils.currentUserId()

    Group.query({scope: 'other_groups'}).then (results) ->
      $scope.otherGroups = results

    $scope.submit = ->
      $scope.isDisabled = true
      membership = $scope.newMembership
      membership.save().then((->
          $scope.$emit('updateMyGroups')
          $location.path('/groups/' + membership.groupId)
        )
      )
  )]

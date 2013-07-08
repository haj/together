dummy.controller 'JoinGroupCtrl', ['$scope', 'Group', 'Membership', 'utils', 'Profile'
  (($scope, Group, Membership, utils, Profile) ->
    $scope.newMembership = new Membership
      userId: utils.currentUserId()

    $scope.otherGroups = Group.query({scope: 'other_groups'})

    $scope.submit = ->
      $scope.newMembership.save().then((->
          $scope.$emit('updateMyGroups')
        )
      )
      $scope.newMembership = new Membership({})
  )]

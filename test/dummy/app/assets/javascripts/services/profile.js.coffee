dummy.factory "Profile", ['Group', ((Group) ->
  myGroups: Group.query({scope: 'my_groups'})
)]
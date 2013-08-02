lab01Core.factory "utils", ['User', (User) ->
  getMetaTagValue: (name) ->
    angular.element('meta[name=' + name + ']').attr('content')
  currentUserId: ->
    @getMetaTagValue('user_id')
  currentUser: ->
    User.get(@currentUserId())
]
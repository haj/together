lab01Core.factory "User", ['railsResourceFactory', ((railsResourceFactory) ->
  railsResourceFactory
    url: '/users',
    name: 'user'
  )]
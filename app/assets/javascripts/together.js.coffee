#= require jquery
#= require angular
#= require angularjs/rails/resource
#= require_self
#= require_directory './services'
#= require_directory './controllers'
#= require_directory './directives'

@lab01Core = angular.module 'lab01Core', ['rails']

@lab01Core.config ['$routeProvider', ($routeProvider) -> 
  $routeProvider.when '/groups/:groupId',
    templateUrl: 'group.html'
    controller: 'GroupCtrl'
  .when '/memberships/new',
    templateUrl: 'memberships.new.html'
    controller: 'MembershipsNewCtrl'
]

@lab01Core.config ["$httpProvider", (provider) ->
    provider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content')
]
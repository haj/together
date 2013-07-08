#= require jquery
#= require angular
#= require angularjs/rails/resource
#= require_self
#= require_directory './services'
#= require_directory './controllers'

@dummy = angular.module 'dummy', ['rails']

@dummy.config ['$routeProvider', ($routeProvider) -> 
  $routeProvider.when '/groups/:groupId',
    templateUrl: 'group.html'
    controller: 'GroupCtrl'
  .when '/join_group',
    templateUrl: 'join_group.html'
    controller: 'JoinGroupCtrl'
]

@dummy.config ["$httpProvider", (provider) ->
    provider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content')
]
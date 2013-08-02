lab01Core.directive 'activeLink', ['$location', 
  (($location) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.location = $location

      attrs.$observe 'href', (path) ->
        path = path.substring(1) # remove first char 'cause hashbang not in $location.path
        
        updateElement = ->
          if $location.path() == path
            element.addClass('active')
          else
            element.removeClass('active')

        scope.$watch 'location.path()', updateElement
        updateElement()
  )]
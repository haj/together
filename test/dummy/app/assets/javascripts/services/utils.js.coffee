dummy.factory "utils", () ->
  getMetaTagValue: (name) ->
    angular.element('meta[name=' + name + ']').attr('content')
  currentUserId: ->
    @getMetaTagValue('user_id')
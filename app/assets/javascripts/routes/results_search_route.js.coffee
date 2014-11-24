EnlightenmentApp.SearchResultsRoute = Ember.Route.extend
  model: (params) ->
    store = @store
    new Em.RSVP.Promise((resolve) ->
      store.find('content_entity').then (content_entities) ->
        promiseArr = content_entities.getEach('tags')
        Em.RSVP.all(promiseArr).then ->
          filter = store.filter('content_entity', (content_entity, index, enumerable) ->
            match = false

            content_entity.get('tags').forEach( (tag) ->
              if tag.get('name') == params.keyword
                console.log(content_entity.get('name') + ' true')
                match = true
              else
                console.log(content_entity.get('name') + ' false' + tag.get('name'))
            )
            return match
          )
          resolve(filter)
    )
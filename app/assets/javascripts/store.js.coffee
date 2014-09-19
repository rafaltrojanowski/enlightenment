# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

# EnlightenmentApp.Store = DS.Store.extend({

# })

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
# EnlightenmentApp.ApplicationAdapter = DS.ActiveModelAdapter.extend({

# })
#


# DS.RESTAdapter.reopen
  # namespace: 'api/v1'

EnlightenmentApp.ApplicationAdapter = DS.RESTAdapter.extend
  namespace: 'api/v1',
  configure: 'plurals', content_entity: 'content_entities'
  # configure: 'plurals', note: 'notes'

//= require sinon
//= require application

mocha.ui('bdd');
mocha.globals(['Ember', 'DS', 'EnlightenmentApp', 'MD5']);
mocha.timeout(5);
chai.Assertion.includeStack = true;

ENV = {
  TESTING: true
};

window.server = sinon.fakeServer.create();

server.autoRespond = true

server.respondWith("POST", "/users.json",
    [200, { "Content-Type": "application/json" },
     '[{ "id": 12, "comment": "Hey there" }]']);

server.respondWith("POST", "/users/sign_in",
    [200, { "Content-Type": "application/json" },
     '[{ "id": 12, "comment": "Hey there" }]']);

server.respondWith("GET", "api/vi/contentEntities.json",
  [200, { "Content-Type": "application/json" },
   '{"commemnts":[{"id":1,"text":"Comment 1"},{"id":2,"text":"Comment 2"}]}'
]);

window.testHelper = {
  lookup: function(object, object_name) {
    name = object_name || "main";
    return EnlightenmentApp.__container__.lookup(object + ":" + name);
  }
}

EnlightenmentApp.Router.reopen({
  location: 'none'
});

Konacha.reset = Ember.K;

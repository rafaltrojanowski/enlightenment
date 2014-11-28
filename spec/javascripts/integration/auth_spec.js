//= require spec_helper

describe('Registration test', function() {
  it('redirect to home after cancel click', function() {
    Ember.run(function() {
      testHelper.lookup('router').transitionTo('registration');
    });

    $('input[id=name]').val('name').change();
    $('input[id=email]').val('name@name.com').change();
    $('input[id=password]').val('q1w2e3r4').change();
    $('input[id=password_confirmation]').val('q1w2e3r4').change();

    createPostButton = $('.btn-default');

    var mock = sinon.mock(testHelper.lookup('route', 'registration'));
    mock.expects('transitionTo').once().withExactArgs('home');

    createPostButton.click();

    mock.verify();
    mock.restore();
  });

  it('sign up after fill form vith valid data', function() {
    ce = testHelper.lookup('store').createRecord('content_entity')
    ce.set('id', 1);
    
    Ember.run(function() {
      testHelper.lookup('router').transitionTo('registration');
    });
    
    var mock = sinon.mock(testHelper.lookup('route', 'registration'));

    $('input[id=name]').val('name').change();
    $('input[id=email]').val('name@name.com').change();
    $('input[id=password]').val('q1w2e3r4').change();
    $('input[id=password_confirmation]').val('q1w2e3r4').change();

    createPostButton = $('.btn-primary');

    createPostButton.click();

    // @TODO page text must include 'succesfully signed in'
    // mock.expects('transitionTo').once().withExactArgs('content_entities');

    // mock.verify();
    // mock.restore();
  });
});

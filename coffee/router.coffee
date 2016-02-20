###*
 * Router module
 * @author AlexSuslov<suslov@me.com>
 * @created 2016-02-18
###
if window.data
  App.model = new Models.Main(window.data)
else
  App.model = new Models.Main()


App.Router = Backbone.Router.extend
  login:false
  routes:
    logout        : 'logout'
    config        : 'config'
    hardware      : 'hardware'
    devices       : 'devices'
    tools         : 'tools'
    'devices/:id' : 'device'
    ''            : 'summary'
  Forms:
    login    : new App.Views.Auth( model:App.model, el:'.login').render()
    main     : new App.Views.Main( model:App.model, el:'.main')
    config   : new App.Views.Config(el:'.config')
    hardware : new App.Views.Hardware(el:'.hardware')
    devices  : new App.Views.Devices(el:'.devices')
  initialize:->
    # logout
    Backbone.on 'onLogin', =>
      @summary()
    Backbone.on 'onLogout', =>
      App.model.clear()
      @summary()
    @

  logout:->
    Backbone.trigger 'onLogout'
    @

  summary:->
    $('.block').hide()
    if App.model.get 'Chip_id'
      $('nav').show()
      $('.main').show()
    else
      $('nav').hide()
      $('.login').show()
    @

  config:->
    $('.block').hide()
    @Forms.config.model.fetch()
    $('.config').show()
    @

  hardware:->
    $('.block').hide()
    @Forms.hardware.model.fetch()
    $('.hardware').show()
    @

  devices:->
    $('.block').hide()
    @Forms.devices.collection.fetch()
    $('.devices').show()
    @

  device:(id)->
    console.log 'device', id
    device = new Models.Device(id:id)
    device.fetch()

  tools:(id)->
    new App.Views.Tools(el:'.container')
    console.log 'tools'


App.router = new App.Router()

Backbone.history.start();

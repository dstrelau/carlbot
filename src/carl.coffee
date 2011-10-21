fs      = require 'fs'
util    = require 'util'
express = require 'express'
ranger  = require 'ranger'
RoomList = require './room_list'

module.exports = class Carl
  constructor: (options) ->
    @campfire = ranger.createClient(options.campfire_account, options.campfire_token)
    @roomList = new RoomList @campfire
    @modules = []
    @phrases = []
    @server = express.createServer()
    @port = options.port
    @initModules()

  initModules: ->
    fs.readdir "#{__dirname}/modules", (err, files) =>
      for file in files
        require("#{__dirname}/modules/#{file}").init(this)
        @modules.push(file)
        util.debug "Loaded module: #{file}"

  eavesdrop: (pattern, callback) ->
    util.debug "Listening for '#{pattern}'"
    @phrases.push [pattern, callback]

  listenIn: ->
    @roomList.joinAll (rooms) =>
      for room in rooms
        room.listen (msg) =>
          util.debug(msg.body)
          for phrase in @phrases when phrase[0].test(msg.body)
            phrase[1](@roomList.findById(msg.roomId),msg)

  registerExitHooks: ->
    cleanup = =>
      util.debug "Goodbye."
      @roomList.leaveAll -> process.exit()
    process.on(signal, cleanup) for signal in ['SIGINT','SIGTERM']

  awaken: ->
    @registerExitHooks()
    @listenIn()
    @server.listen @port
    util.debug "Carl awaken on port #{@port}"


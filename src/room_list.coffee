util  = require 'util'
async = require 'async'

module.exports = class
  constructor: (campfire) ->
    @campfire = campfire
    @rooms = []

  # Join all rooms, calling `callback` with the room list when complete
  joinAll: (callback) ->
    @campfire.rooms (rooms) =>
      @join room for room in rooms
      callback? rooms

  # Join a room, and keep track we've joined it
  join: (room) ->
    room.join -> util.debug "Joined room '#{room.name}'"
    @rooms.push room

  leaveAll: (callback) ->
    async.parallel (async.apply(room.leave) for room in @rooms), callback

  findById: (id) ->
    for room in @rooms
      return room if room.id == id

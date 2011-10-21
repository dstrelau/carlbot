env = process.env
ranger = require 'ranger'
util = require 'util'

campfire_account = env.CAMPFIRE_ACCOUNT
campfire_token =   env.CAMPFIRE_TOKEN

client = ranger.createClient(campfire_account, options.campfire_token)
client.room 265996, (room) ->
  room.speak "hello"
  room.leave ->
    util.debug "left!"


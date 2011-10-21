util = require 'util'
env  = process.env
Carl = require './carl'

if env.CAMPFIRE_ACCOUNT? && env.CAMPFIRE_TOKEN?
  util.debug "Connecting to '#{env.CAMPFIRE_ACCOUNT}' campfire"
else
  util.debug "Provide CAMPFIRE_ACCOUNT AND CAMPFIRE_TOKEN"
  process.exit 5

carl = new Carl
  campfire_account: env.CAMPFIRE_ACCOUNT
  campfire_token:   env.CAMPFIRE_TOKEN
  port:             env.PORT || 4747

carl.awaken()

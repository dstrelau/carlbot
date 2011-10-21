exports.init = (carl) ->
  carl.eavesdrop /^ping$/i, (room, message) ->
    room.speak 'pong!'

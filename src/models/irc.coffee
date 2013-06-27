"use strict"

module.exports = (host, nickname, password, channels) ->
  this.client = new irc.Client(host, nickname,
    channels: channels
    password: password
  )
  that = this
  this.listen = ->
    that.client.addListener('message', (user, channel, message) ->
      console.log(user + ' => ' + channel + ': ' + message)
    )
    that.client.addListener('error', (message) ->
      now = new Date()
      console.error("[%s] - %s", now, message)
    )
  return

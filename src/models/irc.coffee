"use strict"

module.exports = (host, nickname, password, channels) ->
  this.client = new irc.Client(host, nickname,
    channels: channels
    password: password
  )
  that = this
  this.listen = ->
    that.client.addListener('message', (user, channel, message) ->
      twitch.Model.Message.createWithIndex(
        user: user
        channel: channel
        text: message
      )
    )
    that.client.addListener('error', (message) ->
      now = new Date()
      console.error("[%s] - %s", now, message)
    )
  return

"use strict"

require("../config/boot.js")
config = twitch.config.irc

irc = new twitch.Model.IRC(config.host, config.nickname, config.password, config.channels)
irc.listen()

console.log('start listen twitch.tv IRC channels: %s', config.channels)

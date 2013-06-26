"use strict"

env = process.env['NODE_ENV'] || 'development'
config = require("../config/app")[env].irc

IRC = require("../app/models/irc.js")
irc = new IRC(config.host, config.nickname, config.password, config.channels)
irc.listen()

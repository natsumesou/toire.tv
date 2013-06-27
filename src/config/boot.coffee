"use strict"

twitch = {
  config: {},
  Model: {},
  env: null,
}

twitch.env =  process.env['NODE_ENV'] || 'development'
twitch.config = require("./app")[twitch.env]
twitch.Model.IRC = require("../app/models/irc.js")
# twitch.Model.message = require("../app/models/message.js")

global.twitch = twitch

global.express = require("express")
global.http = require("http")
global.path = require("path")
global.irc = require("irc")
global.mongoose = require("mongoose")

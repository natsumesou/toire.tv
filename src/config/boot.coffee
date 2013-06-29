"use strict"

# app settings
twitch = {
  config: {},
  Model: {},
  env: null,
}
twitch.env =  process.env['NODE_ENV'] || 'development'
twitch.config = require("./app")[twitch.env]

# libraries
global.express = require("express")
global.http = require("http")
global.path = require("path")
global.irc = require("irc")
global.mongoose = require("mongoose")

# mongodb settings
dbConfig = twitch.config.database

dbOptions =
  server:
    poolSize: 10

if dbConfig.user and dbConfig.password
  dbOptions.user = dbConfig.user
  dbOptions.pass = dbConfig.password

global.mongoose.connect('mongodb://' + dbConfig.host + '/' + dbConfig.db,
  dbOptions);

twitch.Model.IRC = require("../app/models/irc.js")
twitch.Model.MessageIndex = require("../app/models/message_index.js")
twitch.Model.Message = require("../app/models/message.js")

global.twitch = twitch

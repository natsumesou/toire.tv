"use strict"

process.env['NODE_ENV'] = 'test'
require("../config/boot.js")
chai = require("chai")
global.expect = chai.expect

global.Message = twitch.Model.Message
global.MessageIndex = twitch.Model.MessageIndex

global.dataCleaner = (done) ->
  Message.remove()
  MessageIndex.remove(done)

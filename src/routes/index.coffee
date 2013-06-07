"use strict"

exports.index = (req, res) ->
  res.render "index",

Twitch = require("../models/twitch")
exports.login = (req, res) ->
  twitch = new Twitch()
  loginUrl = twitch.getAuthorizeUrl()
  res.redirect loginUrl

exports.authorized = (req, res) ->
  callback = (error, access_token, refresh_token, results) ->
    if (error)
      console.log "cannot get access_token from twitch.tv / %s", error
    else
      req.session.access_token = access_token
  twitch = new Twitch()
  twitch.getAccessToken(req.query.code, callback)
  res.redirect "/"

exports.user = (req, res) ->
  twitch = new Twitch()
  twitch.getUserData(req.session.access_token)

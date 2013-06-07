"use strict"

OAuth = require("OAuth")
config = require("../../config/app")

module.exports = ->
  baseUrl: 'https://api.twitch.tv/kraken'
  authPath: '/oauth2/authorize'
  tokenPath:  '/oauth2/token'
  redirectUri: 'http://localhost:3000/authorized'

  initialize: ->
    this.initialize.apply(this, arguments)
  getAuthorizeUrl: ->
    OAuth2 = OAuth.OAuth2
    oauth = new OAuth2(config.twitch.clientId, config.twitch.clientSecret, this.baseUrl, this.authPath, this.tokenPath, null)
    params =
      redirect_uri: this.redirectUri
      response_type: 'code'
      scope: 'chat_login'
    oauth.getAuthorizeUrl(params)
  getAccessToken: (code, callback) ->
    OAuth2 = OAuth.OAuth2
    oauth = new OAuth2(config.twitch.clientId, config.twitch.clientSecret, this.baseUrl, this.authPath, this.tokenPath, null)
    params =
      redirect_uri: this.redirectUri
      grant_type: 'authorization_code'
    oauth.getOAuthAccessToken(code, params, callback)
  getUserData: (access_token) ->
    OAuth2 = OAuth.OAuth2
    oauth = new OAuth2(config.twitch.clientId, config.twitch.clientSecret, this.baseUrl, this.authPath, this.tokenPath, null)
    callback = (resp) ->
      console.log "test"
      console.log resp
    oauth.get(this.baseUrl + "/user", access_token, callback)

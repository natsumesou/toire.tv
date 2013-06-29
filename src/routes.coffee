"use strict"

module.exports = (app) ->
  chatlog = require('./controllers/chatlog.js')

  app.get '/', (req, res) ->
    res.render "index"

  app.get '/chatlog', chatlog.index
  app.get '/chatlog/:date', chatlog.messagesByDate

  # Not Found
  app.use (req, res) ->
    res.status(404).render("errors/404")

  # Internal Error
  app.use (err, req, res, next) ->
    now = new Date()
    console.error("[%s] - %s", now, req.url)
    console.error(err.stack)
    res.status(500).render("errors/500")

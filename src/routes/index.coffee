"use strict"

module.exports = (app) ->
  app.get '/', (req, res) ->
    res.render "index"

  # Not Found
  app.use (req, res) ->
    res.status(404).render("errors/404")

  # Internal Error
  app.use (err, req, res, next) ->
    now = new Date()
    console.error("[%s] - %s", now, req.url)
    console.error(err.stack)
    res.status(500).render("errors/500")

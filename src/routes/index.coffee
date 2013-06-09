"use strict"

exports.index = (req, res) ->
  now = new Date()
  startDate = new Date(2013, 5, 15, 22, 0)
  if(now < startDate)
    res.render "countdown/index"
  else
    res.render "index"

exports.notFound = (req, res) ->
  res.status(404).render("errors/404")

exports.internalError = (err, req, res, next) ->
  now = new Date()
  console.error("[%s] - %s", now, req.url)
  console.error(err.stack)
  res.status(500).render("errors/500")

"use strict"

module.exports =
  formattedDate: (date) ->
    year = date.getFullYear()
    month = date.getMonth() + 1
    day = date.getDate()
    year + "/" + month + "/" + day
  formattedTime: (date) ->
    hour = ("0" + date.getHours()).slice(-2)
    minutes = ("0" + date.getMinutes()).slice(-2)
    hour + ":" + minutes

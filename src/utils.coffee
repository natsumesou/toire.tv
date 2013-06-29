"use strict"

module.exports =
  formattedDate: (date) ->
    year = date.getFullYear()
    month = date.getMonth() + 1
    day = date.getDate()
    year + "/" + month + "/" + day
  formattedUrlDate: (date) ->
    year = date.getFullYear()
    month = date.getMonth() + 1
    day = date.getDate()
    year + "-" + month + "-" + day
  formattedTime: (date) ->
    hour = ("0" + date.getHours()).slice(-2)
    minutes = ("0" + date.getMinutes()).slice(-2)
    hour + ":" + minutes

  colorByName: (user) ->
    rgb = ""
    for i in [1..3]
      if user.length >= 3
        rgbInt = parseInt((user.charCodeAt(user.length - i) - 97) * 10.2 % 255)
      else
        rgbInt = parseInt((user.charCodeAt() - 97) * 10.2 % 255)
      rgb += ("f" + rgbInt.toString(16)).slice(-1)
    rgb

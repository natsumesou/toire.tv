"use strict"

module.exports =
  index: (req, res) ->
    twitch.Model.MessageIndex.allMessageIndexes (err, messageIndexes) ->
      if err
        console.error(err)
      if messageIndexes.length > 0
        twitch.Model.Message.messagesByDate(messageIndexes[0].createdAt,
          (err, messages) ->
            if err
              console.error(err)
            res.render "chatlog/index",
              twitch: twitch
              messageIndexes: messageIndexes
              showDate: messageIndexes[0].createdAt
              messages: messages
        )
  messagesByDate: (req, res) ->
    date = new Date(req.params.date)
    if isNaN(date)
      res.status(404).render("errors/404")
    twitch.Model.MessageIndex.allMessageIndexes (err, messageIndexes) ->
      if err
        console.error(err)
      if messageIndexes.length > 0
        twitch.Model.Message.messagesByDate(date,
          (err, messages) ->
            if err
              console.error(err)
            res.render "chatlog/index",
              twitch: twitch
              messageIndexes: messageIndexes
              showDate: date
              messages: messages
        )

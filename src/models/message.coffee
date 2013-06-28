"use strict"

Message = mongoose.Schema(
  user:
    type: String
    required: true
  channel:
    type: String
    required: true
  text:
    type: String
    required: true
  createdAt:
    type: Date
    default: new Date
    required: true
    index: true
)

Message.statics.createWithIndex = (data) ->
  if isConnectionStartMessage(data.user, data.channel, data.text)
    return false
  now = new Date()
  that = this
  Q.fcall ->
    twitch.Model.MessageIndex.isSavedIndex(now)
  .then (isSavedIndex) ->
    that: that
    savedIndex: isSavedIndex
    messageData: data
    now: now
  .then (data) ->
    saveMessage(data)
  .done()

isConnectionStartMessage = (fromUser, toUser, message) ->
  (fromUser is 'jtv') and
  (toUser is twitch.config.irc.nickname) and
  (message.indexOf 'HISTORYEND' >= 0)

saveMessage = (data) ->
  return Q.fcall ->
    if !data.savedIndex
      twitch.Model.MessageIndex.createByDate(data.now)
  .then ->
    data.that.create(
      data.messageData
    ,
      (err, message) ->
        if err
          console.error(err)
    )

module.exports = mongoose.model('Message', Message)

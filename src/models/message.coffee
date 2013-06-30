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
    default: new Date()
    required: true
    index: true
)

# create message document with messageindex document
#
# param - {user: 'user name', channel: '#channel_name', text: 'chat message'}
Message.statics =
  createWithIndex: (data, callback) ->
    if _isConnectionStartMessage(data.user, data.channel, data.text)
      return callback(null, new this)
    now = data.createdAt
    twitch.Model.MessageIndex.isSavedIndex(now, (err, isSavedIndex) ->
      _saveMessage(
        savedIndex: isSavedIndex
        messageData: data
        now: now
      ,
        callback
      )
    )
  messagesByDate: (date, callback) ->
    if isNaN(date.getTime())
      return callback(null, [])
    year = date.getFullYear()
    month = date.getMonth()
    day = date.getDate()
    date = new Date(year, month, day)
    nextDate = new Date(date.getTime() + 86400000) # 24 * 60 * 60 * 1000
    this.find(
      { createdAt: {$gte: date, $lt: nextDate} }, {},
      { sort: {createdAt: 1} },
      callback
    )

Message = mongoose.model('Message', Message)

# check message is connection start auto message or not
_isConnectionStartMessage = (fromUser, toUser, message) ->
  (fromUser is 'jtv') and
  (toUser is twitch.config.irc.nickname) and
  ((message.indexOf 'HISTORYEND') >= 0)

# save message document with messageindex document if date is new date
_saveMessage = (data, callback) ->
  if !data.savedIndex
    twitch.Model.MessageIndex.createByDate(data.now, (err, messageIndex) ->
      if err
        console.error(err)
      Message.create(data.messageData, callback)
    )
  else
    Message.create(data.messageData, callback)

module.exports = Message

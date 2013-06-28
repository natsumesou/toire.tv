"use strict"

MessageIndex = mongoose.Schema(
  createdAt:
    type: Date
    default: new Date
    required: true
    index:
      unique: true
)


MessageIndex.statics.isSavedIndex = (date) ->
  indexDate = toIndexDate(date)
  query = this.find(createdAt: indexDate)
  return Q.fcall ->
    query.exec()
  .then (messageIndexes) ->
    messageIndexes.length > 0 ? true : false

MessageIndex.statics.createByDate = (date) ->
  indexDate = toIndexDate(date)
  this.create(
    createdAt: indexDate
  ,
    (err, messageIndex) ->
      if err
        options.error(err)
  )

toIndexDate = (date) ->
  year = date.getFullYear()
  month = date.getMonth()
  day = date.getDate()
  new Date(year, month, day)

module.exports = mongoose.model('MessageIndex', MessageIndex)

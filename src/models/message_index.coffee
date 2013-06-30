"use strict"

MessageIndex = mongoose.Schema(
  createdAt:
    type: Date
    default: new Date()
    required: true
    index:
      unique: true
)

# check date is saved or not
MessageIndex.statics =
  # date is saved or not
  isSavedIndex: (date, callback) ->
    indexDate = _toIndexDate(date)
    this.find(createdAt: indexDate).exec (err, messageIndexes) ->
      result = if messageIndexes.length > 0 then true else false
      callback(err, result)
  # create messageindex document by date
  createByDate: (date, callback) ->
    indexDate = _toIndexDate(date)
    messageIndex = new this(createdAt: indexDate)
    messageIndex.save(callback)
  findByDate: (date, callback) ->
    indexDate = _toIndexDate(date)
    this.findOne({createdAt: indexDate}, callback)
  latestMessageIndex: (callback) ->
    this.findOne({}, {}, {sort: {createdAt: 1}}, callback)
  allMessageIndexes: (callback) ->
    this.find({}, {}, { sort: {createdAt: -1}}, callback)


MessageIndex = mongoose.model('MessageIndex', MessageIndex)

# change date to formatted date
_toIndexDate = (date) ->
  year = date.getFullYear()
  month = date.getMonth()
  day = date.getDate()
  new Date(year, month, day)

module.exports = MessageIndex

"use strict"
require("../../spec_helper.js")

describe "Message", ->
  beforeEach (done) ->
    dataCleaner(done)
  afterEach (done) ->
    dataCleaner(done)

  describe ".createWithIndex", ->
    describe "is valid format", ->
      describe "with new date", ->
        it "save normaly and added new messageindex document", (done) ->
          data =
            user: 'user'
            channel: '#test'
            text: 'message'
          Message.createWithIndex(data, (err, message) ->
            expect(message.user).to.equal(data.user)
            expect(message.channel).to.equal(data.channel)
            expect(message.text).to.equal(data.text)
            MessageIndex.count({}, (err, count)->
              expect(count).to.equal(1)
              done()
            )
          )
      describe "with same date", ->
        beforeEach (done) ->
          date = new Date()
          MessageIndex.createByDate(date, done)
        it "not save new MessageIndex document", (done) ->
          data =
            user: 'user'
            channel: '#test'
            text: 'message'
          Message.createWithIndex(data, (err, message) ->
            MessageIndex.count({}, (err, count)->
              expect(count).to.equal(1)
              done()
            )
          )
      describe "with different date", ->
        beforeEach (done) ->
          date = new Date(2012, 2, 1)
          MessageIndex.createByDate(date, done)
        it "save new MessageIndex document", (done) ->
          data =
            user: 'user'
            channel: '#test'
            text: 'message'
          Message.createWithIndex(data, (err, message) ->
            MessageIndex.count({}, (err, count)->
              expect(count).to.equal(2)
              done()
            )
          )
    describe "is connection start message", ->
      it "not save", (done) ->
        data =
          user: 'jtv'
          channel: twitch.config.irc.nickname
          text: 'HISTORYEND test'
        Message.createWithIndex(data, (err, message) ->
          expect(message.user).to.be.undefined
          expect(message.channel).to.be.undefined
          expect(message.text).to.be.undefined
          MessageIndex.count({}, (err, count)->
            expect(count).to.equal(0)
            done()
          )
        )
  describe ".messagesByDate", ->
    prevDate = new Date(2013, 2, 4, 23, 59)
    date = new Date(2013, 2, 5)
    dateMax = new Date(2013, 2, 5, 23, 59)
    nextDate = new Date(2013, 2, 6)
    dates = [prevDate, date, dateMax, nextDate]
    beforeEach (done) ->
      messages = []
      messages.push {createdAt: prevDate, user: 'user', channel: 'channel', text: 'text1'}
      messages.push {createdAt: date, user: 'user', channel: 'channel', text: 'text2'}
      messages.push {createdAt: dateMax, user: 'user', channel: 'channel', text: 'text3'}
      messages.push {createdAt: nextDate, user: 'user', channel: 'channel', text: 'text4'}
      Message.create(messages , done)
    describe "when exist messages", ->
      it "get messages from date to next date", (done) ->
        Message.messagesByDate(date, (err, messages) ->
          expect(messages.length).to.equal(2)
          expect(messages[0].text).to.equal('text2')
          expect(messages[1].text).to.equal('text3')
          done()
        )

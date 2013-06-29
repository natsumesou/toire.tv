"use strict"
require("../../spec_helper.js")

describe "MessageIndex", ->
  beforeEach (done) ->
    dataCleaner(done)
  afterEach (done) ->
    dataCleaner(done)

  describe ".isSavedIndex", ->
    describe "with new date", ->
      it "save new document", (done) ->
        date = new Date()
        MessageIndex.isSavedIndex(date, (err, isSavedIndex) ->
          expect(isSavedIndex).to.be.false
          done()
        )
    describe "with saved date", ->
      date = new Date(2013, 2, 1)
      beforeEach (done) ->
        MessageIndex.createByDate(date, done)
      it "not save new document", (done) ->
        MessageIndex.isSavedIndex(date, (err, isSavedIndex) ->
          expect(isSavedIndex).to.be.true
          done()
        )
  describe ".createByDate", ->
    it "saved formatted date", (done) ->
      unformattedDate = new Date(2013, 2, 1, 3, 4)
      formattedDate = new Date(2013, 2, 1)

      MessageIndex.createByDate(unformattedDate
      , (err, messageIndex) ->
        expect(messageIndex.createdAt.toDateString()).to
          .equal(formattedDate.toDateString())
        done()
      )

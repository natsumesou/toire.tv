"use strict"

reloadPage = ->
  setTimeout ->
    location.reload()
  , 1000


$("#countdown").countDown(
  targetDate:
    'year': 2013
    'month': 6
    'day': 15
    'hour': 22
    'min': 0
    'sec': 0
  onComplete: reloadPage
)

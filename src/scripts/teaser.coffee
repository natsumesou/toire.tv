"use strict"

reloadPage = ->
  setTimeout ->
    location.reload()
  , 1000


$("#countdown").countDown(
  targetDate:
    'year': 2013
    'month': 6
    'day': 10
    'hour': 0
    'min': 0
    'sec': 0
  onComplete: reloadPage
)

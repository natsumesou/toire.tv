"use strict"

exec = require('child_process').exec
require("../config/boot.js")
config = twitch.config.database
date = new Date()
dateString = date.getFullYear().toString()
dateString += date.getMonth() + 1
dateString += date.getDate()
backupFilename = dateString + '.zip'

backupDir = '/var/mongodb/'

backupCommand ='mongodump' +
  ' --host ' + config.host + ':27017' +
  ' --username ' + config.user +
  ' --password ' + config.password +
  ' --db ' + config.db +
  ' --out ' + backupDir

zipCommand = 'cd ' + backupDir + '; zip -r ' + backupFilename + ' ' + config.db
removeCommand = 'rm -rf ' + backupDir + config.db

console.info(backupCommand)
exec(backupCommand, (err, stdout, stderr) ->
  if err
    console.error(err)
    process.exit(1);
  else
    console.info(zipCommand)
    console.log(stdout)
    exec(zipCommand, (err, stdout, stderr) ->
      if err
        console.error(err)
        process.exit(1)
      else
        console.info(removeCommand)
        console.log(stdout)
        exec(removeCommand, (err, stdout, stderr) ->
          if err
            console.error(err)
            process.exit(1)
          else
            console.log(stdout)
            process.exit(0)
        )
    )
)

"use strict"

###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
config = require("../config/app")
app = express()

# all environments
app.set "port", process.env.PORT or 3001
app.set "views", __dirname + "/views"
app.set "view engine", "ejs"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use app.router
app.use express.static(path.join(__dirname, "public"))

# routers
require("./routes/index.js")(app)

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

module.exports = app

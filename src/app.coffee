"use strict"

###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
app = express()
config = require("../config/app")

# all environments
app.set "port", process.env.PORT or 3001
app.set "views", __dirname + "/views"
app.set "view engine", "ejs"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session(secret: config.app.sessionSecret)
app.use app.router
app.use express.static(path.join(__dirname, "public"))
app.use routes.notFound
app.use routes.internalError if "production" is app.get("env")

# development only
app.use express.errorHandler() if "development" is app.get("env")

app.get "/", routes.index


http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

module.exports = app

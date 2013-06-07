"use strict"

###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
app = express()
RedisStore = require('connect-redis')(express)
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
app.use express.session(secret: config.app.sessionSecret, store: new RedisStore())
app.use app.router
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")

app.get "/", routes.index
app.get "/login", routes.login
app.get "/authorized", routes.authorized
app.get "/user", routes.user

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

module.exports = app

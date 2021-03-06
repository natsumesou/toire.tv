"use strict"

###
Module dependencies.
###
require("../config/boot.js")
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
require("./routes.js")(app)

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

module.exports = app

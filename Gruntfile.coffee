# Generated on 2013-06-04 using generator-webapp 0.2.2
"use strict"

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->
  path = require('path');

  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  # configurable paths
  yeomanConfig =
    app: "app"
    dist: "app/public"
    src: "src"
    test: "test/spec"

  expressConfig =
    port: 3000
    bases: "app"
    server: path.resolve("app/app")

  grunt.initConfig
    yeoman: yeomanConfig

    express:
      server:
        options: expressConfig

    watch:
      options:
        nospawn: true

      coffee:
        files: ["<%= yeoman.src %>/scripts/{,*/}*.coffee"]
        tasks: ["coffee:dist", "uglify"]

      coffeeSrc:
          files: ["<%= yeoman.src %>/*.coffee", "<%= yeoman.src %>/scripts/*.coffee"]
          tasks: ["coffee:src"]

      coffeeTest:
        files: ["test/spec/{,*/}*.coffee"]
        tasks: ["connect:test", "coffee:test", "mocha"]
        options:
          nospawn: false

      compass:
        files: ["<%= yeoman.src %>/styles/{,*/}*.{scss,sass}"]
        tasks: ["compass:server"]

    open:
      server:
        path: "http://localhost:<%= express.server.options.port %>"

    clean:
      dist:
        files: [
          dot: true
          src: ["<%= yeoman.dist %>/*", "!<%= yeoman.dist %>/.git*"]
        ]

    jshint:
      options:
        jshintrc: ".jshintrc"

      all: ["Gruntfile.js", "<%= yeoman.dist %>/{,*/}*.js", "!<%= yeoman.dist %>/javascripts/vendor/*", "test/spec/{,*/}*.js"]

    connect:
      options:
        port: 9000
        hostname: "localhost"
      test:
        options:
          base: "test"

    mocha:
      all:
        options:
          run: true
          urls: ["http://localhost:<%= connect.options.port %>/index.html"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/scripts"
          src: "{,*/}*.coffee"
          dest: "<%= yeoman.dist %>/javascripts"
          ext: ".js"
        ]
      src:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>"
          src: "*.coffee"
          dest: "<%= yeoman.app %>"
          ext: ".js"
        ,
          expand: true
          cwd: "<%= yeoman.src %>/routes"
          src: "{,*/}*.coffee"
          dest: "<%= yeoman.app %>/routes"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "test/spec"
          src: "{,*/}*.coffee"
          dest: "<%= yeoman.test %>"
          ext: ".js"
        ]

    compass:
      options:
        sassDir: "<%= yeoman.src %>/styles"
        cssDir: "<%= yeoman.dist %>/stylesheets"
        generatedImagesDir: ".tmp/images/generated"
        imagesDir: "<%= yeoman.app %>/images"
        javascriptsDir: "<%= yeoman.dist %>/javascripts"
        fontsDir: "<%= yeoman.app %>/stylesheets/fonts"
        importPath: "<%= yeoman.app %>/bower_components"
        httpImagesPath: "/images"
        httpGeneratedImagesPath: "/images/generated"
        relativeAssets: false

      dist: {}
      server:
        options:
          debugInfo: true

    rev:
      dist:
        files:
          src: ["<%= yeoman.dist %>/assets/*.js", "<%= yeoman.dist %>/assets/*.css"]

    useminPrepare:
      html: "<%= yeoman.app %>/views/layoutHead.ejs"
      options:
        dest: "<%= yeoman.dist %>"

    usemin:
      options:
        basedir: "<%= yeoman.dist %>"

      html: ["<%= yeoman.app %>/views/{,*/}*.ejs"]
      css: ["<%= yeoman.dist %>/assets/{,*/}*.css"]

    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "<%= yeoman.dist %>/images"
        ]

    cssmin:
      dist:
        files:
          "<%= yeoman.dist %>/assets/main.css": ["<%= yeoman.dist %>/stylesheets/{,*/}*.css"]

    uglify:
      vendor:
        files: "<%= yeoman.dist %>/assets/vendor.min.js": [
          "<%= yeoman.app %>/bower_components/jquery/jquery.min.js",
          "<%= yeoman.app %>/bower_components/modernizr/modernizr.js",
        ]
      dist:
        files: "<%= yeoman.dist %>/assets/main.min.js": ["<%= yeoman.dist %>/javascripts/{,*/}*.js"]

    concurrent:
      server: ["coffee:dist", "coffee:src", "compass:server"]
      test: ["coffee", "compass"]
      dist: ["coffee", "compass:dist", "imagemin"]

  grunt.registerTask "server", (target) ->
    return grunt.task.run(["build", "open", "express:keepalive"])  if target is "dist"
    grunt.task.run ["concurrent:server", "uglify", "express", "open", "watch"]

  grunt.registerTask "test", ["concurrent:test", "connect:test", "coffee:test", "mocha"]
  grunt.registerTask "build", ["clean:dist", "useminPrepare", "concurrent:dist", "cssmin", "uglify", "rev", "usemin"]
  grunt.registerTask "default", ["test", "build"]

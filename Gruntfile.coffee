# Generated on 2013-06-04 using generator-webapp 0.2.2
"use strict"
LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)


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

  grunt.initConfig
    yeoman: yeomanConfig
    watch:
      options:
        nospawn: true

      coffee:
        files: ["<%= yeoman.src %>/scripts/{,*/}*.coffee"]
        tasks: ["coffee:dist"]

      coffeeSrc:
          files: ["<%= yeoman.src %>/{,*/}*.coffee"]
          tasks: ["coffee:src"]

      coffeeTest:
        files: ["test/spec/{,*/}*.coffee"]
        tasks: ["coffee:test"]

      compass:
        files: ["<%= yeoman.src %>/styles/{,*/}*.{scss,sass}"]
        tasks: ["compass:server"]

      livereload:
        options:
          livereload: LIVERELOAD_PORT

        files: ["<%= yeoman.app %>/public/{,*/}*.html", "{.tmp,<%= yeoman.app %>}/public/{,*/}*.css", "{.tmp,<%= yeoman.app %>}/public/{,*/}*.js"]

    connect:
      options:
        port: 3000

        # change this to '0.0.0.0' to access the server from outside
        hostname: "localhost"

      livereload:
        options:
          middleware: (connect) ->
            [mountFolder(connect, ".tmp"), mountFolder(connect, yeomanConfig.app), lrSnippet]

      test:
        options:
          middleware: (connect) ->
            [mountFolder(connect, ".tmp"), mountFolder(connect, "test")]

      dist:
        options:
          middleware: (connect) ->
            [mountFolder(connect, yeomanConfig.dist)]

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    clean:
      dist:
        files: [
          dot: true
          src: [".tmp", "<%= yeoman.dist %>/*", "!<%= yeoman.dist %>/.git*"]
        ]

      server: ".tmp"

    jshint:
      options:
        jshintrc: ".jshintrc"

      all: ["Gruntfile.js", "<%= yeoman.app %>/public/{,*/}*.js", "!<%= yeoman.app %>/public/javascripts/vendor/*", "test/spec/{,*/}*.js"]

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
          dest: "<%= yeoman.app %>/public/javascripts"
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
          dest: ".tmp/spec"
          ext: ".js"
        ]

    compass:
      options:
        sassDir: "<%= yeoman.src %>/styles"
        cssDir: ".tmp/styles"
        generatedImagesDir: ".tmp/images/generated"
        imagesDir: "<%= yeoman.app %>/images"
        javascriptsDir: "<%= yeoman.app %>/public/javascripts"
        fontsDir: "<%= yeoman.app %>/styles/fonts"
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
          src: ["<%= yeoman.app %>/public/javascripts/{,*/}*.js", "<%= yeoman.app %>/public/stylesheets/{,*/}*.css", "<%= yeoman.app %>/public/images/{,*/}*.{png,jpg,jpeg,gif,webp}"]

    useminPrepare:
      options:
        dest: "<%= yeoman.app %>/public/javascripts"

      html: "<%= yeoman.app %>/views/layoutHead.ejs"

    usemin:
      options:
        dirs: ["<%= yeoman.app %>/public/javascripts"]

      html: ["<%= yeoman.app %>/views/{,*/}*.ejs"]
      css: ["<%= yeoman.app %>/public/stylesheets/{,*/}*.css"]

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
          "<%= yeoman.dist %>/stylesheets/main.css": [".tmp/styles/{,*/}*.css"]

    htmlmin:
      dist:
        options: {}

        #removeCommentsFromCDATA: true,
        #                    // https://github.com/yeoman/grunt-usemin/issues/44
        #                    //collapseWhitespace: true,
        #                    collapseBooleanAttributes: true,
        #                    removeAttributeQuotes: true,
        #                    removeRedundantAttributes: true,
        #                    useShortDoctype: true,
        #                    removeEmptyAttributes: true,
        #                    removeOptionalTags: true
        files: [
          expand: true
          cwd: "<%= yeoman.app %>"
          src: "*.html"
          dest: "<%= yeoman.dist %>"
        ]


    # Put files not handled in other tasks here
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: "<%= yeoman.dist %>"
          src: ["*.{ico,txt}", ".htaccess", "images/{,*/}*.{webp,gif}", "styles/fonts/*"]
        ,
          expand: true
          cwd: ".tmp/images"
          dest: "<%= yeoman.dist %>/images"
          src: ["generated/*"]
        ]

    concurrent:
      server: ["coffee:dist", "coffee:src", "compass:server"]
      test: ["coffee", "compass"]
      dist: ["coffee", "compass:dist", "imagemin", "htmlmin"]

    express:
      server:
        options:
          bases: "app"
          server: path.resolve("app/app")

  grunt.registerTask "server", (target) ->
    return grunt.task.run(["build", "open", "connect:dist:keepalive"])  if target is "dist"
    grunt.task.run ["clean:server", "concurrent:server", "connect:livereload", "open", "watch"]
    #grunt.task.run ["clean:server", "concurrent:server", "express", "open", "watch"]

  grunt.registerTask "test", ["clean:server", "concurrent:test", "connect:test", "mocha"]
  grunt.registerTask "build", ["clean:dist", "useminPrepare", "concurrent:dist", "cssmin", "copy", "rev", "usemin"]
  grunt.registerTask "default", ["jshint", "test", "build"]

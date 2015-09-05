###
  clean.coffee
  クリーン用タスク
###
gulp = require "gulp"
config = require "./config.coffee"

gulp.task "clean", (cb) ->
  del ["./bin"], cb
  return

gulp.task "clean-p", (cb) ->
  del ["./bin-plugins"], cb
  return

gulp.task "clean-prerelease", (cb) ->
  del ["./build-res/prerelease", "./build-res/bin"], cb
  return

gulp.task "clean-all",["clean", "clean-p", "clean-prerelease"], ->
  return

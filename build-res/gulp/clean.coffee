###
  clean.coffee
  クリーン用タスク
###
gulp = require "gulp"
del = require "del"
config = require "./config.coffee"

gulp.task "clean", (cb) ->
  return del ["./bin"], cb

gulp.task "clean-p", (cb) ->
  return del ["./bin-plugins"], cb

gulp.task "clean-prebin", (cb) ->
  return del ["./build-res/bin"], cb

gulp.task "clean-prerelease", (cb) ->
  return del ["./build-res/prerelease"], cb

gulp.task "clean-all",["clean", "clean-p", "clean-prerelease"]

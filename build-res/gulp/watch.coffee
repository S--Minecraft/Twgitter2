###
  watch.coffee
  監視用タスク
###
gulp = require "gulp"
config = require "./config.coffee"

gulp.task "watch", ["default"], ->
  gulp.watch config.path.coffeeSrc, ["coffee"]
  gulp.watch config.path.hamlSrc, ["haml"]
  gulp.watch config.path.scssSrc, ["scss"]
  gulp.watch config.path.javaSrc, ["java"]
  gulp.watch config.path.imgSrc, ["img"]
  gulp.watch config.path.packageJsonSrc, ["package.json"]
  return

gulp.task "watch-p", ["default-p"], ->
  gulp.watch config.path.coffeeSrcP, ["coffee-p"]
  gulp.watch config.path.javaSrcP, ["java-p"]
  gulp.watch config.path.hamlSrcP, ["haml-p"]
  gulp.watch config.path.scssSrcP, ["scss-p"]
  gulp.watch config.path.imgSrcP, ["img-p"]
  return

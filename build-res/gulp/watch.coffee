###
  watch.coffee
  監視用タスク
###
gulp = require "gulp"
electron = require("electron-connect").server.create({
  path: "./bin"
})
config = require "./config.coffee"

browserTask = [config.path.coffeeBin, config.path.javaBin, config.path.packageJsonBin]
rendererTask = [config.path.hamlBin, config.path.scssBin, config.path.imgBin]
gulp.task "watch", ->
  electron.start()
  gulp.watch config.path.coffeeSrc, ["coffee"]
  gulp.watch config.path.hamlSrc, ["haml"]
  gulp.watch config.path.scssSrc, ["scss"]
  gulp.watch config.path.javaSrc, ["java"]
  gulp.watch config.path.imgSrc, ["img"]
  gulp.watch config.path.packageJsonSrc, ["package.json"]
  gulp.watch browserTask, electron.restart()
  gulp.watch rendererTask, electron.reload()
  return

browserTaskP = [config.path.coffeeBinP, config.path.javaBinP]
rendererTaskP = [config.path.hamlBinP, config.path.scssBinP, config.path.imgBinP]
gulp.task "watch-p", ->
  electron.start()
  gulp.watch config.path.coffeeSrcP, ["coffee-p"]
  gulp.watch config.path.javaSrcP, ["java-p"]
  gulp.watch config.path.hamlSrcP, ["haml-p"]
  gulp.watch config.path.scssSrcP, ["scss-p"]
  gulp.watch config.path.imgSrcP, ["img-p"]
  gulp.watch browserTaskP, electron.restart()
  gulp.watch rendererTaskP, electron.reload()
  return

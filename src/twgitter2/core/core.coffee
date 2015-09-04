###
  core.coffee
  実行本体
###
# モジュール読み込み
app = require "app"
Window = require "browser-window"
ut = require "./util.js"
pipe = require "../pipe/pipe.js"
listener = require "../path/listener.js"

# 変数
mainWindow = null

# javaを開始
ut.console.debug "starting java"
java = new pipe()

# guiを起動
app.on "ready", ->
  ut.console.debug "app ready"
  mainWindow = new Window({
    width: 800,
    height: 600
  })
  mainWindow.loadUrl("file://#{__dirname}/../gui/core.html")
  mainWindow.openDevTools()
  ut.console.debug "gui loaded"
  mainWindow.on "closed", ->
    # guiの終了
    mainWindow = null
    return
  return

# gui終了時
app.on "window-all-closed", ->
  # アプリ終了
  if process.platform isnt "darwin"
    app.quit()
  return

###
  core.coffee
  実行本体
###
# モジュール読み込み
app = require "app"
Window = require "browser-window"
client = require("electron-connect").client
ut = require "./util.js"
Pipe = require("../pipe/pipe.js").Pipe

# 変数
mainWindow = null

# javaを開始
java = new Pipe()

# guiを起動
app.on "ready", ->
  ut.console.debug "Ready","app"
  mainWindow = new Window({
    width: 800,
    height: 600
  })
  mainWindow.loadUrl("file://#{__dirname}/../gui/core.html")
  mainWindow.openDevTools()
  ut.console.debug "Loaded","gui"
  mainWindow.on "closed", ->
    # guiの終了
    mainWindow = null
    return
  `//removeIf(production)`
  client.create(mainWindow, {sendBounds: false})
  `//endRemoveIf(production)`
  return

# gui終了時
app.on "window-all-closed", ->
  # アプリ終了
  if process.platform isnt "darwin"
    app.quit()
  return

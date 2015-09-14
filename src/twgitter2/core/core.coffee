###
  core.coffee
  実行本体
###
# モジュール読み込み
path = require "path"
app = require "app"
Window = require "browser-window"
ut = require "./util.js"
Pipe = require "../pipe/pipe.js"
Log = require "./log.js"
profile = require "./profile_core.js"

# 変数
mainWindow = null

# ロガーを開始
Log.start()

# javaを開始
java = new Pipe()

#java.write "test", "ok"

# guiを起動
app.on "ready", ->
  ut.console.debug "Ready","app"
  mainWindow = new Window({
    width: 800,
    height: 600,
    title: "Twgitter2",
    icon: path.join(app.getAppPath(), "twgitter2/gui/img/icon.png"),
    "auto-hide-menu-bar": true
  })
  mainWindow.loadUrl("file://#{app.getAppPath()}/twgitter2/gui/core.html")
  mainWindow.openDevTools()
  ut.console.debug "Loaded","gui"
  # profileのロード
  profile.load()
  # 一つだったらそのまま起動、二つ以上または存在しなかったらプロファイルマネージャーも起動
  if profile.profileJson.length isnt 1
    ut.console.debug "Loading","profileManager"
    profileWindow = profile.create()
    ut.console.debug "Loaded","profileManager"
    profileWindow.on "closed", ->
      # guiの終了
      profileWindow = null
      return
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

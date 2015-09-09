###
  profile_core.coffee
  プロファイルのGUIを生成します
###
fs = require "fs-extra"
path = require "path"
app = require "app"
Window = require "browser-window"
ut = require "./util.js"

jsonPath = "config/profile.json"

module.exports = {
  # profileのjsonのオブジェクトを格納
  profileJson: []
  # profile.jsonを読み込み
  load: ->
    if fs.existsSync(jsonPath)
      @profileJson = fs.readJsonSync(jsonPath)
    else
      fs.outputFileSync(jsonPath, "[]")
      ut.console.debug "Created", "profile.json"
    ut.console.debug "Loaded", "profile.json"
    return
  # profile.jsonを書き込み
  write: (json) ->
    fs.writeJson(jsonPath, json, (err) ->
      if err?
        ut.console.debug "Error", err
    )
  # プロファイルマネージャーを起動
  create: ->
    profileWindow = new Window({
      width: 400,
      height: 600,
      title: "Twgitter2 - ProfileManager",
      icon: path.join(app.getAppPath(), "twgitter2/gui/img/icon.png"),
      "auto-hide-menu-bar": true
    })
    profileWindow.loadUrl("file://#{app.getAppPath()}/twgitter2/gui/profile/profile.html")
    profileWindow.openDevTools()
    return profileWindow
}

###
  core.coffee
  実行本体 gui/core.htmlから呼ばれる
###
# モジュール読み込み
pipe = require "./pipe/pipe.js"
ut = require "./core/util.js"

# javaを開始
pipe.start()
ut.console.debug "started java"

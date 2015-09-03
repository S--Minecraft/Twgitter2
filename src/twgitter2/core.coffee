###
  core.coffee
  実行本体 gui/core.htmlから呼ばれる
###
# モジュール読み込み
path = require "path"
pipe = require(path.resolve("./twgitter2/pipe/pipe.js"))
ut = require(path.resolve("./twgitter2/core/util.js"))

# javaを開始
pipe.start()
ut.console.debug "started java"

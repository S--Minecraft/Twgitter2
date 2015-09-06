###
  util.coffee
  Util
###
Log = require "./log.js"

exports.console = {
  # デバッグ用出力
  debug: (type, text) ->
    console.log "[Debug]#{type}: #{text}"
    Log.add("debug", "#{type}: #{text}")
    return
  # javaから出力
  java: (text) ->
    console.log "[Java]#{text}"
    Log.add("java", "#{text}")
    return
}

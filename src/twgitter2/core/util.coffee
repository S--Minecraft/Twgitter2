###
  util.coffee
  Util
###
exports.console = {
  # デバッグ用出力
  debug: (type, text) ->
    console.log "[Debug]#{type}: #{text}"
    return
  # javaから出力
  java: (text) ->
    console.log "[Java]#{text}"
    return
}


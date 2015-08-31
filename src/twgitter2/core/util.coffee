###
  util.coffee
  Util
###
exports.console = {
  # デバッグ用出力
  debug: (text) ->
    console.log "{\"type\": \"debug\", \"text\": \"#{text}\"}"
    return
  # javaとの情報共有用出力
  java: (text) ->
    console.log "{\"java\": \"java\", \"text\": \"#{text}\"}"
    return
}

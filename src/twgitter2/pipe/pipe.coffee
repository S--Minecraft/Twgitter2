###
  pipe.coffee
  nodeの子プロセスとしてJavaを生成したり、
  その連携を行う
  参考: https://gist.github.com/aoi0308/3008774
###
util = require "util"
path = require "path"
readline = require "readline"
app = require "app"
spawn = require("child_process").spawn
ut = require "../core/util.js"

# 読み込むjavaの開始クラス
startClassName = "Test"
startClassPath = "twgitter2/core" #クラスがある場所のbinからの相対パス jarファイル等
classPath = path.resolve(app.getAppPath(), startClassPath)

# 受信処理
fJava = (text) ->
  messageReg = /\[Message\]/g
  debugReg = /\[Debug\]/g
  switch true
    when messageReg.test(text)
      obj = JSON.parse(text.replace(messageReg, ""))
      # 受け取ったものの処理
    when debugReg.test(text)
      ut.console.java(text)
    else
      ut.console.java("Other: #{text}")
  return

class Pipe
  # javaを実行開始
  constructor: ->
    ut.console.debug "Loading", "java"
    # 子プロセスのjavaを生成
    java = spawn("java",["-classpath", classPath, startClassName])
    # 標準出力を受信する
    @javaRl = readline.createInterface({
      input: java.stdout,  # 通常と逆
      output: java.stdin
    })
    # 受信時
    @javaRl.on "line", (text) ->
      ut.console.debug "Detected Java", "#{text}"
      fJava(text)
      return
    # 終了時
    @javaRl.on "close", ->
      ut.console.debug "Closed","java"
      return
    # エラー時
    java.on "error", (e) ->
      ut.console.debug "Error Java", e.message
      return
    return

  write: (type, text) ->
    if typeof text is "object"
      @javaRl.write("[Node]#{type}: #{JSON.stringify(text)}")
    else
      @javaRl.write("[Node]#{type}: #{text}")
    ut.console.debug "Written node",text
    return

exports.Pipe = Pipe

###
  pipe.coffee
  nodeの子プロセスとしてJavaを生成したり、
  その連携を行う
  参考: https://gist.github.com/aoi0308/3008774
###
util = require "util"
path = require "path"
readline = require "readline"
spawn = require("child_process").spawn
ut = require "../core/util.js"

# 読み込むjavaの開始クラス
startClassName = "Test"
startClassPath = "core" #クラスがある場所のbinからの相対パス jarファイル等
classPath = path.resolve("bin/twgitter2", startClassPath)

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
  return

class Java
  # javaを実行開始
  constructor: (name) ->
    @name = name
    ut.debug.log "path: " + classPath
    # 子プロセスのjavaを生成
    java = spawn("java", ["-classpath", classPath, startClassName])
    # 標準出力を受信する
    @javaRl = readline.createInterface({
      input: java.stdin,
      output: java.stdout
    })
    # 受信時
    @javaRl.on "line", (text) ->
      fJava(text)
      return
    # 終了時
    @javaRl.on "close", ->
      ut.console.debug "Java Closed"
      return
    return
  write: (type, text) ->
    if typeof text is "object"
      @javaRl.write("[Node]#{type}: #{JSON.stringify(text)}")
    else
      @javaRl.write("[Node]#{type}: #{text}")
    return

exports = Java

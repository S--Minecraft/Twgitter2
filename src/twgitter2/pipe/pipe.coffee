###
  pipe.coffee
  nodeの子プロセスとしてJavaを生成したり、
  その連携を行う
  参考: https://gist.github.com/aoi0308/3008774
###
util = require "util"
spawn = require("child_process").spawn
ut = require "../core/util.js"

# 読み込むjavaの開始クラス
startClass = "Test"

# javaを実行開始して、標準入出力を共有
exports.start = ->
  # nodejsの標準入出力を開く
  process.stdin.resume()
  # 子プロセスのjavaを生成
  java = spawn("java", [startClass])
  java.stdin.on("close", ->
    ut.console.debug "Java Closed"
    return
  )
  # 相互転送
  process.stdin.pipe(java.stdin)
  java.stdout.pipe(process.stdout)
  return

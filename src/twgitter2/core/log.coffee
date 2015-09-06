###
  log.coffee
  ログをファイル出力します
###
fs = require "fs-extra"

class Log
  @data : {
    debug: "",
    java: ""
  }
  @ws : {}
  @start: ->
    @ws.debug = fs.createOutputStream "config/debug.txt"
    @ws.java = fs.createOutputStream "config/java.txt"

    return
  @add: (type, text) ->
    switch type
      when "debug"
        @ws.debug.write("#{text}\r\n")
        @data.debug += "#{text}\r\n"
      when "java"
        @ws.java.write("#{text}\r\n")
        @data.java += "#{text}\r\n"
    return

module.exports = Log

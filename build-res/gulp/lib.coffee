###
  lib.coffee
  ライブラリ同封用タスク
###
fs = require "fs-extra"
path = require "path"
gulp = require "gulp"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
flatten = require "gulp-flatten"
watchify = require "gulp-watchify"
bower = require "main-bower-files"
compare = require "version-comparison"
config = require "./config.coffee"
packageJson = require "../../package.json"

# 配列内バージョンの最新を返す
max = ->
  result = arguments[0]
  for arg in arguments
    if compare(arg, result) is 1
      result = arg
  return result

# javaのライブラリのコピー
gulp.task "lib-java-copy", ->
  return gulp.src(["lib/**/*.jar"])
    .pipe(plumber())
    .pipe(changed("bin/lib"))
    .pipe(flatten())
    .pipe(gulp.dest("bin/lib"))

# 重複のライブラリは最新版を残して削除
gulp.task "lib-java-del", ["lib-java-copy"], ->
  files = fs.readdirSync("bin/lib")
  duplicated = []
  for file in files
    duplicated.push(file.match(/(.*)-.*\.jar/)[1])
  duplicated = duplicated.filter( (x, i, self) ->
    return (self.indexOf(x) is i) and (i isnt self.lastIndexOf(x))
  )
  for d in duplicated
    ver = []
    for file in files
      match = file.match(///#{d}-(.*)\.jar///)
      if match?
        ver.push(match[1])
    maxVer = max.apply(null, ver)
    ver = ver.filter( (x, i, self) ->
      return x isnt maxVer
    )
    for v in ver
      fs.unlinkSync("bin/lib/#{d}-#{v}.jar")
  return

# javaのライブラリの同封
gulp.task "lib-java", ["lib-java-del"]

# bowerの同封
gulp.task "lib-bower", ->
  return gulp.src(bower())
    .pipe(plumber())
    .pipe(changed("#{config.path.hamlBin}/lib"))
    .pipe(gulp.dest("#{config.path.hamlBin}/lib"))

# ライブラリの同封
gulp.task "lib", ["lib-java", "lib-bower"]

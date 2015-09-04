# モジュール読み込み
path = require "path"
packageJson = require "./package.json"
del = require "del"
gulp = require "gulp"
plumber = require "gulp-plumber"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
shell = require "gulp-shell"
electron = require "electron-packager"

# ソース位置定義
coffeeSrc = "src/twgitter2/**/*.coffee"
coffeeBin = "bin/twgitter2"
hamlSrc = "src/twgitter2/gui/**/*.haml"
hamlBin = "bin/twgitter2/gui"
scssSrc = "src/twgitter2/gui/css/**/*.scss"
scssBin = "bin/twgitter2/gui/css"
javaSrc = "src/twgitter2/**/*.java"
javaBin = "bin/twgitter2"
imgSrc = "src/twgitter2/gui/img/**"
imgBin = "bin/twgitter2/gui/img"

# タスク定義
gulp.task "coffee", ->
  return gulp.src(coffeeSrc)
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest(coffeeBin))

gulp.task "haml", ->
  return gulp.src(hamlSrc)
    .pipe(plumber())
    .pipe(haml())
    .pipe(gulp.dest(hamlBin))

gulp.task "scss", ->
  return gulp.src(scssSrc)
    .pipe(plumber())
    .pipe(sass())
    .pipe(gulp.dest(scssBin))

gulp.task "java", ->
  return gulp.src(javaSrc)
    .pipe(plumber())
    .pipe(shell([
      "javac -d <%= pathFix(file.path) %> <%= file.path %>"
    ], {
      "templateData": {
        pathFix: (s) ->
          return path.resolve(javaBin, path.relative(path.dirname(javaSrc.replace("**","")), path.dirname(s)))
      }
    }))

gulp.task "img", ->
  return gulp.src(imgSrc)
    .pipe(plumber())
    .pipe(gulp.dest(imgBin))

gulp.task "package.json", ->
  return gulp.src("package.json")
    .pipe(gulp.dest("src"))
    .pipe(gulp.dest("bin"))

###
  clean処理
###
gulp.task "clean", (cb) ->
  del [
    "./bin"
  ], cb
  return

gulp.task "clean-p", (cb) ->
  del [
    "./bin-plugins"
  ], cb
  return

gulp.task "clean-prerelease", (cb) ->
  del [
    "./prerelease"
  ], cb
  return

gulp.task "clean-all",["clean", "clean-p", "clean-prerelease"], ->
  return

###
  監視
###
gulp.task "watch", ["default"], ->
  gulp.watch coffeeSrc, ["coffee"]
  gulp.watch hamlSrc, ["haml"]
  gulp.watch scssSrc, ["scss"]
  gulp.watch javaSrc, ["java"]
  gulp.watch imgSrc, ["img"]
  gulp.watch "package.json", ["package.json"]
  return

###
  実行定義
###
tasks = ["coffee", "haml", "scss", "java", "img", "package.json"]
gulp.task "default", tasks, ->
  return

###
  リリース定義
###
# electronの作成
gulp.task "electron", ["default"], (cb) ->
  electron({
    name: packageJson.name,
    "app-version": packageJson.version,
    version: "0.31.2",
    overwrite: true,
    dir: "./bin",
    cache: "./cache",
    out: "./prerelease",
    platform: ["win32"],
    arch: "ia32"
  }, (err, appPath) ->
    if err?
      console.log err
    console.log "Packed: #{appPath}"
    cb()
    return
  )
  return

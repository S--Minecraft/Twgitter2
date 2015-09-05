# モジュール読み込み
path = require "path"
fs = require "fs"
packageJson = require "./package.json"
del = require "del"
gulp = require "gulp"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
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

coffeeSrcP = "src-plugins/**/*.coffee"
coffeeBinP = "bin-plugins"
javaSrcP = "src-plugins/**/*.java"
javaBinP = "bin-plugins"
hamlSrcP = "src-plugins/**/*.haml"
hamlBinP = "bin-plugins"
scssSrcP = "src-plugins/**/*.scss"
scssBinP = "bin-plugins"
imgSrcP = "src-plugins/**/*.{png,jpg,jpeg,gif,bmp}"
imgBinP = "bin-plugins"

# パッケージング設定
electronVer = "0.31.2"
electronIcon = "./icon.ico"
electronSrc = "./bin"
electronCache = "./build-res/cache"
electronBin = "./build-res/prerelease"
electronPlatform = ["win32", "darwin", "linux"]
electronArch = ["ia32", "x64"]

# タスク定義
###
  本体
###
gulp.task "coffee", ->
  return gulp.src(coffeeSrc)
    .pipe(plumber())
    .pipe(changed(coffeeBin))
    .pipe(coffee())
    .pipe(gulp.dest(coffeeBin))

gulp.task "haml", ->
  return gulp.src(hamlSrc)
    .pipe(plumber())
    .pipe(changed(hamlBin))
    .pipe(haml())
    .pipe(gulp.dest(hamlBin))

gulp.task "scss", ->
  return gulp.src(scssSrc)
    .pipe(plumber())
    .pipe(changed(scssBin))
    .pipe(sass())
    .pipe(gulp.dest(scssBin))

gulp.task "java", ->
  return gulp.src(javaSrc)
    .pipe(plumber())
    .pipe(changed(javaBin))
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
    .pipe(changed(imgBin))
    .pipe(gulp.dest(imgBin))

gulp.task "package.json", ->
  return gulp.src("package.json")
    .pipe(gulp.dest("src"))
    .pipe(changed("bin"))
    .pipe(gulp.dest("bin"))

###
  plugin
###
gulp.task "coffee-p", ->
  return gulp.src(coffeeSrcP)
    .pipe(plumber())
    .pipe(changed(coffeeBinP))
    .pipe(coffee())
    .pipe(gulp.dest(coffeeBinP))

gulp.task "java-p", ->
  return gulp.src(javaSrcP)
    .pipe(plumber())
    .pipe(changed(javaBinP))
    .pipe(shell([
      "javac -d <%= pathFix(file.path) %> <%= file.path %>"
    ], {
      "templateData": {
        pathFix: (s) ->
          return path.resolve(javaBinP, path.relative(path.dirname(javaSrcP.replace("**","")), path.dirname(s)))
      }
    }))

gulp.task "haml-p", ->
  return gulp.src(hamlSrcP)
    .pipe(plumber())
    .pipe(changed(hamlBinP))
    .pipe(haml())
    .pipe(gulp.dest(hamlBinP))

gulp.task "scss-p", ->
  return gulp.src(scssSrcP)
    .pipe(plumber())
    .pipe(changed(scssBinP))
    .pipe(sass())
    .pipe(gulp.dest(scssBinP))

gulp.task "img-p", ->
  return gulp.src(imgSrcP)
    .pipe(plumber())
    .pipe(changed(imgBinP))
    .pipe(gulp.dest(imgBinP))

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

gulp.task "watch-p", ["default-p"], ->
  gulp.watch coffeeSrcP, ["coffee-p"]
  gulp.watch javaSrcP, ["java-p"]
  gulp.watch hamlSrcP, ["haml-p"]
  gulp.watch scssSrcP, ["scss-p"]
  gulp.watch imgSrcP, ["img-p"]
  return

###
  実行定義
###
tasks = ["coffee", "haml", "scss", "java", "img", "package.json"]
gulp.task "default", tasks, ->
  return

tasksP = ["coffee-p", "haml-p", "scss-p", "java-p", "img-p"]
gulp.task "default-p", tasksP, ->
  return

###
  リリース定義
###
# 同封pluginの作成
gulp.task "pack-p", ["default-p", "electron"], ->
  p = gulp.src("bin-plugins/**")
  for platform in electronPlatform
    for arch in electronArch
      p.pipe(gulp.dest(path.join(electronBin, "#{packageJson.name}-#{platform}-#{arch}/plugins")))
  return

# electronの作成
gulp.task "electron", ["default"], (cb) ->
  electron({
    name: packageJson.name,
    "app-version": packageJson.version,
    "app-bundle-id": "s.#{packageJson.name}.app",
    "helper-bundle-id": "s.#{packageJson.name}.app",
    version: electronVer,
    ### ファイルが読み込めないというエラーが発生する
    icon: electronIcon,
    "version-string": {
      ProductName: packageJson.name,
      ProductVersion: packageJson.version,
      FileDescription: packageJson.description,
      CompanyName: packageJson.author,
      LegalCopyright: "(C) #{packageJson.author} 2015-"
    }
    ###
    overwrite: true,
    dir: electronSrc,
    cache: electronCache,
    out: electronBin,
    prune: true,
    platform: electronPlatform,
    arch: electronArch
  }, (err, appPath) ->
    if err?
      console.log err
    console.log "Packed: #{appPath}"
    cb()
    return
  )
  return

# pluginを含んだelectronの作成
gulp.task "prerelease", ["pack-p"], ->
  return

# Todo: libのビルド
# Todo: 不要ファイルを消してreleaseをビルドする

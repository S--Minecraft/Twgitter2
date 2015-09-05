###
  release.coffee
  リリース用タスク
###
path = require "path"
gulp = require "gulp"
removeCode = require "gulp-remove-code"
electron = require "electron-packager"
packageJson = require "../../package.json"
config = require "./config.coffee"

# リリース用binへコピー
gulp.task "copy-bin", ["default"], ->
  return gulp.src("bin/**")
    .pipe(gulp.dest("build-res/bin"))

# core.html内のテスト用コードの除去
gulp.task "rmv-livereload-haml", ["copy-bin"], ->
  return gulp.src(config.path.hamlBin + "/core.html")
    .pipe(removeCode({production: true}))
    .pipe(gulp.dest("build-res/" + config.path.hamlBin))

# core.js内のテスト用コードの除去
gulp.task "rmv-livereload-js", ["copy-bin"], ->
  return gulp.src(config.path.coffeeBin + "/core/core.js")
    .pipe(removeCode({production: true, commentStart:"//" ,commentEnd: ";"}))
    .pipe(gulp.dest("build-res/" + config.path.coffeeBin + "/core"))

# テスト用コードの除去
gulp.task "rmv-livereload", ["rmv-livereload-haml", "rmv-livereload-js"], ->
  return

# electronの作成
gulp.task "electron", ["rmv-livereload"], (cb) ->
  electron({
    name: packageJson.name,
    "app-version": packageJson.version,
    "app-bundle-id": "s.#{packageJson.name}.app",
    "helper-bundle-id": "s.#{packageJson.name}.app",
    version: config.electron.ver,
    ### ファイルが読み込めないというエラーが発生する
    icon: config.electron.icon,
    "version-string": {
      ProductName: packageJson.name,
      ProductVersion: packageJson.version,
      FileDescription: packageJson.description,
      CompanyName: packageJson.author,
      LegalCopyright: "(C) #{packageJson.author} 2015-"
    }
    ###
    overwrite: true,
    dir: config.electron.src,
    cache: config.electron.cache,
    out: config.electron.bin,
    prune: true,
    platform: config.electron.platform,
    arch: config.electron.arch
  }, (err, appPath) ->
    if err?
      console.log err
    console.log "Packed: #{appPath}"
    cb()
    return
  )
  return

# 同封pluginの作成
gulp.task "pack-p", ["default-p", "electron"], ->
  p = gulp.src("bin-plugins/**")
  for platform in config.electron.platform
    for arch in config.electron.arch
      p.pipe(gulp.dest(path.join(config.electron.bin, "#{packageJson.name}-#{platform}-#{arch}/plugins")))
  return

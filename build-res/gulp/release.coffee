###
  release.coffee
  リリース用タスク
###
path = require "path"
gulp = require "gulp"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
electron = require "electron-packager"
packageJson = require "../../package.json"
config = require "./config.coffee"

# リリース用のためにコピー
gulp.task "copy-release", ["default", "lib-node"], ->
  gulp.src(["bin/**"])
    .pipe(plumber())
    .pipe(changed(config.electron.src))
    .pipe(gulp.dest(config.electron.src))
  return

# electronの作成
gulp.task "electron", ["copy-release"], (cb) ->
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
  p = gulp.src("bin-plugins/**").pipe(plumber())
  for platform in config.electron.platform
    for arch in config.electron.arch
      p.pipe(gulp.dest(path.join(config.electron.bin, "#{packageJson.name}-#{platform}-#{arch}/plugins")))
  return

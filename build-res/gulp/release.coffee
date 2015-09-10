###
  release.coffee
  リリース用タスク
###
path = require "path"
gulp = require "gulp"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
electron = require "electron-packager"
webpack = require "gulp-webpack"
runSequence = require "run-sequence"
packageJson = require "../../package.json"
config = require "./config.coffee"

# リリース用のためにコピー
gulp.task "copy-release1", ->
  return gulp.src(["bin/**", "!bin/**/*.js"])
    .pipe(plumber())
    .pipe(changed(config.electron.src))
    .pipe(gulp.dest(config.electron.src))
gulp.task "copy-release2", ->
  return gulp.src(["bin/**/gui/**/*.js"])
    .pipe(plumber())
    .pipe(changed(config.electron.src))
    .pipe(gulp.dest(config.electron.src))
# webpackで圧縮
gulp.task "webpack", ->
  return gulp.src(["bin/**/*.js", "!bin/**/gui/**"])
    .pipe(webpack(require("./webpack.config.coffee")))
    .pipe(gulp.dest(config.electron.src + "/twgitter2/core"))
# remoteで読み込むjs(間接含む)はコピー
remote = [
  "util.js",
  "profile_core.js",
  "log.js"
]
gulp.task "copy-remote", ->
  return gulp.src(remote, {cwd: "#{config.path.coffeeBin}/core"})
    .pipe(gulp.dest("#{config.electron.src}/twgitter2/core"))
gulp.task "pack", (cb) ->
  return runSequence(
    ["clean", "clean-prebin"],
    "default",
    ["copy-release1", "copy-release2", "webpack"],
    "copy-remote",
    cb
  )


# electronの作成
gulp.task "electron", ["pack"], (cb) ->
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
gulp.task "pack-p", ->
  p = gulp.src("bin-plugins/**").pipe(plumber())
  for platform in config.electron.platform
    for arch in config.electron.arch
      p.pipe(gulp.dest(path.join(config.electron.bin, "#{packageJson.name}-#{platform}-#{arch}/plugins")))
  return

gulp.task "copy-p", (cb) ->
  return runSequence(
    "clean-p",
    "default-p",
    "electron",
    "pack-p",
    cb
  )


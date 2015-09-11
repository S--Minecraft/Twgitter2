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
replace = require "gulp-replace"
watchify = require "gulp-watchify"
runSequence = require "run-sequence"
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
gulp.task "lib-java-del", ->
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
gulp.task "lib-java", (cb) ->
  return runSequence(
    "lib-java-copy",
    "lib-java-del",
    cb
  )

# bowerの同封
gulp.task "lib-bower-all", ->
  return gulp.src(bower())
    .pipe(plumber())
    .pipe(changed("#{config.path.hamlBin}/lib"))
    .pipe(gulp.dest("#{config.path.hamlBin}/lib"))

# uikitのcssのfontのパスの修正
gulp.task "lib-bower-fix", ->
  return gulp.src("#{config.path.hamlBin}/lib/uikit.min.css")
    .pipe(plumber())
    .pipe(changed("#{config.path.hamlBin}/lib/uikit.min.css"))
    .pipe(replace(/url\(\.\.\/fonts\//g, "url("))
    .pipe(gulp.dest("#{config.path.hamlBin}/lib"))

gulp.task "lib-bower", (cb) ->
  return runSequence(
    "lib-bower-all",
    "lib-bower-fix",
    cb
  )

###
# node.jsのモジュールを圧縮/同封
gulp.task "lib-node-js", ->
  files = []
  for key of packageJson.dependencies
    main = fs.readJsonSync("./node_modules/#{key}/package.json").main
    if not main?
      main = "index.js"
    if path.extname(main) is ""
      main += ".js"
    files.push(path.normalize("./node_modules/#{key}/#{main}"))
  return gulp.src(files)
    .pipe(foreach( (stream, file) ->
      fileName = path.basename(file.path)
      fileOut = path.dirname( path.join(config.electron.src, path.relative("./", file.path)) )
      return stream
        .pipe(plumber())
        .pipe(changed(fileOut))
        .pipe(webpack(
            wpDCfg(file.path, fileName)
        ))
        .pipe(gulp.dest(fileOut))
    ))
# node.jsのモジュールのpackage.jsonを同封
gulp.task "lib-node-json", ->
  files = []
  for key of packageJson.dependencies
    files.push("./node_modules/#{key}/package.json")
  return gulp.src(files, {base: "./"})
    .pipe(plumber())
    .pipe(changed(config.electron.src))
    .pipe(gulp.dest(config.electron.src))
gulp.task "lib-node", ["lib-node-js", "lib-node-json"]
###
gulp.task "lib-node", ->
  files = []
  for key of packageJson.dependencies
    files.push("./node_modules/#{key}/**")
  return gulp.src(files, {base: "./"})
    .pipe(plumber())
    .pipe(changed(config.electron.src))
    .pipe(gulp.dest(config.electron.src))

# ライブラリの同封(node除く)
gulp.task "lib", ["lib-java", "lib-bower"]

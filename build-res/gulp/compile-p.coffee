###
  compile-p.coffee
  プラグインのコンパイル用タスク
###
path = require "path"
gulp = require "gulp"
notify = require "gulp-notify"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
foreach = require "gulp-foreach"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
exec = require "gulp-exec"
prettify = require "gulp-prettify"
config = require "./config.coffee"

gulp.task "coffee-p", ->
  return gulp.src(config.path.coffeeSrcP)
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed(config.path.coffeeBinP))
    .pipe(coffee())
    .pipe(gulp.dest(config.path.coffeeBinP))

gulp.task "haml-p", ->
  return gulp.src(config.path.hamlSrcP)
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed(config.path.hamlBinP))
    .pipe(haml())
    .pipe(prettify({indent_size: 2}))
    .pipe(gulp.dest(config.path.hamlBinP))

gulp.task "scss-p", ->
  return gulp.src(config.path.scssSrcP)
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed(config.path.scssBinP))
    .pipe(sass())
    .pipe(gulp.dest(config.path.scssBinP))

gulp.task "java-p", ->
  return gulp.src(config.path.javaSrcP)
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed(config.path.javaBinP))
    .pipe(foreach( (stream, file) ->
      bin = path.normalize("../bin-plugins")
      place = path.relative("src-plugins", file.path)
      return stream
        .pipe(exec("cd src-plugins & javac -d <%= options.bin %> <%= options.place %>", {bin: bin, place: place}))
    ))

gulp.task "img-p", ->
  return gulp.src(config.path.imgSrcP)
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed(config.path.imgBinP))
    .pipe(gulp.dest(config.path.imgBinP))

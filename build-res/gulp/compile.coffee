###
  compile.coffee
  本体のコンパイル用タスク
###
path = require "path"
gulp = require "gulp"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
foreach = require "gulp-foreach"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
exec = require "gulp-exec"
prettify = require "gulp-prettify"
config = require "./config.coffee"

gulp.task "coffee", ->
  return gulp.src(config.path.coffeeSrc)
    .pipe(plumber())
    .pipe(changed(config.path.coffeeBin))
    .pipe(coffee())
    .pipe(gulp.dest(config.path.coffeeBin))

gulp.task "haml", ->
  return gulp.src(config.path.hamlSrc)
    .pipe(plumber())
    .pipe(changed(config.path.hamlBin))
    .pipe(haml())
    .pipe(prettify({indent_size: 2}))
    .pipe(gulp.dest(config.path.hamlBin))

gulp.task "scss", ->
  return gulp.src(config.path.scssSrc)
    .pipe(plumber())
    .pipe(changed(config.path.scssBin))
    .pipe(sass())
    .pipe(gulp.dest(config.path.scssBin))

gulp.task "java", ->
  return gulp.src(config.path.javaSrc)
    .pipe(plumber())
    .pipe(changed(config.path.javaBin))
    .pipe(foreach( (stream, file) ->
      place = path.resolve(config.path.javaBin, path.relative(path.dirname(config.path.javaSrc.replace("**","")), path.dirname(file.path)))
      return stream
        .pipe(exec("javac -d <%= options.place %> <%= file.path %>", {place: place}))
    ))

gulp.task "img", ->
  return gulp.src(config.path.imgSrc)
    .pipe(plumber())
    .pipe(changed(config.path.imgBin))
    .pipe(gulp.dest(config.path.imgBin))

gulp.task "package.json", ->
  return gulp.src(config.path.packageJsonSrc)
    .pipe(plumber())
    .pipe(gulp.dest("src"))
    .pipe(gulp.dest(config.path.packageJsonBin))

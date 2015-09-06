###
  compile-p.coffee
  プラグインのコンパイル用タスク
###
path = require "path"
gulp = require "gulp"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
shell = require "gulp-shell"
prettify = require "gulp-prettify"
config = require "./config.coffee"

gulp.task "coffee-p", ->
  return gulp.src(config.path.coffeeSrcP)
    .pipe(plumber())
    .pipe(changed(config.path.coffeeBinP))
    .pipe(coffee())
    .pipe(gulp.dest(config.path.coffeeBinP))

gulp.task "haml-p", ->
  return gulp.src(config.path.hamlSrcP)
    .pipe(plumber())
    .pipe(changed(config.path.hamlBinP))
    .pipe(haml())
    .pipe(prettify({indent_size: 2}))
    .pipe(gulp.dest(config.path.hamlBinP))

gulp.task "scss-p", ->
  return gulp.src(config.path.scssSrcP)
    .pipe(plumber())
    .pipe(changed(config.path.scssBinP))
    .pipe(sass())
    .pipe(gulp.dest(config.path.scssBinP))

gulp.task "java-p", ->
  return gulp.src(config.path.javaSrcP)
    .pipe(plumber())
    .pipe(changed(config.path.javaBinP))
    .pipe(shell([
      "javac -d <%= pathFix(file.path) %> <%= file.path %>"
    ], {
      "templateData": {
        pathFix: (s) ->
          return path.resolve(config.path.javaBinP, path.relative(path.dirname(config.path.javaSrcP.replace("**","")), path.dirname(s)))
      }
    }))

gulp.task "img-p", ->
  return gulp.src(config.path.imgSrcP)
    .pipe(plumber())
    .pipe(changed(config.path.imgBinP))
    .pipe(gulp.dest(config.path.imgBinP))

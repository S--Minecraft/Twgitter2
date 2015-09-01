# モジュール読み込み
path = require "path"
gulp = require "gulp"
plumber = require "gulp-plumber"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
shell = require "gulp-shell"

# ソース位置定義
coffeeSrc = "src/twgitter2/**/*.coffee"
coffeeBin = "bin/twgitter2"
hamlSrc = "src/twgitter2/gui/**/*.haml"
hamlBin = "bin/twgitter2/gui"
scssSrc = "src/twgitter2/gui/css/**/*.scss"
scssBin = "bin/twgitter2/gui/css"
javaSrc = "*.java"
javaBin = "./"

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
          return path.resolve(javaBin, path.relative(path.dirname(javaSrc), path.dirname(s)))
      }
    }))

# 監視
gulp.task "watch", ->
  gulp.watch "src", ["default"]
  return

# 実行定義
tasks = ["coffee", "haml", "scss", "java"]
gulp.task "default", tasks, ->
  console.log "done"
  return

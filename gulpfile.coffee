# モジュール読み込み
gulp = require "gulp"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"

# ソース位置定義
coffeeSrc = "src/twgitter2/**/*.coffee"
coffeeBin = "bin/twgitter2"
hamlSrc = "src/twgitter2/gui/**/*.haml"
hamlBin = "bin/twgitter2/gui"
scssSrc = "src/twgitter2/gui/css/**/*.scss"
scssBin = "bin/twgitter2/gui/css"

# タスク定義
gulp.task "coffee", ->
  return gulp.src(coffeeSrc)
    .pipe(coffee())
    .pipe(gulp.dest(coffeeBin))

gulp.task "haml", ->
  return gulp.src(hamlSrc)
    .pipe(haml())
    .pipe(gulp.dest(hamlBin))

gulp.task "scss", ->
  return gulp.src(scssSrc)
    .pipe(sass())
    .pipe(gulp.dest(scssBin))

# 実行定義
tasks = ["coffee", "haml", "scss"]
gulp.task "default", tasks, ->
  console.log "done"
  return

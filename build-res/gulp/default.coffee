###
  default.coffee
  実行タスク
###
gulp = require "gulp"

# 本体のコンパイル
tasks = ["coffee", "haml", "scss", "java", "img", "package.json"]
gulp.task "default", tasks

# プラグインのコンパイル
tasksP = ["coffee-p", "haml-p", "scss-p", "java-p", "img-p"]
gulp.task "default-p", tasksP

# pluginを含んだelectronの作成
gulp.task "prerelease", ["pack-p"]

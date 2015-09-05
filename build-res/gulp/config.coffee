###
  config.coffee
  gulp config
###
# ソース位置定義
path = {
  coffeeSrc : "src/twgitter2/**/*.coffee",
  coffeeBin : "bin/twgitter2",
  hamlSrc : "src/twgitter2/gui/**/*.haml",
  hamlBin : "bin/twgitter2/gui",
  scssSrc : "src/twgitter2/gui/css/**/*.scss",
  scssBin : "bin/twgitter2/gui/css",
  javaSrc : "src/twgitter2/**/*.java",
  javaBin : "bin/twgitter2",
  imgSrc : "src/twgitter2/gui/img/**",
  imgBin : "bin/twgitter2/gui/img",
  packageJsonSrc : "package.json",
  packageJsonBin : "bin",
  coffeeSrcP : "src-plugins/**/*.coffee",
  coffeeBinP : "bin-plugins",
  javaSrcP : "src-plugins/**/*.java",
  javaBinP : "bin-plugins",
  hamlSrcP : "src-plugins/**/*.haml",
  hamlBinP : "bin-plugins",
  scssSrcP : "src-plugins/**/*.scss",
  scssBinP : "bin-plugins",
  imgSrcP : "src-plugins/**/*.{png,jpg,jpeg,gif,bmp}",
  imgBinP : "bin-plugins"
}

# パッケージング設定
electron = {
  ver : "0.31.2",
  icon : "./icon.ico",
  src : "./bin",
  cache : "./build-res/cache",
  bin : "./build-res/prerelease",
  platform : ["win32", "darwin", "linux"],
  arch : ["ia32", "x64"]
}

module.exports = {
  path: path,
  electron: electron
}

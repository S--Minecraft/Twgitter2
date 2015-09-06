# Twgitter2 [![GitHub version](https://badge.fury.io/gh/S--Minecraft%2FTwgitter2.svg)](http://badge.fury.io/gh/S--Minecraft%2FTwgitter2) ![David Badge](https://david-dm.org/S--Minecraft/Twgitter2.svg "David Badge") ![David Dev Badge](https://david-dm.org/s--minecraft/twgitter2/dev-status.svg "David Dev Badge")
2nd version of Twgitter the client for twitter, gitter, and so on.
It's made in electron and node.js and Java.

This is a client for
[Twitter](https://twitter.com/),
[App.net](https://app.net/),
[Croudia](https://croudia.com/),
[Gittter](https://gitter.im/),
[IRC](http://en.wikipedia.org/wiki/Internet_Relay_Chat), and
[Slack](https://slack.com/).

========
## build
```cmd
git clone --recursive git://github.com/S--Minecraft/Twgitter2.git
cd Twgitter2
npm install
npm run install- #モジュールアップデート時は必要ありません
npm run install--
```

### compile
```cmd
compile
```

### start
```
start
```

### pack
```cmd
prerelease
```

## dependencies
bower
- for managing browser javascript libraries

node-java-maven
-  for using maven with node

fs-extra
- for using fs better

electron-prebuilt
- for executing without packing

require-dir
- for requiring directories in gulp

gulp
-  for compiling node
 + gulp-plumber
   - for doing better with gulp watch task
 + gulp-changed
   - for compiling only changed files
 + gulp-flatten
   - for copying java libraries
 + gulp-coffee
 + gulp-sass
 + gulp-haml
   - for compiling coffeescript/sass/haml
 + gulp-shell
   - for compiling java
 + gulp-prettify
   - for formating html from haml
 + gulp-watchify
   - for compressing node modules

electron-packager
- for packing with electron

del
- for cleaning in gulp

coffee-script
- for executing gulp

main-bower-files
- for extracting main files from bower for gulp

version-comparison
- for comparing versions of maven

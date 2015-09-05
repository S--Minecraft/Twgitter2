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
```

## dependencies
fs-extra
- for using fs better

electron-prebuilt
- for executing without packing

node-java-maven
-  for using maven with node

gulp
-  for compiling node
 + gulp-plumber
   - for doing better with gulp watch task
 + gulp-changed
   - for compiling only changed files
 + gulp-coffee
 + gulp-sass
 + gulp-haml
   - for compiling coffeescript/sass/haml
 + gulp-shell
   - for compiling java
 + gulp-prettify
   - for formating html from haml

electron-packager
- for packing with electron

del
- for cleaning in gulp

coffee-script
-  for executing gulp

# Twgitter2
2nd version of Twgitter the client for twitter, gitter, and so on.
It's made in electron and node.js and Java.

========

A client.

This is a java/node.js made client for
Twitter(https://twitter.com/),
App.net(https://app.net/),
Croudia(https://croudia.com/),
Gittter(https://gitter.im/),
IRC(http://en.wikipedia.org/wiki/Internet_Relay_Chat), and
Slack(https://slack.com/).

========

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

webpack = require "webpack"
packageJson = require "../../package.json"
config = require "./config.coffee"
defaultConfig = require "./webpack-default.config.coffee"

module.exports = defaultConfig("./bin/" + packageJson.main, "core.js")

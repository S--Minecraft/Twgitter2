webpack = require "webpack"
packageJson = require "../../package.json"
config = require "./config.coffee"

module.exports = (app, filename) ->
  return {
    entry: {
      app: app
    },
    output: {
      filename: filename
    },
    target: "atom",
    plugins: [
      new webpack.optimize.UglifyJsPlugin
        compress: {
          warnings: false
        },
        sourceMap: false,
        mangle: true
    ]
  }

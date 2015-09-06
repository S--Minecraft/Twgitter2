webpack = require "webpack"
packageJson = require "../../package.json"
config = require "./config.coffee"

module.exports = {
  entry: {
    app: "./bin/" + packageJson.main
  },
  output: {
    filename: "core.js"
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

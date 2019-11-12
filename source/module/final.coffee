_ = require 'lodash'

# return
module.exports = (cont) ->

  # return
  [
    '; transpiled by coffee-basic'
    ''
    '#NoEnv'
    '#Persistent'
    '#SingleInstance Force'
    '#UseHook'
    ''
    'CoordMode Mouse, Client'
    'CoordMode Pixel, Client'
    'SendMode Event'
    'SetKeyDelay 0, 50'
    'SetMouseDelay 0, 50'
    ''
    cont.trim()
  ].join '\n'
  .trim()
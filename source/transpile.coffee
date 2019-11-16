$ = require 'fire-keeper'

# function

class Content

  constructor: (@raw) ->
    
    @bind = []
    @foot = []
    @function = []
    @global = []
    @head = []
    @mode = []

    @main = "#{@raw}\n"
    .replace /\r/g, ''
    .replace /\n{2,}/g, '\n'
    .split '\n'

    @ # return

  # ---

  getDepth: require './fn/getDepth'
  setDepth: require './fn/setDepth'
  trim: require './fn/trim'
  unquote: require './fn/unquote'

  # ---

  i: (input) ->
    console.log input
    input # return

  # ---

  buildIn: require './module/build-in'
  call: require './module/call'
  format: require './module/format'
  getBind: require './module/getBind'
  getFunction: require './module/getFunction'
  getGlobal: require './module/getGlobal'
  getMode: require './module/getMode'
  removeComment: require './module/removeComment'
  render: require './module/render'
  replaceFor: require './module/replaceFor'
  replaceIf: require './module/replaceIf'
  replaceLoop: require './module/replaceLoop'
  setFoot: require './module/setFoot'
  setHead: require './module/setHead'
  setMain: require './module/setMain'
  validate: require './module/validate'

  # ---

  execute: (option) ->

    unless @validate()
      return ''

    @getMode()

    @removeComment()

    @getGlobal()
    @getFunction()
    @getBind()

    @setMain()
    unless option.bare
      @setHead()
      @setFoot()

    @format()

    @replaceIf()
    @replaceFor()
    @replaceLoop()

    @call()
    @buildIn()

    @render()
    
# return
module.exports = (source, option = {}) ->
  (new Content source).execute option
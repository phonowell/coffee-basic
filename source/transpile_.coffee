$ = require 'fire-keeper'

# function

class Content

  constructor: (@raw, @option) ->
    
    @bind = []
    @foot = []
    @function = []
    @global = []
    @head = []
    @mode = []

    @ # return

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
  include_: require './module/include_'
  render: require './module/render'
  replaceFor: require './module/replaceFor'
  replaceIf: require './module/replaceIf'
  replaceLoop: require './module/replaceLoop'
  setFoot: require './module/setFoot'
  setHead: require './module/setHead'
  setMain: require './module/setMain'
  validate: require './module/validate'

  # ---

  execute_: ->

    await @include_()

    unless @validate()
      return ''

    @getMode()
    @format()

    @getGlobal()
    @getFunction()
    @getBind()

    @setMain()
    unless @option.bare
      @setHead()
      @setFoot()

    @replaceIf()
    @replaceFor()
    @replaceLoop()

    @call()
    @buildIn()

    @render()
    
# return
module.exports = (source, option = {}) ->
  await (new Content source, option).execute_()
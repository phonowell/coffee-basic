# return
module.exports = ->
  
  @head = [
    '; transpiled by coffee-basic'
  ]

  if @mode.includes 'admin'

    @head = [
      @head...
      ''
      'if (A_IsAdmin != true) {'
      '  Run *RunAs "%A_ScriptFullPath%"'
      '  ExitApp'
      '}'
    ]

  @head = [
    @head...
    ''
    '#NoEnv'
    '#Persistent'
    '#SingleInstance Force'
    '#UseHook'
    ''
    'CoordMode Mouse, Client'
    'CoordMode Pixel, Client'
    'CoordMode ToolTip, Client'
    'SendMode Event'
    'SetKeyDelay 0, 50'
    'SetMouseDelay 0, 50'
  ]
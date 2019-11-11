# return
module.exports = (cont) ->

  # return
  [
    '; transpiled by coffee-basic'
    ''
    '#noEnv'
    '#persistent'
    '#singleInstance force'
    '#useHook'
    ''
    'SetKeyDelay 0, 50'
    'SendMode Event'
    ''
    cont.trim()
  ].join '\n'
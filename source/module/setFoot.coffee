# return
module.exports = ->

  @foot = [
    '; eof'
  ]

  if (@main.join '\n').trim()
    @foot = [
      '; execute'
      '__fn_main__()'
      ''
      @foot...
    ]
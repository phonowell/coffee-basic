# return
module.exports = ->

  unless @raw.startsWith '# use'
    return

  @mode = @main[0]
  .replace '# use', ''
  .trim()
  .split '/'
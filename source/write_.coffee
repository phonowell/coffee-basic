$ = require 'fire-keeper'

# export
module.exports = (path, cont) ->

  {basename, dirname} = $.getName path
  extname = '.ahk'

  await $.write_ "#{dirname}/#{basename}#{extname}", cont
# return
module.exports = (cont) ->

  cont
  .replace /=/g, ':='
  .replace /:=:=/g, '=='
  .replace /([><!]):=/g, '$1='
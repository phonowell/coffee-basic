# return
module.exports = (cont) ->

  unless cont.includes 'loop'
    return cont

  cont
  .replace /\$\.loop\s*?(.*?),?\s*?->/g, 'loop $1'
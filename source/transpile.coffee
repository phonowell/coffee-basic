$ = require 'fire-keeper'

# return
module.exports = (source) ->

  cont = source

  unless result = (require './validate') cont
    return ''

  cont = (require './format') cont

  cont = (require './comment') cont

  cont = (require './on') cont
  cont = (require './function') cont
  cont = (require './variable') cont

  cont = (require './buildin') cont

  cont = (require './format') cont

  cont = (require './final') cont

  cont # return
$ = require 'fire-keeper'

# return
module.exports = (source) ->

  cont = source

  unless result = (require './validate') cont
    return ''

  cont = (require './comment') cont
  cont = (require './format') cont

  cont = (require './if') cont
  cont = (require './for') cont

  cont = (require './on') cont
  cont = (require './function') cont

  cont = (require './buildin') cont
  cont = (require './press') cont
  cont = (require './find') cont
  cont = (require './getColor') cont

  cont = (require './variable') cont
  cont = (require './format') cont

  cont = (require './final') cont

  cont # return
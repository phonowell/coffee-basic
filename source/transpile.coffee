$ = require 'fire-keeper'

# return
module.exports = (source) ->

  cont = source

  unless result = (require './module/validate') cont
    return ''

  cont = (require './module/comment') cont
  cont = (require './module/format') cont

  cont = (require './module/if') cont
  cont = (require './module/for') cont

  cont = (require './module/on') cont
  cont = (require './module/function') cont

  cont = (require './module/buildin') cont
  cont = (require './module/press') cont
  cont = (require './module/find') cont
  cont = (require './module/getColor') cont
  cont = (require './module/getPosition') cont

  cont = (require './module/variable') cont
  cont = (require './module/unquote') cont
  cont = (require './module/format') cont

  cont = (require './module/final') cont

  cont # return
# use admin

# skill

内静 = ->
  $.press 'alt:down', '1', 'alt:up'
  await $.sleep 1500
阔步 = ->
  $.press 'alt:down', '2', 'alt:up'
  await $.sleep 1500
稳手II = ->
  $.press 'alt:down', '3', 'alt:up'
  await $.sleep 1500
上级加工 = ->
  $.press 'alt:down', '4', 'alt:up'
  await $.sleep 2500
比尔格的祝福 = ->
  $.press 'alt:down', '5', 'alt:up'
  await $.sleep 2500
模范制作III = ->
  $.press 'alt:down', '6', 'alt:up'
  await $.sleep 2500
掌握II = ->
  $.press 'alt:down', '7', 'alt:up'
  await $.sleep 1500
俭约加工 = ->
  $.press 'alt:down', '8', 'alt:up'
  await $.sleep 2500
坯料加工 = ->
  $.press 'alt:down', '9', 'alt:up'
  await $.sleep 2500
再利用 = ->
  $.press 'alt:down', '0', 'alt:up'
  await $.sleep 1500
精密制作 = ->
  $.press 'alt:down', 'minus', 'alt:up'
  await $.sleep 2500
工匠的神速技巧 = ->
  $.press 'alt:down', 'equal', 'alt:up'
  await $.sleep 2500
工匠的苦行 = ->
  $.press 'ctrl:down', '1', 'ctrl:up'
  await $.sleep 2500
新颖II = ->
  $.press 'ctrl:down', '7', 'ctrl:up'
  await $.sleep 1500
渐进 = ->
  $.press 'ctrl:down', '8', 'ctrl:up'
  await $.sleep 1500
改革 = ->
  $.press 'ctrl:down', '9', 'ctrl:up'
  await $.sleep 1500
俭约II = ->
  $.press 'ctrl:down', '0', 'ctrl:up'
  await $.sleep 1500
安逸 = ->
  $.press 'ctrl:down', 'minus', 'ctrl:up'
  await $.sleep 1500
回收 = ->
  $.press 'ctrl:down', 'equal', 'ctrl:up'
  await $.sleep 1500
坚信 = ->
  $.press 'shift:down', '1', 'shift:up'
  await $.sleep 2500

# ---

回收利用 = ->
  $.press 'alt:down', '0', 'alt:up'
  $.press 'ctrl:down', 'equal', 'ctrl:up'
  await $.sleep 1500

# function

execute = ->
  
  稳手II()
  坯料加工()
  坯料加工()

  回收利用()

  await $.sleep 500

  status = find '再利用'
  if status
    模范制作III()
  else
    坯料加工()
    坯料加工()

find = (name) ->

  [x, y] = $.find "#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

restart = ->
  await $.sleep 2e3
  $.press 'numpad0'
  await $.sleep 500
  $.press 'numpad0'
  await $.sleep 500
  $.press 'numpad0'
  await $.sleep 1e3

# bind

$.on 'f12', ->
  $.beep()
  $.exit()

$.on 'f9', ->
  [x, y] = $.getPosition()
  # x = 265
  # y = 40
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

# ---

$.on 'f2', ->
  $.loop ->
    execute()
    restart()
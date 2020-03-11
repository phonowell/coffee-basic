# use admin

# const

count = 0
limit = 20

# skill

内静 = ->
  $.press 'alt + 1'
  await $.sleep 1500
阔步 = ->
  $.press 'alt + 2'
  await $.sleep 1500
稳手II = ->
  $.press 'alt + 3'
  await $.sleep 1500
上级加工 = ->
  $.press 'alt + 4'
  await $.sleep 2500
比尔格的祝福 = ->
  $.press 'alt + 5'
  await $.sleep 2500
模范制作III = ->
  $.press 'alt + 6'
  await $.sleep 2500
掌握II = ->
  $.press 'alt + 7'
  await $.sleep 1500
俭约加工 = ->
  $.press 'alt + 8'
  await $.sleep 2500
坯料加工 = ->
  $.press 'alt + 9'
  await $.sleep 2500
再利用 = ->
  $.press 'alt + 0'
  await $.sleep 1500
精密制作 = ->
  $.press 'alt + minus'
  await $.sleep 2500
工匠的神速技巧 = ->
  $.press 'alt + equal'
  await $.sleep 2500
工匠的苦行 = ->
  $.press 'ctrl + 1'
  await $.sleep 2500
新颖II = ->
  $.press 'ctrl + 7'
  await $.sleep 1500
渐进 = ->
  $.press 'ctrl + 8'
  await $.sleep 1500
改革 = ->
  $.press 'ctrl + 9'
  await $.sleep 1500
俭约II = ->
  $.press 'ctrl + 0'
  await $.sleep 1500
安逸 = ->
  $.press 'ctrl + minus'
  await $.sleep 1500
回收 = ->
  $.press 'ctrl + equal'
  await $.sleep 1500
坚信 = ->
  $.press 'shift + 1'
  await $.sleep 2500

# ---

退出界面 = ->
  $.loop 4, ->
    await $.sleep 200
    $.press 'num-dot'
  await $.sleep 200
  await $.sleep 1e3

回收利用 = ->
  $.press 'alt + 0'
  $.press 'ctrl + equal'
  await $.sleep 1500

开始制作 = ->
  $.press 'shift + 7'
  await $.sleep 1e3

  循环制作()

制作 = ->

  稳手II()
  坯料加工()
  坯料加工()

  回收利用()

  # 模范制作III()
  # count++

  await $.sleep 500

  if hasStatus '再利用'
    模范制作III()
    count++
  else
    坯料加工()
    坯料加工()

  await $.sleep 2e3

继续制作 = ->
  $.press 'num-0'
  await $.sleep 500
  $.press 'num-0'
  await $.sleep 500
  $.press 'num-0'
  await $.sleep 1e3

停止制作 = ->
  await $.sleep 1e3
  退出界面()

循环制作 = ->

  if count >= limit
    停止制作()
    修理()
    分解()

    count = 0
    开始制作()
    return

  继续制作()
  制作()
  循环制作()

修理 = ->
  $.press 'shift + 8'
  await $.sleep 1e3
  $.press 'num-6'
  await $.sleep 500
  $.press 'num-0'
  await $.sleep 500
  $.press 'num-4'
  await $.sleep 500
  $.press 'num-0'
  await $.sleep 500
  
  退出界面()

分解 = ->
  $.press 'shift + 9'
  await $.sleep 1e3

  $.loop count, ->
    $.press 'num-0'
    await $.sleep 500
    $.press 'num-4'
    await $.sleep 500
    $.press 'num-0'
    await $.sleep 3e3
    $.press 'num-0'
    await $.sleep 500

  退出界面()

# function

hasStatus = (name) ->

  [x, y] = $.findImage "#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

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
  开始制作()
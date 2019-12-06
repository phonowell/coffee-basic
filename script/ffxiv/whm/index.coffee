# use admin

# skill

飞石 = -> $.press 'alt + 1'
治疗 = -> $.press 'alt + 2'

疾风 = ->
  
  if isMoving()
    $.press 'alt + 3'
    return true
  
  if hasStatusTarget '天辉'
    return false
  if hasStatusTarget '烈风'
    return false
  if hasStatusTarget '疾风'
    return false
  
  $.press 'alt + 3'
  return true

医治 = -> $.press 'alt + 4'

复活 = ->
  即刻咏唱()
  无中生有()
  $.press 'alt + 5'
  return true

水流环 = -> $.press 'alt + 6'
救疗 = -> $.press 'alt + 7'

医济 = ->
  if hasStatus '医济'
    return false
  $.press 'alt + 8'
  return true

神速咏唱 = -> $.press 'alt + 9'

再生 = ->
  if hasStatusTarget '再生'
    return false
  $.press 'alt + 0'
  return true

愈疗 = -> $.press 'alt + minus'
神圣 = -> $.press 'alt + equal'
天赐祝福 = -> $.press 'ctrl + 1'
安慰之心 = -> $.press 'ctrl + 2'
庇护所 = -> $.press 'ctrl + 3'
法令 = -> $.press 'ctrl + 4'
无中生有 = -> $.press 'ctrl + 5'
神名 = -> $.press 'ctrl + 6'
神祝祷 = -> $.press 'ctrl + 7'
全大赦 = -> $.press 'ctrl + 8'
苦难之心 = -> $.press 'ctrl + 9'
狂喜之心 = -> $.press 'ctrl + 0'
节制 = -> $.press 'ctrl + minus'
沉静 = -> $.press 'ctrl + equal'
康复 = -> $.press 'shift + 1'
即刻咏唱 = -> $.press 'shift + 2'

醒梦 = ->
  color = $.getColor 260, 35
  unless color == 0x56463C
    return false
  $.press 'shift + 3'
  return true

沉稳咏唱 = -> $.press 'shift + 4'
营救 = -> $.press 'shift + 5'
索敌 = -> $.press 'shift + 6'

# function

delay = (name, time = 300, n = 1) ->
  $.loop n, ->
    unless n == 1
      await $.sleep time
    $.clearTimeout name
    $.setTimeout name, time

getGroup = ->

  isLT = false
  isRT = false

  isLT = $.isPressing '2joy7'
  isRT = $.isPressing '2joy8'

  if isLT and isRT
    return 'both'

  if isLT
    return 'left'

  if isRT
    return 'right'

  return 'none'

hasStatus = (name) ->

  [x, y] = $.findImage "#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

hasStatusTarget = (name) ->

  [x, y] = $.findImage "#{name}.png", 725, 765, 925, 800
  
  if x > 0 and y > 0
    return true
  return false

isMoving = ->

  dis = $.getState '2-joy-x'
  if dis < 40
    return true
  if dis > 60
    return true

  dis = $.getState '2-joy-y'
  if dis < 40
    return true
  if dis > 60
    return true

  return false

isViewFar = false
toggleView = ->

  if isViewFar == false

    $.press 'ctrl:down', 'up:down', 'page-down:down'
    await $.sleep 3e3
    $.press 'ctrl:up', 'up:up', 'page-down:up'

    isViewFar = true

  else

    $.press 'ctrl:down', 'down:down', 'page-up:down'
    await $.sleep 3e3
    $.press 'ctrl:up', 'down:up', 'page-up:up'

    isViewFar = false

  $.beep()

# bind

$.on 'f12', ->
  $.beep()
  $.exit()

$.on 'f8', ->
  [x, y] = $.getPosition()
  # x = 265
  # y = 40
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f2', ->
  toggleView()

# ---

$.on '2-joy-4', ->

  group = getGroup()
  if group == 'none'
    return

  # 单体攻击
  if group == 'right'

    索敌()
    醒梦()
    苦难之心()
    法令()
    神速咏唱()

    if 疾风()
      return

    飞石()
    return

  # 群体攻击
  if group == 'both'

    索敌()
    醒梦()
    苦难之心()
    法令()
    神速咏唱()
    无中生有()
    即刻咏唱()
    神圣()
    return

$.on '2-joy-2', ->

  group = getGroup()
  if group == 'none'
    return
  
  # 单体治疗
  if group == 'right'

    醒梦()
    神名()
    法令()
    安慰之心()
    神速咏唱()
    再生()
    救疗()
    治疗()
    return

  # 群体治疗
  if group == 'both'

    醒梦()
    法令()
    全大赦()
    狂喜之心()
    神速咏唱()
    医济()
    医治()
    return

$.on '2-joy-1', ->

  group = getGroup()
  if group == 'none'
    return

  # 护盾
  if group == 'right'
    神祝祷()
    return

  # 驱散
  if group == 'both'
    康复()
    return

  # 复活
  if group == 'left'
    复活()
    return
  
$.on '2-joy-3', ->

  group = getGroup()
  if group == 'none'
    return

  if group == 'right'
    庇护所()
    return

  if group == 'both'
    无中生有()
    愈疗()
    return
# use admin

# skill

强力射击 = -> $.press 'alt + 1'

直线射击 = ->

  unless hasStatus '直线射击预备'
    return false

  $.press 'alt + 2'
  return true

猛者强击 = ->

  if hasStatus '猛者强击'
    return false
  
  $.press 'alt + 3'
  return true

毒咬箭 = ->

  if hasStatusTarget '毒咬箭'
    return false

  $.press 'alt + 4'
  return true

失血箭 = -> $.press 'alt + 5'
后跃射击 = -> $.press 'alt + 6'
连珠箭 = -> $.press 'alt + 7'

风蚀箭 = ->

  if hasStatusTarget '风蚀箭'
    return false

  $.press 'alt + 8'
  return true

纷乱箭 = ->
  
  unless hasStatus '猛者强击'
    return false
  
  $.press 'alt + 9'
  return true

贤者的叙事谣 = ->

  unless hasStatus '猛者强击'
    return false

  $.press 'alt + 0'
  return true

光阴神的礼赞凯歌 = -> $.press 'alt + minus'
军神的赞美歌 = -> $.press 'alt + equal'
死亡箭雨 = -> $.press 'ctrl + 1'
战斗之声 = -> $.press 'ctrl + 2'
放浪神的小步舞曲 = -> $.press 'ctrl + 3'
完美音调 = -> $.press 'ctrl + 4'
九天连箭 = -> $.press 'ctrl + 5'
伶牙俐齿 = -> $.press 'ctrl + 6'
侧风诱导箭 = -> $.press 'ctrl + 7'
行吟 = -> $.press 'ctrl + 8'
大地神的抒情恋歌 = -> $.press 'ctrl + 9'
影噬箭 = -> $.press 'ctrl + 0'
绝峰箭 = -> $.press 'ctrl + minus'
伤腿 = -> $.press 'ctrl + equal'
内丹 = -> $.press 'shift + 1'
伤足 = -> $.press 'shift + 2'
速行 = -> $.press 'shift + 3'
伤头 = -> $.press 'shift + 4'
亲疏自行 = -> $.press 'shift + 5'
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

能力技 = ->
  猛者强击()
  纷乱箭()
  贤者的叙事谣()
  失血箭()

# ---

$.on '2-joy-4', ->

  group = getGroup()
  if group == 'none'
    return

  # attackS
  if group == 'right'
    use '索敌'
    直线射击()
    毒咬箭()
    风蚀箭()
    强力射击()

    delay '能力技', 300, 2
    return

  # attackM
  if group == 'both'
    use '索敌'
    连珠箭()

    delay '能力技', 300, 2
    return

# $.on '2-joy-2', ->

#   group = getGroup()
#   if group == 'none'
#     return

# $.on '2-joy-1', ->

#   group = getGroup()
#   if group == 'none'
#     return
  
# $.on '2-joy-3', ->

#   group = getGroup()
#   if group == 'none'
#     return
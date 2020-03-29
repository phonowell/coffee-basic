$cd = {}
$ts = {}

calcCD = (name) ->
  
  result = $cd[name] - (A_TickCount - $ts[name])
  
  unless result > 0
    return 0
  
  result = Math.round result / 1e3
  return result

# ---

clearTip = -> $.tip()

clearWatcher = (name, type = 'used') ->
  
  if type == 'used'
    unless isUsed name
      return
  else if type == 'status'
    unless hasStatus name
      return

  unless $watcher[name]
    alert "invalid watcher: #{name}"
    return
  
  clearInterval $watcher[name]
  $ts[name] = A_TickCount - $cd.技能施放补正
  return true

# ---

# ehp = 0
# getEnemyHp = ->
  
#   color = $.getColor 650, 65
#   unless color == 0xFF8888
#     return 0

#   [x, y] = $.findColor '#471515', 650, 65, 1084, 65

#   unless x
#     return 100
  
#   percent = (x - 650) * 100 / (1084 - 650)
#   percent = Math.floor percent
#   return percent

# ---

getGroup = ->

  isLT = $.isPressing '2-joy-7'
  isRT = $.isPressing '2-joy-8'

  if isLT and isRT
    return 'both'

  if isLT
    return 'left'

  if isRT
    return 'right'

  return

# ---

# hp = 0
# getHp = ->
#   [x, y] = $.findColor '#58483e', 21, 36, 168, 36, 10
  
#   unless x
#     return 100
  
#   percent = (x - 21) * 100 / (168 - 21)
#   percent = Math.floor percent
#   return percent

# ---

$mp = 0
getMp = ->
  [x, y] = $.findColor '#58483e', 181, 36, 328, 36, 10
  
  unless x
    return 100
  
  percent = (x - 181) * 100 / (328 - 181)
  percent = Math.floor percent
  return percent

# ---

hasStatus = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

# ---

hasStatusTarget = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 765, 925, 800
  
  if x > 0 and y > 0
    return true
  return false

# ---

isUsed = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 60, 915, 225, 975
  
  if x > 0 and y > 0
    return true
  return false

# ---

$isChanting = false
isChanting = ->
  
  if $isMoving
    return false
  
  color = $.getColor 1130, 865
  return color == 0x2B1B13

# ---

$isMoving = false
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

# ---

hasTarget = false
isTargeting = ->

  color = $.getColor 650, 65

  if color == 0xFF8888
    return true

  if color == 0xFFC888
    return true

  if color == 0xEBD788
    return true

  if color == 0xFFB1FF
    return true

  return false

# ---

makeReportMsg = (msg, name) ->
  result = calcCD name
  unless result > 1
    return msg
  return "#{msg}`n#{name}：#{result}s"

# ---

resetKey = ->
  $.press 'alt:up'
  $.press 'ctrl:up'
  $.press 'shift:up'

resetTs = ->
  for key, value in $ts
    $ts[key] = 0
# ---

$level = 80
setLevel = ->
  
  $level = prompt 'input level', $level
  
  unless $level > 0
    $level = 80

  if $level < 10
    $level = $level * 10

  resetTs()

# ---

$skill = {}
use = (name, option = false) ->
  
  unless $skill[name]
    alert "invalid skill: #{name}"
    return
  
  return $skill[name] option

$watcher = {}
watch = (name) ->

  unless $watcher[name]
    alert "invalid watcher: #{name}"
    return

  return $watcher[name]()
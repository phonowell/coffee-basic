ts.醒梦 = 0
cd.醒梦 = 60e3

醒梦 = ->

  unless level >= 24
    return false

  unless A_TickCount - ts.醒梦 > cd.醒梦
    return false

  mp = getMp()
  if mp > 50
    return false

  $.press 'shift + 4'
  
  ts.醒梦 = A_TickCount - cd.醒梦 + cd.技能施放补正
  $.setInterval 监听醒梦, cd.技能施放判断间隔
  return true

监听醒梦 = ->
  unless hasStatus '醒梦'
    return
  $.clearInterval 监听醒梦
  ts.醒梦 = A_TickCount - cd.技能施放补正
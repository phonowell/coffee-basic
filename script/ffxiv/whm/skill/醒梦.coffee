$ts.醒梦 = 0
$cd.醒梦 = 60e3

醒梦 = ->

  unless $level >= 24
    return

  unless A_TickCount - $ts.醒梦 > $cd.醒梦
    return

  $mp = getMp()
  if $mp > 50
    return

  $.press 'shift + 4'
  
  $ts.醒梦 = A_TickCount - $cd.醒梦 + $cd.技能施放补正
  setInterval $watcher.醒梦, $cd.技能施放判断间隔
  return true

$watcher.醒梦 = ->
  unless hasStatus '醒梦'
    return
  clearInterval $watcher.醒梦
  $ts.醒梦 = A_TickCount - $cd.技能施放补正
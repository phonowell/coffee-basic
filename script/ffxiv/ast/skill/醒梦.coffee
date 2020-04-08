$ts.醒梦 = 0
$cd.醒梦 = 60e3

$skill.醒梦 = ->

  unless A_TickCount - $ts.醒梦 > $cd.醒梦
    return

  checkMp()
  if $mp > 50
    return

  $.press 'shift + 6'
  
  $ts.醒梦 = A_TickCount - $cd.醒梦 + $cd.技能施放补正
  setInterval $watcher.醒梦, $cd.技能施放判断间隔
  return true

$watcher.醒梦 = -> clearWatcher '醒梦', 'status'
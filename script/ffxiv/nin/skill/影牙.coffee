$ts.影牙 = 0
$cd.影牙 = 70e3

$skill.影牙 = ->

  unless $level >= 30
    return

  unless $step == 0
    return

  unless A_TickCount - $ts.影牙 > $cd.影牙
    return

  $.press 'alt + 9'

  setInterval $watcher.影牙, $cd.技能施放判断间隔
  return true

$watcher.影牙 = -> clearWatcher '影牙'
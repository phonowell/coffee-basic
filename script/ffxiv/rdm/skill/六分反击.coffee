$ts.六分反击 = 0
$cd.六分反击 = 35e3

$skill.六分反击 = ->

  unless $level >= 56
    return

  unless A_TickCount - $ts.六分反击 > $cd.六分反击
    return

  $.press 'ctrl + 6'
  
  $ts.六分反击 = A_TickCount - $cd.六分反击 + $cd.技能施放补正
  setInterval $watcher.六分反击, $cd.技能施放判断间隔
  return true

$watcher.六分反击 = -> clearWatcher '六分反击'
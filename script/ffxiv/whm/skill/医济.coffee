$ts.医济 = 0
$cd.医济 = 15e3

$skill.医济 = ->

  unless $level >= 50
    return

  unless A_TickCount - $ts.医济 > $cd.医济
    return
  
  $.press 'ctrl + 8'

  setInterval $watcher.医济, $cd.技能施放判断间隔
  return true

$watcher.医济 = -> clearWatcher '医济'
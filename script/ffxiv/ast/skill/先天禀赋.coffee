$ts.先天禀赋 = 0
$cd.先天禀赋 = 40e3

$skill.先天禀赋 = ->

  unless $level >= 15
    return

  unless A_TickCount - $ts.先天禀赋 > $cd.先天禀赋
    return

  $.press 'alt + 7'

  $ts.先天禀赋 = A_TickCount - $cd.先天禀赋 + $cd.技能施放补正
  setInterval $watcher.先天禀赋, $cd.技能施放判断间隔
  return true

$watcher.先天禀赋 = -> clearWatcher '先天禀赋'
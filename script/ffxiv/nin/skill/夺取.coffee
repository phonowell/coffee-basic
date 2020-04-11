$ts.夺取 = 0
$cd.夺取 = 120e3

$skill.夺取 = ->

  unless $level >= 15
    return

  unless A_TickCount - $ts.夺取 > $cd.夺取
    return

  $.press 'alt + 6'

  setInterval $watcher.夺取, $cd.技能施放判断间隔
  return true

$watcher.夺取 = -> clearWatcher '夺取'
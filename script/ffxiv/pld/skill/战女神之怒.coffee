$ts.战女神之怒 = 0
$cd.战女神之怒 = 3e3

$skill.战女神之怒 = ->

  unless $level >= 26
    return

  unless A_TickCount - $ts.战女神之怒 > $cd.战女神之怒
    return

  unless $step == 2
    return

  unless $distance == 'near'
    return

  $.press 'alt + 8'

  setInterval $watcher.战女神之怒, $cd.技能施放判断间隔
  return true

$watcher.战女神之怒 = ->
  unless clearWatcher '战女神之怒'
    return
  
  $step = 0
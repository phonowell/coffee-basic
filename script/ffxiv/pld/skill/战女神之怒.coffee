$ts.战女神之怒 = 0
$cd.战女神之怒 = 2500

$skill.战女神之怒 = ->

  unless $level >= 26
    return

  unless $step == 2
    return

  unless A_TickCount - $ts.战女神之怒 > $cd.战女神之怒
    return

  $.press 'alt + 8'

  setInterval $watcher.战女神之怒, $cd.技能施放判断间隔
  return true

$watcher.战女神之怒 = ->

  if $level < 60
    unless clearWatcher '战女神之怒'
      return
  else
    unless isUsed '王权剑'
      return
    clearInterval $watcher.战女神之怒
    $ts.战女神之怒 = A_TickCount - $cd.技能施放补正
  
  $step = 0
  clearTimeout resetStep
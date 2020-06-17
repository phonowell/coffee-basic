$ts.全大赦 = 0
$cd.全大赦 = 60e3

$skill.全大赦 = ->

  unless $level >= 70
    return

  unless A_TickCount - $ts.全大赦 > $cd.全大赦
    return

  unless 能力技冷却判断()
    return

  $.press 'alt + 8'

  $ts.全大赦 = A_TickCount - $cd.全大赦 + $cd.技能施放补正
  setInterval $watcher.全大赦, $cd.技能施放判断间隔
  return true

$watcher.全大赦 = -> clearWatcher '全大赦'
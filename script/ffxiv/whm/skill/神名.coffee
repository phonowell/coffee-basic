$ts.神名 = 0
$cd.神名 = 60e3

神名 = ->

  unless $level >= 60
    return

  unless A_TickCount - $ts.神名 > $cd.神名
    return

  unless 能力技冷却判断()
    return

  $.press 'ctrl + 6'

  $ts.神名 = A_TickCount - $cd.神名 + $cd.技能施放补正
  setInterval $watcher.神名, $cd.技能施放判断间隔
  return true

$watcher.神名 = ->
  unless isUsed '神名'
    return
  clearInterval $watcher.神名
  $ts.神名 = A_TickCount - $cd.技能施放补正
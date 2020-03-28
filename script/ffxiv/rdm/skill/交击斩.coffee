$ts.交击斩 = 0
$cd.交击斩 = 10e3

$skill.交击斩 = ->

  unless $level >= 35
    return

  unless A_TickCount - $ts.交击斩 > $cd.交击斩
    return

  unless A_TickCount - $ts.回刺 < $cd.魔三连
    return

  unless $black >= 50 and $white >= 50
    return

  $.press 'alt + minus'
  
  setInterval $watcher.交击斩, $cd.技能施放判断间隔
  return true

$watcher.交击斩 = ->
  unless isUsed '魔交击斩'
    return
  clearInterval $watcher.交击斩
  $ts.交击斩 = A_TickCount - $cd.技能施放补正
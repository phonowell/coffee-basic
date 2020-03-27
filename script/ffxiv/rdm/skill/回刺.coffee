$ts.回刺 = 0
$cd.回刺 = 10e3

$skill.回刺 = ->

  unless A_TickCount - $ts.回刺 > $cd.回刺
    return

  unless $black >= 80 and $white >= 80
    return

  use '中断咏唱'

  $distance = getDistance()
  unless $distance == 'near'
    use '短兵相接', true
    return

  $.press 'alt + 1'

  setInterval $watcher.回刺, $cd.技能施放判断间隔
  return true

$watcher.回刺 = ->
  unless isUsed '魔回刺'
    return
  clearInterval $watcher.回刺
  $ts.回刺 = A_TickCount - $cd.技能施放补正
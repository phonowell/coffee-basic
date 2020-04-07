$ts.回刺 = 0

$skill.回刺 = ->

  unless $step == 0
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
  unless hasUsed '魔回刺'
    return
  clearInterval $watcher.回刺
  $ts.回刺 = A_TickCount - $cd.技能施放补正

  clearTimeout resetStep

  if $level >= 35
    $step = 1
    setTimeout resetStep, $cd.魔三连
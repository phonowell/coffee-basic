$ts.交击斩 = 0

$skill.交击斩 = ->

  unless $level >= 35
    return

  unless $step == 1
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

  clearTimeout resetStep

  if $level >= 50
    $step = 2
    setTimeout resetStep, $cd.魔三连
  else
    $step = 0
$ts.连攻 = 0

$skill.连攻 = ->

  unless $level >= 50
    return

  unless $step == 2
    return

  unless $black >= 25 and $white >= 25
    return

  $.press 'ctrl + 2'
  
  setInterval $watcher.连攻, $cd.技能施放判断间隔
  return true

$watcher.连攻 = ->
  unless isUsed '魔连攻'
    return
  clearInterval $watcher.连攻
  $ts.连攻 = A_TickCount - $cd.技能施放补正

  clearTimeout resetStep

  if $level >= 70
    $step = 3
    setTimeout resetStep, $cd.魔三连
  else
    $step = 0
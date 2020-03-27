$ts.连攻 = 0
$cd.连攻 = 10e3

$skill.连攻 = ->

  unless $level >= 50
    return false

  unless A_TickCount - $ts.连攻 > $cd.连攻
    return false

  unless A_TickCount - $ts.交击斩 < $cd.comboZ
    return false

  unless $black >= 25 and $white >= 25
    return false

  $.press 'ctrl + 2'
  
  $.setInterval $watcher.连攻, $cd.技能施放判断间隔
  return true

$watcher.连攻 = ->
  unless isUsed '魔连攻'
    return
  $.clearInterval $watcher.连攻
  $ts.连攻 = A_TickCount - $cd.技能施放补正
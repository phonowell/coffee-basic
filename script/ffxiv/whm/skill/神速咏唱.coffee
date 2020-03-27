$ts.神速咏唱 = 0
$cd.神速咏唱 = 150e3

神速咏唱 = ->

  unless $level >= 30
    return

  unless A_TickCount - $ts.神速咏唱 > $cd.神速咏唱
    return

  $.press 'alt + 9'

  $ts.神速咏唱 = A_TickCount - $cd.神速咏唱 + $cd.技能施放补正
  setInterval $watcher.神速咏唱, $cd.技能施放判断间隔
  return true

$watcher.神速咏唱 = ->
  unless hasStatus '神速咏唱'
    return
  clearInterval $watcher.神速咏唱
  $ts.神速咏唱 = A_TickCount - $cd.技能施放补正
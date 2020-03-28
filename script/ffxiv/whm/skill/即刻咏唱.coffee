$ts.即刻咏唱 = 0
$cd.即刻咏唱 = 60e3

$skill.即刻咏唱 = ->

  unless $level >= 18
    return

  unless A_TickCount - $ts.即刻咏唱 > $cd.即刻咏唱
    return

  $.press 'shift + 3'

  $ts.即刻咏唱 = A_TickCount - $cd.即刻咏唱 + $cd.技能施放补正
  setInterval $watcher.即刻咏唱, $cd.技能施放判断间隔
  return true

$watcher.即刻咏唱 = -> clearWatcher '即刻咏唱', 'status'
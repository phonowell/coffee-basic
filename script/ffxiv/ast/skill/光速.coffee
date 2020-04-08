$ts.光速 = 0
$cd.光速 = 120e3

$skill.光速 = ->

  unless A_TickCount - $ts.光速 > $cd.光速
    return

  $.press 'alt + 4'

  $ts.光速 = A_TickCount - $cd.光速 + $cd.技能施放补正
  setInterval $watcher.光速, $cd.技能施放判断间隔
  return true

$watcher.光速 = -> clearWatcher '光速', 'status'
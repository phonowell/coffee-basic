$ts.超荷 = 0
$cd.超荷 = 10e3

$skill.超荷 = ->

  unless $level >= 30
    return

  unless $red >= 50
    return

  unless A_TickCount - $ts.超荷 > $cd.超荷
    return

  $.press 'alt + 8'

  setInterval $watcher.超荷, $cd.技能施放判断间隔
  return true

$watcher.超荷 = -> clearWatcher '超荷'
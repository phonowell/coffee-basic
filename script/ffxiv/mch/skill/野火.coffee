$ts.野火 = 0
$cd.野火 = 120e3

$skill.野火 = ->

  unless $level >= 45
    return

  unless $red >= 50
    return

  unless A_TickCount - $ts.野火 > $cd.野火
    return

  $.press 'alt + equal'

  setInterval $watcher.野火, $cd.技能施放判断间隔
  return true

$watcher.野火 = -> clearWatcher '野火'
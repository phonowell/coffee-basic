$ts.盾阵 = 0
$cd.盾阵 = 5e3

$skill.盾阵 = ->

  unless $level >= 35
    return

  unless $gold >= 50
    return

  unless A_TickCount - $ts.盾阵 > $cd.盾阵
    return

  $.press 'ctrl + equal'

  setInterval $watcher.盾阵, $cd.技能施放判断间隔
  return true

$watcher.盾阵 = -> clearWatcher '盾阵', 'status'

$skill.自动盾阵 = ->

  unless $level >= 35
    return

  unless $gold >= 95
    return

  use '盾阵'
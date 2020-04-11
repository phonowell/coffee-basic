$ts.双刃旋 = 0
$cd.双刃旋 = 2500

$skill.双刃旋 = ->

  unless $step == 0
    return

  unless A_TickCount - $ts.双刃旋 > $cd.双刃旋
    return

  $.press 'alt + 1'

  setInterval $watcher.双刃旋, $cd.技能施放判断间隔
  return true

$watcher.双刃旋 = ->
  unless clearWatcher '双刃旋'
    return

  $step = 1

  clearTimeout resetStep
  setTimeout resetStep, 15e3
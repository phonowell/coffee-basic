$ts.分裂弹 = 0
$cd.分裂弹 = 2500

$skill.分裂弹 = ->

  unless $step == 0
    return

  unless A_TickCount - $ts.分裂弹 > $cd.分裂弹
    return

  $.press 'alt + 1'

  setInterval $watcher.分裂弹, $cd.技能施放判断间隔
  return true

$watcher.分裂弹 = ->
  unless clearWatcher '分裂弹'
    return

  $step = 1

  clearTimeout resetStep
  setTimeout resetStep, 15e3
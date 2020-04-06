$ts.独头弹 = 0
$cd.独头弹 = 2500

$skill.独头弹 = ->

  unless $step == 1
    return

  unless A_TickCount - $ts.独头弹 > $cd.独头弹
    return

  $.press 'alt + 2'

  setInterval $watcher.独头弹, $cd.技能施放判断间隔
  return true

$watcher.独头弹 = ->
  unless clearWatcher '独头弹'
    return
  
  unless $level >= 26
    $step = 0
    return
  
  $step = 2

  clearTimeout resetStep
  setTimeout resetStep, 15e3
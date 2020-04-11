$ts.旋风刃 = 0
$cd.旋风刃 = 2500

$skill.旋风刃 = ->

  unless $level >= 26
    return

  unless $step == 2
    return

  unless A_TickCount - $ts.旋风刃 > $cd.旋风刃
    return

  $.press 'alt + 8'

  setInterval $watcher.旋风刃, $cd.技能施放判断间隔
  return true

$watcher.旋风刃 = ->
  unless clearWatcher '旋风刃'
    return
  
  $step = 0
  clearTimeout resetStep
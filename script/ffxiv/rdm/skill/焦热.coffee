$ts.焦热 = 0
$cd.焦热 = 10e3

$skill.焦热 = ->

  unless $level >= 80
    return false

  unless A_TickCount - $ts.焦热 > $cd.焦热
    $.beep()
    return false

  unless A_TickCount - $ts.赤神圣 < 15e3
    return false

  摇荡()
  
  $.setInterval $watcher.焦热, $cd.技能施放判断间隔
  return true

$watcher.焦热 = -> clearWatcher '焦热'
$ts.焦热 = 0

$skill.焦热 = ->

  unless $level >= 80
    return

  unless $step == 4
    return

  use '摇荡'
  
  setInterval $watcher.焦热, $cd.技能施放判断间隔
  return true

$watcher.焦热 = ->
  unless clearWatcher '焦热'
    return
  
  clearTimeout resetStep

  $step = 0
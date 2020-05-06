$ts.血雨飞花 = 0
$cd.血雨飞花 = 2500

$skill.血雨飞花 = ->

  unless $level >= 38
    return

  unless $step < 20
    return

  unless A_TickCount - $ts.血雨飞花 > $cd.血雨飞花
    return

  $.press 'alt + 0'

  setInterval $watcher.血雨飞花, $cd.技能施放判断间隔
  return true

$watcher.血雨飞花 = ->

  unless clearWatcher '血雨飞花'
    return

  unless $level >= 52
    $step = 0
    clearTimeout resetStep
    return

  $step = 21

  clearTimeout resetStep
  setInterval resetStep, 15e3
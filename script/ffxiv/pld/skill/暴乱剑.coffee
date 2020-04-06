$ts.暴乱剑 = 0
$cd.暴乱剑 = 2500

$skill.暴乱剑 = ->

  unless $step == 1
    return

  unless A_TickCount - $ts.暴乱剑 > $cd.暴乱剑
    return

  $.press 'alt + 3'

  setInterval $watcher.暴乱剑, $cd.技能施放判断间隔
  return true

$watcher.暴乱剑 = ->
  unless clearWatcher '暴乱剑'
    return
  
  unless $level >= 26
    $step = 0
    clearTimeout resetStep
    return
  
  $step = 2

  clearTimeout resetStep
  setTimeout resetStep, 15e3
$ts.纷乱箭 = 0
$cd.纷乱箭 = 80e3

$skill.纷乱箭 = ->

  unless $level >= 38
    return

  unless A_TickCount - $ts.纷乱箭 > $cd.纷乱箭
    return

  if hasStatus '直线射击预备'
    return

  unless hasStatus '猛者强击'
    return

  $.press 'alt + 8'

  setInterval $watcher.纷乱箭, $cd.技能施放判断间隔
  return true

$watcher.纷乱箭 = -> clearWatcher '纷乱箭', 'status'
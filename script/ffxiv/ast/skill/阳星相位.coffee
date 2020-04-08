$ts.阳星相位 = 0
$cd.阳星相位 = 15e3

$skill.阳星相位 = ->

  unless $level >= 42
    return

  unless A_TickCount - $ts.阳星相位 > $cd.阳星相位
    return
  
  $.press 'ctrl + 2'

  setInterval $watcher.阳星相位, $cd.技能施放判断间隔
  return true

$watcher.阳星相位 = -> clearWatcher '阳星相位'
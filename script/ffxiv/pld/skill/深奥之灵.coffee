$ts.深奥之灵 = 0
$cd.深奥之灵 = 30e3

$skill.深奥之灵 = ->

  unless $level >= 30
    return

  unless A_TickCount - $ts.深奥之灵 > $cd.深奥之灵
    return

  $.press 'ctrl + minus'

  setInterval $watcher.深奥之灵, $cd.技能施放判断间隔
  return true

$watcher.深奥之灵 = -> clearWatcher '深奥之灵'
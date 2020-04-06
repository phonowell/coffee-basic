$ts.深仁厚泽 = 0
$cd.深仁厚泽 = 2500

$skill.深仁厚泽 = ->

  unless $level >= 58
    return

  unless A_TickCount - $ts.深仁厚泽 > $cd.深仁厚泽
    return

  $.press 'ctrl + 6'

  setInterval $watcher.深仁厚泽, $cd.技能施放判断间隔
  return true

$watcher.深仁厚泽 = -> clearWatcher '深仁厚泽'
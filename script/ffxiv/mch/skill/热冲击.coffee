$ts.热冲击 = 0
$cd.热冲击 = 1500

$skill.热冲击 = ->

  unless $level >= 35
    return

  unless A_TickCount - $ts.超荷 < 9e3
    return

  unless A_TickCount - $ts.热冲击 > $cd.热冲击
    return

  $.press 'alt + 9'

  setInterval $watcher.热冲击, $cd.技能施放判断间隔
  return true

$watcher.热冲击 = ->
  unless clearWatcher '热冲击'
    return

  $ts.虹吸弹 = $ts.虹吸弹 - 15e3
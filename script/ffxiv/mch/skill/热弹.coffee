$ts.热弹 = 0
$cd.热弹 = 40e3

$skill.热弹 = ->

  unless A_TickCount - $ts.热弹 > $cd.热弹
    return

  $.press 'alt + 3'

  setInterval $watcher.热弹, $cd.技能施放判断间隔
  return true

$watcher.热弹 = -> clearWatcher '热弹'
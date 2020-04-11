$ts.内丹 = 0
$cd.内丹 = 120e3

$skill.内丹 = ->

  unless A_TickCount - $ts.内丹 > $cd.内丹
    return

  $.press 'shift + 2'

  setInterval $watcher.内丹, $cd.技能施放判断间隔
  return true

$watcher.内丹 = -> clearWatcher '内丹'
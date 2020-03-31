$ts.全蚀斩 = 0
$cd.全蚀斩 = 2e3

$skill.全蚀斩 = ->

  unless A_TickCount - $ts.全蚀斩 > $cd.全蚀斩
    return

  $.press 'alt + 4'

  setInterval $watcher.全蚀斩, $cd.技能施放判断间隔
  return true

$watcher.全蚀斩 = ->
  unless clearWatcher '全蚀斩'
    return
  $step = 0

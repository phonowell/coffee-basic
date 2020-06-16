$ts.下踢 = 0
$cd.下踢 = 25e3

$skill.下踢 = ->

  unless A_TickCount - $ts.下踢 > $cd.下踢
    return

  if hasStatusByTarget '眩晕'
    return

  $.press 'ctrl + alt + 2'

  setInterval $watcher.下踢, $cd.技能施放判断间隔
  return true

$watcher.下踢 = -> clearWatcher '下踢'
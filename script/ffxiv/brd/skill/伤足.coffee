$ts.伤足 = 0
$cd.伤足 = 30e3

$skill.伤足 = ->

  unless A_TickCount - $ts.伤足 > $cd.伤足
    return

  $.press 'shift + 3'

  setInterval $watcher.伤足, $cd.技能施放判断间隔
  return true

$watcher.伤足 = -> clearWatcher '伤足'
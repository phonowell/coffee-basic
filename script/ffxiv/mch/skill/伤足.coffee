$ts.伤足 = 0
$cd.伤足 = 30e3

$skill.伤足 = ->

  unless $isMoving
    return

  unless A_TickCount - $ts.伤足 > $cd.伤足
    return

  if hasStatusByTarget '加重' then return
  if hasStatusByTarget '止步' then return
  if hasStatusByTarget '眩晕' then return

  $.press 'shift + 3'

  setInterval $watcher.伤足, $cd.技能施放判断间隔
  return true

$watcher.伤足 = -> clearWatcher '伤足'
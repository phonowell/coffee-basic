$ts.短兵相接 = 0
$cd.短兵相接 = 40e3

$skill.短兵相接 = (isForced = false) ->

  unless A_TickCount - $ts.短兵相接 > $cd.短兵相接
    return

  unless $distance == 'near' or isForced
    return

  $.press 'alt + 4'

  $ts.短兵相接 = A_TickCount - $cd.短兵相接 + $cd.技能施放补正
  setInterval $watcher.短兵相接, $cd.技能施放判断间隔
  return true

$watcher.短兵相接 = -> clearWatcher '短兵相接'
$ts.亲疏自行 = 0
$cd.亲疏自行 = 120e3

$skill.亲疏自行 = ->

  unless A_TickCount - $ts.亲疏自行 > $cd.亲疏自行
    return

  $.press 'shift + 6'

  setInterval $watcher.亲疏自行, $cd.技能施放判断间隔
  return true

$watcher.亲疏自行 = -> clearWatcher '亲疏自行', 'status'
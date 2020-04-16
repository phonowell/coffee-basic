$ts.风蚀箭 = 0
$cd.风蚀箭 = 27e3

$skill.风蚀箭 = ->

  unless $level >= 30
    return

  unless hasStatusByTarget '风蚀箭-敌'
    $ts.风蚀箭 = 0

  unless A_TickCount - $ts.风蚀箭 > $cd.风蚀箭
    return

  $.press 'alt + 7'

  setInterval $watcher.风蚀箭, $cd.技能施放判断间隔
  return true

$watcher.风蚀箭 = -> clearWatcher '风蚀箭'
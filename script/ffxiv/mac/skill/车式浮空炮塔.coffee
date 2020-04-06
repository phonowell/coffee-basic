$ts.车式浮空炮塔 = 0
$cd.车式浮空炮塔 = 6e3

$skill.车式浮空炮塔 = ->

  unless $level >= 40
    return

  unless $blue >= 50
    return

  unless A_TickCount - $ts.车式浮空炮塔 > $cd.车式浮空炮塔
    return

  $.press 'alt + 0'

  setInterval $watcher.车式浮空炮塔, $cd.技能施放判断间隔
  return true

$watcher.车式浮空炮塔 = -> clearWatcher '车式浮空炮塔', 'status'
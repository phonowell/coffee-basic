$ts.抽卡 = 0
$cd.抽卡 = 30e3

$skill.抽卡 = ->

  unless $level >= 30
    return

  unless A_TickCount - $ts.抽卡 > $cd.抽卡
    return

  $.press 'alt + 9'

  $ts.抽卡 = A_TickCount - $cd.抽卡 + $cd.技能施放补正
  setInterval $watcher.抽卡, $cd.技能施放判断间隔
  return true

$watcher.抽卡 = -> clearWatcher '抽卡'

$skill.出卡 = ->

  unless $level >= 30
    return

  $.press 'alt + minus'
  return true
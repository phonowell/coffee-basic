$ts.飞刺 = 0
$cd.飞刺 = 25e3

$skill.飞刺 = ->

  unless $level >= 45
    return false

  unless A_TickCount - $ts.飞刺 > $cd.飞刺
    return false
  
  $.press 'ctrl + 1'
  
  $ts.飞刺 = A_TickCount - $cd.飞刺 + $cd.技能施放补正
  $.setInterval $watcher.飞刺, $cd.技能施放判断间隔
  return true

$watcher.飞刺 = -> clearWatcher '飞刺'
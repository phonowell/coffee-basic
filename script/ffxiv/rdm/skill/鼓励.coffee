$ts.鼓励 = 0
$cd.鼓励 = 120e3

$skill.鼓励 = ->

  unless $level >= 58
    return false

  unless A_TickCount - $ts.鼓励 > $cd.鼓励
    return false

  unless A_TickCount - $ts.回刺 < $cd.回刺
    return false

  $.press 'ctrl + 7'
  
  $ts.鼓励 = A_TickCount - $cd.鼓励 + $cd.技能施放补正
  $.setInterval $watcher.鼓励, $cd.技能施放判断间隔
  return true

$watcher.鼓励 = -> clearWatcher '鼓励'
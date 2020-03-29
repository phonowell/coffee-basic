$ts.促进 = 0
$cd.促进 = 55e3

$skill.促进 = ->

  unless $level >= 50
    return

  unless A_TickCount - $ts.促进 > $cd.促进
    return

  unless A_TickCount - $ts.赤疾风 < 2e3
    return

  if $black > 70 or $white > 70
    return

  if $isBR or $isWR
    return

  $.press 'ctrl + 3'
  
  $ts.促进 = A_TickCount - $cd.促进 + $cd.技能施放补正
  setInterval $watcher.促进, $cd.技能施放判断间隔
  return true

$watcher.促进 = -> clearWatcher '促进'
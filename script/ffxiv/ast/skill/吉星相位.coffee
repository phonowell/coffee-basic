$ts.吉星相位 = 0
$cd.吉星相位 = 2500

$skill.吉星相位 = ->

  unless $level >= 34
    return

  if $isIM
    return

  unless A_TickCount - $ts.吉星相位 > $cd.吉星相位
    return
  
  if hasStatusByTarget '吉星相位'
    return
  
  $.press 'alt + equal'

  $ts.吉星相位 = A_TickCount - $cd.吉星相位 + $cd.技能施放补正
  return true
$ts.再生 = 0
$cd.再生 = 2500

$skill.再生 = ->

  unless $level >= 35
    return

  unless A_TickCount - $ts.再生 > $cd.再生
    return
  
  if hasStatusByTarget '再生'
    return
  
  $.press 'alt + 0'

  $ts.再生 = A_TickCount - $cd.再生 + $cd.技能施放补正
  return true
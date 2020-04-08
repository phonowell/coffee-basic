$ts.赤疾风 = 0
$cd.赤疾风 = 2500

$skill.赤疾风 = ->

  $.press 'alt + 5'

  $ts.赤疾风 = A_TickCount - $cd.赤疾风 + $cd.技能施放补正
$ts.能力技 = 0
$cd.能力技 = 300

能力技冷却判断 = ->

  unless A_TickCount - $ts.能力技 > $cd.能力技
    return false

  $ts.能力技 = A_TickCount
  return true
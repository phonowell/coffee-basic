$ts.能力技 = 0
$cd.能力技 = 1e3
能力技余额 = 0

$skill.能力技 = (n = 2) ->
  
  unless A_TickCount - $ts.能力技 > $cd.能力技
    return
  
  $ts.能力技 = A_TickCount
  能力技余额 = -n

  $.setInterval 施放能力技, 500

施放能力技 = ->

  if 能力技余额 < 0
    能力技余额 = -能力技余额
    return

  unless 能力技余额 > 0
    $.clearInterval 施放能力技
    return
  能力技余额--

  能力技施放()

能力技施放 = ->

  if use '倍增'
    return

  if use '鼓励'
    return

  if use '促进'
    return

  if use '即刻咏唱'
    return

  if use '飞刺'
    return

  if use '六分反击'
    return

  if use '短兵相接'
    return

  if use '交剑'
    return
  
  if use '醒梦'
    return
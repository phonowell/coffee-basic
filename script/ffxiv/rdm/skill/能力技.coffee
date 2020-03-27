$ts.能力技 = 0
$cd.能力技 = 1e3

$ap = 0

$skill.能力技 = ->

  unless $ap == 0
    return
  
  unless A_TickCount - $ts.能力技 > $cd.能力技
    return
  
  $ts.能力技 = A_TickCount
  $ap = -2

  setInterval 施放能力技, 500

施放能力技 = ->

  # 使首次调用无效化
  if $ap < 0
    $ap = -$ap
    return

  if $ap == 0
    clearInterval 施放能力技
    return
  
  $ap--
  
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
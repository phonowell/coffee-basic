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

  unless $isTargeting
    use '空白信息'
    return

  unless $isNear
    use '空白信息'
    return

  if $isOverheat
    能力技施放B()
    return

  能力技施放A()

能力技施放A = ->

  if $ap == 1
    if use '野火'
      return
  else
    if use '超荷'
      return

  for skill in [
    '整备'
    '虹吸弹'
    '车式浮空炮塔'
    '弹射'
    '伤腿'
    '伤足'
    '空白信息'
  ]
    if use skill
      break


能力技施放B = ->
  for skill in [
    '虹吸弹'
    '弹射'
    '空白信息'
  ]
    if use skill
      break
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

  for skill in [
    '战逃反应'
    '深奥之灵'
    '厄运流转'
    '安魂祈祷'
    '调停'
    '雪仇'
    '亲疏自行'
    '自动盾阵'
    '空白信息'
  ]
    if use skill
      break
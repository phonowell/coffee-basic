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

  if use '猛者强击' then return
  if use '失血箭' then return
  if use '纷乱箭' then return
  if use '贤者的叙事谣' then return
  if use '伤腿' then return
  if use '伤足' then return

  use '空白信息'
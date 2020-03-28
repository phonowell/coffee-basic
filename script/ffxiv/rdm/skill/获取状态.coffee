$ts.获取状态 = 0

$isIM = false
$isBR = false
$isWR = false

$skill.获取状态 = ->

  if A_TickCount - $ts.获取状态 > 10e3
    use '空白信息'
    use '空白信息'
    use '空白信息'
  $ts.获取状态 = A_TickCount

  $isMoving = isMoving()
  $isChanting = isChanting()

  $black = getBlack()
  $white = getWhite()

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  $isIM = isA or isB

  $isBR = hasStatus '赤火炎预备'
  $isWR = hasStatus '赤飞石预备'
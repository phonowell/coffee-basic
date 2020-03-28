$ts.获取状态 = 0

$skill.获取状态 = ->

  if A_TickCount - $ts.获取状态 > 10e3
    use '清空信息'
  $ts.获取状态 = A_TickCount

  $isMoving = isMoving()
  $isChanting = isChanting()

  $red = getRed()
  $white = getWhite()
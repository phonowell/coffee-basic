$skill.获取状态 = ->

  $black = getBlack()
  $white = getWhite()

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  $isIM = isA or isB

  $isBR = hasStatus '赤火炎预备'
  $isWR = hasStatus '赤飞石预备'
# use admin
# include ../common/function
# include binding
# include function
# include skill

# ---

# 单体攻击
attackS = ->

  if $isChanting
    return

  if attackSL()
    use '能力技'
    return

  if $isMoving
    use '续斩'
    use '能力技'
    return

  attackSS()

# 群体攻击
attackM = ->

  if $isChanting
    return

  if $isIM
    use '散碎'
    use '能力技'
    return

  if $isMoving
    use '续斩'
    use '能力技'
    return

  if $white >= $black
    use '赤震雷'
  else
    use '赤烈风'

# ---

# 单体短攻击
attackSS = ->

  if $isIM
    return

  if use '调整魔元'
    use '能力技'
    return

  if $black - $white > 21
    if $isWR
      use '赤飞石'
    else
      use '摇荡'
    return

  if $white - $black > 21
    if $isBR
      use '赤火炎'
    else
      use '摇荡'
    return

  attackSS2()

attackSS2 = ->

  if $isWR and $isBR
    if $black > $white
      use '赤飞石'
    else
      use '赤火炎'
    return

  if $isWR
    use '赤飞石'
    return

  if $isBR
    use '赤火炎'
    return

  use '摇荡'

# ---

# 单体长攻击
attackSL = ->

  unless $isIM
    return

  if $black - $white > 19
    use '赤疾风'
    return true

  if $white - $black > 19
    use '赤闪雷'
    return true
  
  if $isWR
    use '赤闪雷'
    return true
  
  if $isBR
    use '赤疾风'
    return true

  if $white >= $black
    use '赤闪雷'
  else
    use '赤疾风'

  return true

# ---

# 单体治疗
healS = ->

  if $isChanting
    return

  if $isIM
    unless use '索敌'
      use '赤治疗'
      return

  if attackSL()
    use '能力技'
    return

  if $isMoving
    use '续斩'
    use '能力技'
    return

  use '赤治疗'

# ---

revive = ->

  if $isChanting
    return

  unless $isIM
    unless use '索敌'
      use '赤治疗'
      return

  if attackSS()
    return

  if $isMoving
    use '续斩'
    use '能力技'
    return

  use '赤复活'
  use '能力技'
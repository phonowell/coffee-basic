$skill.魔三连 = ->

  isValid = true
  if hasStatus '连续咏唱'
    isValid = false
  if hasStatus '即刻咏唱'
    isValid = false

  unless isValid
    return

  if use '回刺'
    return true

  if use '交击斩'
    return true

  if use '连攻'
    return true

  if use '赤神圣'
    return true

  if use '焦热'
    return true
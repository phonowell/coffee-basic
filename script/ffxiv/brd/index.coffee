# use admin
# include binding
# include ../common/function/*
# include function/*
# include ../common/skill/*
# include skill/*

# ---

attackS = ->

  unless $isTargeting
    use '索敌'
    return

  if use '直线射击'
    use '能力技'
    return

  if use '风蚀箭'
    use '能力技'
    return

  if use '毒咬箭'
    use '能力技'
    return

  if use '强力射击'
    use '能力技'
    return

# ---

attackM = ->

  unless $isTargeting
    use '索敌'
    return

  if use '连珠箭'
    use '能力技'
    return

  return
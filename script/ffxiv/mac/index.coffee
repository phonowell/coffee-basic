# use admin
# include binding
# include ../common/function/*
# include function/*
# include ../common/skill/*
# include skill/*

# ---

attackS = ->

  if use '热冲击'
    use '能力技'
    return

  if use '热弹'
    use '能力技'
    return

  if use '分裂弹'
    use '能力技'
    return

  if use '独头弹'
    use '能力技'
    return

  if use '狙击弹'
    use '能力技'
    return

# ---

attackM = ->

  if use '散射'
    use '能力技'
    return

  return
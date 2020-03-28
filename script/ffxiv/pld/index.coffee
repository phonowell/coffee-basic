# use admin
# include binding
# include function
# include skill

# ---

attackS = ->
  
  unless $distance == 'near'
    # if $step == 0
    #   use '投盾'
    return

  if use '先锋剑'
    use '能力技'
    return
  
  if use '暴乱剑'
    use '能力技'
    return
  
  if use '战女神之怒'
    use '能力技'
    return

# ---

attackM = ->
  
  if use '全蚀斩'
    use '能力技'
    return
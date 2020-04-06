# use admin
# include binding
# include function
# include skill

# ---

attackS = ->
  
  unless $distance == 'near'
    if $step == 0
      use '投盾'
    return

  if use '先锋剑'
    use '能力技'
    return
  
  if use '暴乱剑'
    use '能力技'
    return

  if use '沥血剑'
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

  if use '日珥斩'
    use '能力技'
    return

# ---

defendS = ->
  if use '雪仇' then return
  if use '盾阵' then return
  $.beep()

# ---

defendH = ->
  if use '铁壁' then return
  if use '预警' then return
  $.beep()

# ---

breakS = ->
  if use '下踢' then return
  if use '插言' then return
  $.beep()

# ---

healS = ->
  if use '圣光幕帘' then return
  if use '深仁厚泽' then return
  $.beep()
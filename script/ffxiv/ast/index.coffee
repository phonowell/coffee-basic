# use admin
# include binding
# include ../common/function/*
# include function/*
# include ../common/skill/*
# include skill/*

# ---

attackS = ->

  if $isChanting
    return

  use '醒梦'
  use '光速'
  use '抽卡'

  if $isIM
    use '凶星'
    return
    
  if $isMoving
    use '烧灼', true
    return

  if use '烧灼' then return
  use '凶星'

attackM = ->

  if $isChanting
    return

  use '醒梦'
  use '光速'
  use '抽卡'

  if $isIM
    use '重力'
    return

  if $isMoving
    use '烧灼', true
    return

  use '重力'

# ---

healS = ->

  if $isChanting
    return

  if use '先天禀赋' then return
  
  use '醒梦'
  use '光速'
  use '抽卡'

  if use '吉星相位' then return
  if use '福星' then return
  use '吉星'

healM = ->

  if $isChanting
    return

  use '醒梦'
  use '光速'
  use '抽卡'

  if use '阳星相位' then return
  use '阳星'
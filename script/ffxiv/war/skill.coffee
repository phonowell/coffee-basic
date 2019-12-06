重劈时间戳 = 0
重劈冷却 = 5e3

重劈 = ->

  unless A_TickCount - 重劈时间戳 > 重劈冷却
    return false

  $.press 'alt + 1'
  
  $.setInterval 监听重劈, 200
  return true

监听重劈 = ->

  unless isUsed '重劈'
    return

  重劈时间戳 = A_TickCount - 2e3

  $.clearInterval 监听重劈

# ---

凶残裂时间戳 = 0
凶残裂冷却 = 5e3

凶残裂 = ->

  unless A_TickCount - 凶残裂时间戳 > 凶残裂冷却
    return false

  unless A_TickCount - 重劈时间戳 < 15e3
    return false

  $.press 'alt + 2'

  $.setInterval 监听凶残裂, 200
  return true

监听凶残裂 = ->

  unless isUsed '凶残裂'
    return

  凶残裂时间戳 = A_TickCount - 2e3
  重劈时间戳 = 0
  
  $.clearInterval 监听凶残裂

# ---

狂暴 = -> $.press 'alt + 3'
超压斧 = -> $.press 'alt + 4'
守护 = -> $.press 'alt + 5'
飞斧 = -> $.press 'alt + 6'
暴风斩 = -> $.press 'alt + 7'
战栗 = -> $.press 'alt + 8'
复仇 = -> $.press 'alt + 9'
死斗 = -> $.press 'alt + 0'
暴风碎 = -> $.press 'alt + minus'
原初之魂 = -> $.press 'alt + equal'
秘银暴风 = -> $.press 'ctrl + 1'
钢铁旋风 = -> $.press 'ctrl + 2'
战壕 = -> $.press 'ctrl + 3'
裂石飞环 = -> $.press 'ctrl + 4'
原初的直觉 = -> $.press 'ctrl + 5'
泰然自若 = -> $.press 'ctrl + 6'
地毁人亡 = -> $.press 'ctrl + 7'
猛攻 = -> $.press 'ctrl + 8'
动乱 = -> $.press 'ctrl + 9'
摆脱 = -> $.press 'ctrl + 0'
原初的解放 = -> $.press 'ctrl + minus'
原初的勇猛 = -> $.press 'ctrl + equal'
混沌旋风 = -> $.press 'shift + 1'
狂魂 = -> $.press 'shift + 2'
铁壁 = -> $.press 'shift + 3'
下踢 = -> $.press 'shift + 4'
挑衅 = -> $.press 'shift + 5'
插言 = -> $.press 'shift + 6'
雪仇 = -> $.press 'shift + 7'
亲疏自行 = -> $.press 'shift + 8'
退避 = -> $.press 'shift + 9'

# ---

索敌时间戳 = 0
索敌冷却 = 3e3

索敌 = ->

  unless A_TickCount - 索敌时间戳 > 索敌冷却
    return false

  if isChanting()
    return false

  $.press 'shift + minus'

  索敌时间戳 = A_TickCount - 2e3
  return true

# ---

清空信息 = -> $.press 'shift + equal'
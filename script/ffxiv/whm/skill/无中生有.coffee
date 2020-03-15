无中生有时间戳 = 0
无中生有冷却 = 120e3

无中生有 = ->

  unless A_TickCount - 无中生有时间戳 > 无中生有冷却
    return false

  $.press 'ctrl + 5'

  无中生有时间戳 = A_TickCount - 无中生有冷却 + 技能施放时间戳补正
  $.setInterval 监听无中生有, 技能施放判断间隔
  return true

监听无中生有 = ->
  unless hasStatus '无中生有'
    return
  $.clearInterval 监听无中生有
  无中生有时间戳 = A_TickCount - 技能施放时间戳补正
#use
$.use = (_name, _key) ->
  if _name != '取消技能'
    $.use '取消技能', 'x'
    delay 200
  switch _name
    when '取消技能'
      keyPress _key, 1
    when '丰收之歌'
      _skillSimpleCancelAfter _key, 5000

#使用然后取消的技能
#忍耐之歌、影子隐身术
_skillSimpleCancelAfter = (_key, _time) ->
  keyPress _key, 1
  delay _time
  $.use '取消技能', 'x'
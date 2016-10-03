$.act = (_name, _key) ->
  switch _name
    when '取消技能'
      keyPress _key, 1
    when '切换装备'
      keyPress _key, 1

#say
$.say = (_text) ->
  keyPress 'Enter', 1
  delay 200
  SayString _text
  delay 200
  keyPress 'Enter', 1
  delay 200
  keyPress 'Enter', 1
# ehp = 0
# getEnemyHp = ->
  
#   color = $.getColor 650, 65
#   unless color == 0xFF8888
#     return 0

#   [x, y] = $.findColor '#471515', 650, 65, 1084, 65

#   unless x
#     return 100
  
#   percent = (x - 650) * 100 / (1084 - 650)
#   percent = Math.floor percent
#   return percent
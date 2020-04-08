# $thp = 0

# checkTargetHp = ->
  
#   color = $.getColor 650, 65
#   unless color == 0xFF8888
#     $thp = 0
#     return

#   [x, y] = $.findColor '#471515', 650, 65, 1084, 65

#   unless x
#     $thp = 100
#     return
  
#   percent = (x - 650) * 100 / (1084 - 650)
#   percent = Math.floor percent
#   $thp = percent
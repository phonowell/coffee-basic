$red = 0
getRed = ->

  color = $.getColor 1075, 818
  unless color == 0xDEB673
    return 3

  color = $.getColor 1057, 818
  unless color == 0xDEB673
    return 2

  color = $.getColor 1039, 818
  unless color == 0xDEB673
    return 1

  return 0

# ---

$white = 0
getWhite = ->
  
  color = $.getColor 1078, 790
  unless color == 0xD6B273
    return 3

  color = $.getColor 1058, 790
  unless color == 0xD6B273
    return 2

  color = $.getColor 1038, 790
  unless color == 0xD6B273
    return 1

  return 0
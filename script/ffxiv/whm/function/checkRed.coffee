$red = 0

checkRed = ->

  color = $.getColor 1075, 818
  unless color == 0xDEB673
    $red = 3
    return

  color = $.getColor 1057, 818
  unless color == 0xDEB673
    $red = 2
    return

  color = $.getColor 1039, 818
  unless color == 0xDEB673
    $red = 1
    return

  $red = 0
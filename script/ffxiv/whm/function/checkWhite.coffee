$white = 0

checkWhite = ->
  
  color = $.getColor 1078, 790
  unless color == 0xD6B273
    $white = 3
    return

  color = $.getColor 1058, 790
  unless color == 0xD6B273
    $white = 2
    return

  color = $.getColor 1038, 790
  unless color == 0xD6B273
    $white = 1
    return

  $white = 0
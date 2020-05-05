$isOverheat = false

checkOverheat = ->

  unless $level >= 30
    $isOverheat = false
    return $isOverheat

  $isOverheat = A_TickCount - $ts.超荷 < 9e3
  return $isOverheat
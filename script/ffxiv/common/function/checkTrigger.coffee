$trigger = false

checkTrigger = ->

  isLT = $.isPressing '2-joy-7'
  isRT = $.isPressing '2-joy-8'

  if isLT and isRT
    $trigger = 'both'
    return $trigger
  
  if isLT
    $trigger = 'left'
    return $trigger
  
  if isRT
    $trigger = 'right'
    return $trigger

  $trigger = false
  return $trigger
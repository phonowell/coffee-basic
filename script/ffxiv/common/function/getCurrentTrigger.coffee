getCurrentTrigger = ->

  isLT = $.isPressing '2-joy-7'
  isRT = $.isPressing '2-joy-8'

  if isLT and isRT then return 'both'
  if isLT then return 'left'
  if isRT then return 'right'

  return
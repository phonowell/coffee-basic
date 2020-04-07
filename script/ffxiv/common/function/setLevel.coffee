$level = 80

setLevel = ->
  
  $level = prompt 'input level', $level
  
  unless $level > 0
    $level = 80

  if $level < 10
    $level = $level * 10

  resetTs()
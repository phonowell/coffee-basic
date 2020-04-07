$skill = {}

use = (name, option = false) ->
  
  unless $skill[name]
    alert "invalid skill: #{name}"
    return
  
  return $skill[name] option
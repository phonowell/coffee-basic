$cd = {}
$ts = {}

calcCd = (name) ->
  
  result = $cd[name] - (A_TickCount - $ts[name])
  
  unless result > 0
    return 0
  
  result = Math.round result / 1e3
  return result
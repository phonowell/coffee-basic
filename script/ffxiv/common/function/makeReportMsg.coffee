makeReportMsg = (msg, list) ->
  
  for name in list
    result = calcCd name
    unless result > 1
      continue
    msg = "#{msg}`n#{name}：#{result}s"
  
  return msg
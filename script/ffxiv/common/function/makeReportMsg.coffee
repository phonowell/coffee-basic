makeReportMsg = (msg, name) ->
  result = calcCd name
  unless result > 1
    return msg
  return "#{msg}`n#{name}：#{result}s"
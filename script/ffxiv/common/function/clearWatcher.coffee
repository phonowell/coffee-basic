$cd.技能施放判断间隔 = 100
$cd.技能施放补正 = 1500

clearWatcher = (name, type = 'hasUsed') ->
  
  if type == 'hasUsed'
    unless hasUsed name
      return
  else if type == 'status'
    unless hasStatus name
      return

  unless $watcher[name]
    alert "invalid watcher: #{name}"
    return
  
  clearInterval $watcher[name]
  $ts[name] = A_TickCount - $cd.技能施放补正
  return true
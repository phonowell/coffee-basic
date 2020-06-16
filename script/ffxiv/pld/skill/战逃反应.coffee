$ts.战逃反应 = 0
$cd.战逃反应 = 60e3

$skill.战逃反应 = ->

  unless A_TickCount - $ts.战逃反应 > $cd.战逃反应
    return

  $.press 'ctrl + 2'

  setInterval $watcher.战逃反应, $cd.技能施放判断间隔
  return true

$watcher.战逃反应 = -> clearWatcher '战逃反应', 'status'
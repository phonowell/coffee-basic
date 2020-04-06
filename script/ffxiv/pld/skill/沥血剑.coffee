$ts.沥血剑 = 0
$cd.沥血剑 = 2500

$skill.沥血剑 = ->

  unless $level >= 54
    return

  unless $step == 2
    return

  unless A_TickCount - $ts.沥血剑 > $cd.沥血剑
    return

  if hasStatusTarget '沥血剑-敌'
    return

  $.press 'ctrl + 4'

  setInterval $watcher.沥血剑, $cd.技能施放判断间隔
  return true

$watcher.沥血剑 = ->
  unless clearWatcher '沥血剑'
    return
  
  $step = 0
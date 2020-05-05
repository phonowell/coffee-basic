$ts.沥血剑 = 0
$cd.沥血剑 = 18e3

$skill.沥血剑 = ->

  unless $level >= 54
    return

  unless $step == 2
    return

  unless hasStatusByTarget '沥血剑-敌'
    $ts.沥血剑 = 0

  unless A_TickCount - $ts.沥血剑 > $cd.沥血剑
    return

  $.press 'ctrl + 4'

  setInterval $watcher.沥血剑, $cd.技能施放判断间隔
  return true

$watcher.沥血剑 = ->
  unless clearWatcher '沥血剑'
    return
  
  $step = 0
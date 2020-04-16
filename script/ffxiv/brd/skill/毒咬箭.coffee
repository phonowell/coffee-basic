$ts.毒咬箭 = 0
$cd.毒咬箭 = 27e3

$skill.毒咬箭 = ->

  unless hasStatusByTarget '毒咬箭-敌'
    $ts.毒咬箭 = 0

  unless A_TickCount - $ts.毒咬箭 > $cd.毒咬箭
    return

  $.press 'alt + 4'

  setInterval $watcher.毒咬箭, $cd.技能施放判断间隔
  return true

$watcher.毒咬箭 = -> clearWatcher '毒咬箭'
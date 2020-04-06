$ts.投盾 = 0
$cd.投盾 = 2500

$skill.投盾 = ->

  unless $level >= 15
    return

  unless A_TickCount - $ts.投盾 > $cd.投盾
    return

  $.press 'alt + 7'

  setInterval $watcher.投盾, $cd.技能施放判断间隔
  return true

$watcher.投盾 = ->
  unless clearWatcher '投盾'
    return
  
  $step = 0
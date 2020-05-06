$ts.失血箭 = 0
$cd.失血箭 = 15e3

$skill.失血箭 = ->

  unless $level >= 12
    return

  unless A_TickCount - $ts.贤者的叙事谣 < 30e3
    unless A_TickCount - $ts.失血箭 > $cd.失血箭
      return

  $.press 'alt + 5'

  setInterval $watcher.失血箭, $cd.技能施放判断间隔
  return true

$watcher.失血箭 = ->
  unless clearWatcher '失血箭'
    return
  $ts.死亡箭雨 = $ts.失血箭
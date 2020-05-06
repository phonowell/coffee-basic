$ts.死亡箭雨 = 0
$cd.死亡箭雨 = 15e3

$skill.死亡箭雨 = ->

  unless $level >= 45
    return

  unless $trigger == 'both'
    return

  unless A_TickCount - $ts.贤者的叙事谣 < 30e3
    unless A_TickCount - $ts.死亡箭雨 > $cd.死亡箭雨
      return

  $.press 'alt + equal'

  setInterval $watcher.死亡箭雨, $cd.技能施放判断间隔
  return true

$watcher.死亡箭雨 = ->
  unless clearWatcher '死亡箭雨'
    return
  $ts.失血箭 = $ts.死亡箭雨
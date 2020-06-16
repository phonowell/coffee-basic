$ts.深仁厚泽 = 0
$cd.深仁厚泽 = 2500

$skill.深仁厚泽 = ->

  unless $level >= 58
    return

  if $level >= 64
    unless $mp >= 20
      return
  else
    unless $mp >= 40
      return

  unless A_TickCount - $ts.深仁厚泽 > $cd.深仁厚泽
    return

  $.press 'alt + 6'

  setInterval $watcher.深仁厚泽, $cd.技能施放判断间隔
  return true

$watcher.深仁厚泽 = ->
  unless clearWatcher '深仁厚泽'
    return

  $step = 0
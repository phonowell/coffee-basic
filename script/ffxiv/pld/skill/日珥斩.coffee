$ts.日珥斩 = 0
$cd.日珥斩 = 2500

$skill.日珥斩 = ->

  unless $level >= 40
    return

  unless $step == 21
    return

  unless A_TickCount - $ts.日珥斩 > $cd.日珥斩
    return

  $.press 'ctrl + 1'

  setInterval $watcher.日珥斩, $cd.技能施放判断间隔
  return true

$watcher.日珥斩 = ->
  unless clearWatcher '日珥斩'
    return

  $step = 0

  clearTimeout resetStep
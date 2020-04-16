$ts.八卦无刃杀 = 0
$cd.八卦无刃杀 = 2500

$skill.八卦无刃杀 = ->

  unless $level >= 52
    return

  unless $step == 21
    return

  unless A_TickCount - $ts.八卦无刃杀 > $cd.八卦无刃杀
    return

  $.press 'ctrl + 5'

  setInterval $watcher.八卦无刃杀, $cd.技能施放判断间隔
  return true

$watcher.八卦无刃杀 = ->
  unless clearWatcher '八卦无刃杀'
    return

  $step = 0

  clearTimeout resetStep
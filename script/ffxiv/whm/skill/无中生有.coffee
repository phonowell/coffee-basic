$ts.无中生有 = 0
$cd.无中生有 = 120e3

$skill.无中生有 = ->

  unless $level >= 58
    return

  unless A_TickCount - $ts.无中生有 > $cd.无中生有
    return

  $.press 'alt + 5'

  $ts.无中生有 = A_TickCount - $cd.无中生有 + $cd.技能施放补正
  setInterval $watcher.无中生有, $cd.技能施放判断间隔
  return true

$watcher.无中生有 = -> clearWatcher '无中生有', 'status'
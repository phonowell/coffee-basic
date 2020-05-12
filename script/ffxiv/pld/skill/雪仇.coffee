$ts.雪仇 = 0
$cd.雪仇 = 60e3

$skill.雪仇 = ->

  unless A_TickCount - $ts.雪仇 > $cd.雪仇
    return

  $.press 'shift + 7'

  setInterval $watcher.雪仇, $cd.技能施放判断间隔
  return true

$watcher.雪仇 = -> clearWatcher '雪仇'
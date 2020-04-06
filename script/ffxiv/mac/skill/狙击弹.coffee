$ts.狙击弹 = 0
$cd.狙击弹 = 2500

$skill.狙击弹 = ->

  unless $level >= 26
    return

  unless $step == 2
    return

  unless A_TickCount - $ts.狙击弹 > $cd.狙击弹
    return

  $.press 'alt + 7'

  setInterval $watcher.狙击弹, $cd.技能施放判断间隔
  return true

$watcher.狙击弹 = ->
  unless clearWatcher '狙击弹'
    return
  
  $step = 0

  clearTimeout resetStep
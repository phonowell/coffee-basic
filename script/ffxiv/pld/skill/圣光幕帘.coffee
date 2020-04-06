$ts.圣光幕帘 = 0
$cd.圣光幕帘 = 90e3

$skill.圣光幕帘 = ->

  unless $level >= 56
    return

  unless A_TickCount - $ts.圣光幕帘 > $cd.圣光幕帘
    return

  $.press 'ctrl + 5'

  setInterval $watcher.圣光幕帘, $cd.技能施放判断间隔
  return true

$watcher.圣光幕帘 = -> clearWatcher '圣光幕帘'
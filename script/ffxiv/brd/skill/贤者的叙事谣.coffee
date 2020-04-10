$ts.贤者的叙事谣 = 0
$cd.贤者的叙事谣 = 80e3

$skill.贤者的叙事谣 = ->

  unless $level >= 30
    return

  unless A_TickCount - $ts.贤者的叙事谣 > $cd.贤者的叙事谣
    return

  unless hasStatus '猛者强击'
    return

  $.press 'alt + 9'

  setInterval $watcher.贤者的叙事谣, $cd.技能施放判断间隔
  return true

$watcher.贤者的叙事谣 = -> clearWatcher '贤者的叙事谣'
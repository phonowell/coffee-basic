$ts.猛者强击 = 0
$cd.猛者强击 = 80e3

$skill.猛者强击 = ->

  unless A_TickCount - $ts.猛者强击 > $cd.猛者强击
    return

  $.press 'alt + 3'

  setInterval $watcher.猛者强击, $cd.技能施放判断间隔
  return true

$watcher.猛者强击 = -> clearWatcher '猛者强击', 'status'
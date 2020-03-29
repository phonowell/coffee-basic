$ts.赤神圣 = 0

$skill.赤神圣 = ->

  unless $level >= 70
    return

  unless $step == 3
    return

  赤神圣施放()

  setInterval $watcher.赤神圣, $cd.技能施放判断间隔
  return true

$watcher.赤神圣 = ->
  isA = isUsed '赤核爆'
  isB = isUsed '赤神圣'
  unless isA or isB
    return
  clearInterval $watcher.赤神圣
  $ts.赤神圣 = A_TickCount - $cd.技能施放补正

  clearTimeout resetStep

  if $level >= 80
    $step = 4
    setTimeout resetStep, $cd.魔三连
  else
    $step = 0

赤神圣施放 = ->

  if $black - $white > 9
    use '赤疾风'
    return

  if $white - $black > 9
    use '赤闪雷'
    return

  if $isBR and $isWR
    if $black > $white
      use '赤疾风'
    else
      use '赤闪雷'
    return

  if $isBR
    use '赤疾风'
    return

  if $isWR
    use '赤闪雷'
    return

  if $black > $white
    use '赤疾风'
  else
    use '赤闪雷'
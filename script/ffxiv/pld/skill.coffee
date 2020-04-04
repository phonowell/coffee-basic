$cd.技能施放判断间隔 = 100
$cd.技能施放补正 = 1500

# ---

# include ../common/skill/*
# include skill/*

$skill.盾牌猛击 = -> $.press 'alt + 5'

$skill.钢铁信念 = -> $.press 'alt + 6'

$skill.投盾 = ->

  unless $level >= 15
    return

  $.press 'alt + 7'
  return true

$skill.厄运流转 = -> $.press 'alt + 0'

$skill.盾阵 = -> $.press 'alt + equal'

# ---

$skill.铁壁 = -> $.press 'shift + 1'

$skill.下踢 = -> $.press 'shift + 2'

$skill.挑衅 = -> $.press 'shift + 3'

$skill.插言 = -> $.press 'shift + 4'

$skill.血仇 = -> $.press 'shift + 5'

$skill.亲疏自行 = -> $.press 'shift + 6'

$skill.退避 = -> $.press 'shift + 7'

# ---

$skill.冲刺 = -> $.press 'shift + minus'
$skill.空白信息 = -> $.press 'shift + equal'

# ---
#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/skill.coffee
#=include lib/team-viewer.coffee

#main
main = ->

  ignoreTeamViewer()

  delay 500
  moveCenter()

  delay 1000
  useSkill '樱时雨', '1'
  delay 1000
  useSkill '螺旋斩', '2'
  delay 1000
  useSkill '影子束缚术', '3'
  delay 1000
  useSkill '烟幕术', '4'
  delay 1000
  useSkill '影子隐身术', '5'
  delay 1000
  useSkill '手里剑爆破术', '6'
  delay 1000
  useSkill '手里剑风暴', '7'
  delay 1000
  useSkill '忍耐之歌', '8'

  delay 3000
  getSkill()
  delay 500
  updateSkill()

  main()

moveCenter()
delay 200
leftClick 1

main()
#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/skill.coffee

#main
main = ->

  delay 1000
  #useSkill '樱时雨', '1'
  #useSkill '螺旋斩', '2'
  #useSkill '影子束缚术', '3'
  #useSkill '烟幕术', '4'
  #useSkill '影子隐身术', '5'
  #useSkill '手里剑爆破术', '6'
  useSkill '手里剑风暴', '7'
  #useSkill '忍耐之歌', '8'
  #useSkill '普通攻击', 1000
  delay 1000

  main()

moveCenter()
delay 200
leftClick 1

main()
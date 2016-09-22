#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/skill.coffee

#main
main = ->

  delay 1000
  getSkill()
  delay 100
  updateSkill()
  delay 1000

  main()

moveCenter()
delay 200
leftClick 1

main()
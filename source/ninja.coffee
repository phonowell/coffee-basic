#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/skill.coffee
#=include lib/team-viewer.coffee

press = (key) ->
  moveCenter()
  delay 500
  keyDown key, 1
  delay 200
  keyDown 'Ctrl', 1
  delay 200
  leftClick 1
  delay 200
  leftClick 1
  delay 200
  leftClick 1
  delay 2000
  keyUp 'Ctrl', 1
  delay 200
  keyUp key, 1
  delay 500
  leftClick 1
  delay 200
  leftClick 1
  delay 200
  keyPress 'w', 1
  delay 200
  keyPress 'd', 1
  delay 500

#main
main = ->

  ignoreTeamViewer()

  press '1'
  press '2'
  press '3'
  press '4'
  press '5'
  press '6'
  press '7'
  press '8'

  getSkill()
  delay 500
  updateSkill()

  main()

moveCenter()
delay 200
leftClick 1

main()
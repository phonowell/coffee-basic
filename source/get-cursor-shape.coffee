#=include lib/basic.coffee
#=include lib/cursor.coffee
#=include lib/act.coffee

#main
main = ->

  delay 1000

  shape = $.getShape()
  $.copy shape
  $.say shape

#execute
main()

#exit
onScriptExit = ->
  $.exit()
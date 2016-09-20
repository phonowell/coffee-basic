#=include lib/init.coffee
#=include lib/msg.coffee
#=include lib/cursor.coffee
#=include lib/image.coffee
#=include lib/get.coffee

#main
main = ->

  shape = cursorShape('current')
  Plugin.Sys.SetCLB shape
  showMessage shape

main()
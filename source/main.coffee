#=include lib/init.coffee
#=include lib/msg.coffee
#=include lib/image.coffee

#main
main = ->
  res = isImageExist '火结晶'
  showMessage "#{res}, #{x}, #{y}"
main()
# use admin
# include ../../common/function

# ---
# bind

# reload without cache
$.on 'ctrl + f5', ->
  resetKey()
  $.beep()
  $.reload()

# exit
$.on 'alt+f4', ->
  resetKey()
  $.beep()
  $.exit()

# execute
$.on 'f2', -> execute()

# ---
# variable

count = 0
long = 10
time = 1

# ---
# function

ask = ->

  long = prompt 'input long(巨匠药水：35)', 10
  unless long
    long = 10

  time = prompt 'input time', 1
  unless time
    time = 1

  count = 0

  await $.sleep 1e3
  $.click()

circle = ->

  if count >= time
    $.beep()
    return

  count++

  restart()
  craft()
  circle()

craft = ->
  report()
  $.press 'shift + 2'
  await $.sleep long * 1e3

execute = ->

  $.beep()

  ask()

  await $.sleep 1e3
  $.press 'shift + 1'
  await $.sleep 1e3

  circle()

report = ->
  msg = "#{count} / #{time} (#{long}s)"
  $.tip msg, 410, 640

restart = ->
  $.press 'num-0'
  await $.sleep 500
  $.press 'num-0'
  await $.sleep 500
  $.press 'num-0'
  await $.sleep 1e3
# use admin

# const

limit = 10

# skill

# ---

退出界面 = ->
  $.loop 4, ->
    await $.sleep 200
    $.press 'num-dot'
  await $.sleep 200
  await $.sleep 1e3

分解 = ->
  $.press 'shift:down', '9', 'shift:up'
  await $.sleep 1e3

  $.loop limit, ->
    $.press 'num-0'
    await $.sleep 500
    $.press 'num-4'
    await $.sleep 500
    $.press 'num-0'
    await $.sleep 3e3
    $.press 'num-0'
    await $.sleep 500

  退出界面()

# bind

$.on 'f12', ->
  $.beep()
  $.exit()

# ---

$.on 'f2', ->
  分解()
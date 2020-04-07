# use admin
# include ../common/function/*
# include binding
# include skill

# ---

使用 = (list) ->
  $.press list[0]
  await $.sleep list[1]
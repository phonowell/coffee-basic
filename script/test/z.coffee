cd = {}

$.on 'f2', ->
  cd.a = 1
  cd.b = 2
  cd.c = 3

  for key, value in cd
    cd[key] = 0

  alert "#{cd.a}, #{cd.b}, #{cd.c}"
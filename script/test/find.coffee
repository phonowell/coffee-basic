# find color

[x, y] = $.find '#fff', [0, 0], [100, 100]

if x > 0 and y > 0
  $.open 'Notepad'
else
  $.exit()

# find image

[x, y] = $.find 'img.jpg', [0, 0], [100, 100]
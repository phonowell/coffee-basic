# coffee-basic

## 内置函数

### alert(message)

没啥好说的。

```coffeescript
alert 'hello'
```

### Math

没啥好说的。

```coffeescript
a = Math.abs -1
b = Math.ceil 1.1
c = Math.floor 1.2
d = Math.round 1.3
```

### $.beep()

令系统发出“哔”的一声。

```coffeescript
$.beep()
```

### $.clearInterval(funcName)

类似于`js`中的`clearInterval()`，但只能使用函数名作为参数。

```coffeescript
$.clearInterval fn
```

### $.clearTimeout(funcName)

类似于`js`中的`clearTimeout()`，但只能使用函数名作为参数。

```coffeescript
$.clearTimeout fn
```

### $.click([string])

在鼠标的当前位置点击一次。

```coffeescript
$.click() # 点击左键
$.click 'right' # 点击右键
$.click 'right:down' # 按下右键
```

### $.exit()

退出脚本。

```coffeescript
$.exit()
```

### $.findColor(color[, x, y, x1, y1, variation])

找色。

```coffeescript
[x, y] = $.findColor '#fff' # 在整个屏幕区域内找色
[x1, y1] = $.findColor '#000', 0, 0, 100, 100 # 指定区域内找色
```

### $.findImage(path[, x, y, x1, y1, variation])

找图。

```coffeescript
[x, y] = $.findImage 'apple.png' # 查找和脚本同目录下的apple.png
```

### $.getColor([x, y])

获取指定位置的颜色。

```coffeescript
color = $.getColor() # 获取鼠标当前位置的颜色，返回的颜色总为0xFFFFFF的rgb格式
color = $.getColor 100, 100 # 获取指定位置的颜色
```

### $.getPosition()

获取鼠标位置。

```coffeescript
[x, y] = $.getPosition()
```

### $.getState(key)

获取按键状态。

```coffeescript
state = $.getState 'joy-1'
```

### $.info([message])

调用系统通知显示信息。

```coffeescript
$.info 'hello'
```

### $.isPressing(key)

判断按键是否被按下。

```coffeescript
isPressing = $.isPressing 'a'
```

### $.move(x, y)

移动鼠标到指定位置。

```coffeescript
$.move 100, 100
```

### $.open(cmd)

打开文档。

```coffeescript
$.open 'Notepad'
```

### $.press()

按下按键。

```coffeescript
$.press 'a'
$.press 'a:down'
$.press 'ctrl + shift + a'
```

### $.reload()

重载脚本。

```coffeescript
$.reload()
```

### $.setInterval(funcName)

类似于`js`中的`setInterval()`，但只能使用函数名作为参数。

```coffeescript
$.setInterval fn
```

### $.setTimeout(funcName)

类似于`js`中的`setTimeout()`，但只能使用函数名作为参数。

```coffeescript
$.setTimeout fn
```

### $.sleep(time)

挂起当前线程。

```coffeescript
$.sleep 1e3
```

### $.tip([message, x, y])

使用工具条显示信息。

```coffeescript
$.tip 'hello' # 显示信息
$.tip() # 隐藏信息
$.tip 'aloha', 100, 100 # 在指定位置显示信息
```

### $.trim(string)

没啥好说的。

```coffeescript
$.trim ' hello '
```

### $.trimEnd(string)

没啥好说的。

```coffeescript
$.trimEnd ' hello '
```

### $.trimStart(string)

没啥好说的。

```coffeescript
$.trimStart ' hello '
```

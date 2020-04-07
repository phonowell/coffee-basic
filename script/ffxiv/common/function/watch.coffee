$watcher = {}

watch = (name) ->

  unless $watcher[name]
    alert "invalid watcher: #{name}"
    return

  return $watcher[name]()
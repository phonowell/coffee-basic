; transpiled by coffee-basic

#noEnv
#persistent
#singleInstance force
#useHook

SetKeyDelay 0, 50
SendMode Event

; function

; simple
fn(){
  return 'result'
}

; double return
fn(){
  return 'result'
}

; with arguments
fn(a, b){
  return a + b
}
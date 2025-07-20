extends Node

var _jump_was_pressed := false
var _jump_just_released := false

func left_pressed() -> bool: 
    return Input.is_action_pressed("Left") or Connector.hud.left.is_pressed()

func right_pressed() -> bool:
    return Input.is_action_pressed("Right") or Connector.hud.right.is_pressed()

func jump_pressed() -> bool:
    return Input.is_action_pressed("Jump") or Connector.hud.jump.is_pressed()

func jump_just_released() -> bool:
    return _jump_just_released

func _physics_process(_delta):
    var jump_currently_pressed = jump_pressed()
    _jump_just_released = _jump_was_pressed and not jump_currently_pressed
    _jump_was_pressed = jump_currently_pressed

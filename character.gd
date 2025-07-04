extends CharacterBody2D
class_name Character

@export var max_power := 50

var _input_pressed := false
var _power = 0

func _input(event: InputEvent) -> void:
    _input_pressed = event.is_pressed()
    
func _process(delta: float) -> void:
    if _input_pressed:
        _power += delta
    else:
        _power = 0
    Connector.hud.update_power(min(_power*20, max_power))
    

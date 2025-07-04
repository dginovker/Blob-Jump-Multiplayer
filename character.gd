extends CharacterBody2D
class_name Character

@export var max_power := 2000

var _input_pressed := false
var _power = 0

func _input(event: InputEvent) -> void:
    _input_pressed = event.is_pressed()
        
func _physics_process(delta: float) -> void:
    if _input_pressed:
        _power += min(1000 * delta, max_power)
    else:
        if is_on_floor():
            velocity.y -= _power
            velocity.x += _power 
        _power = 0
    Connector.hud.update_power(_power)
    Connector.hud.set_debug(["Velocity: ", Vector2i(velocity)])

    velocity.y += delta * 200 # Gravity go brr
    move_and_slide()
    
    if is_on_floor():
        velocity = Vector2.ZERO            
    

extends CharacterBody2D
class_name Character

@export var max_power := 2000
@export var gravity := 200.0
@export var coyote_time := 0.1

var _input_pressed := false
var _jump_buffer := false
var _power := 0.0
var _pending_jump_power := 0.0
var _coyote_timer := 0.0

func _input(event: InputEvent) -> void:
    # If you were holding and released, buffer a jump
    if _input_pressed and not event.is_pressed():
        _jump_buffer = true
        _pending_jump_power = _power
    _input_pressed = event.is_pressed()

func _process(delta: float) -> void:
    # Build up power while holding
    if _input_pressed:
        _power = min(_power + 1000 * delta, max_power)
    Connector.hud.update_power(_power)

func _physics_process(delta: float) -> void:
    # Apply gravity
    velocity.y += gravity * delta

    # Update coyote timer
    if is_on_floor():
        _coyote_timer = coyote_time
    else:
        _coyote_timer -= delta

    # If we have a buffered jump and are within coyote time, jump
    if _jump_buffer and _coyote_timer > 0.0:
        velocity.y = -_pending_jump_power
        velocity.x += _pending_jump_power / 2
        _jump_buffer = false
        _power = 0
        _pending_jump_power = 0

    # Move the character
    move_and_slide()

    # Stop falling if landed
    if is_on_floor() and velocity.y >= 0:
        velocity = Vector2.ZERO

    # For debugging
    Connector.hud.set_debug("""Velocity: {0}
On floor: {1}"""
    .format([Vector2i(velocity), is_on_floor()]))

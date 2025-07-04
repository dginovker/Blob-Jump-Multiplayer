extends CharacterBody2D
class_name Character

@export var max_power := 2000
@export var gravity := 600
@export var coyote_time := 0.1

var _camera_zoom_max := 0.5
var _camera_zoom_min := 0.05

var _input_pressed := false
var _power := 0.0
var _pending_jump_power := 0.0
var _coyote_timer := 0.0

func _ready():
    GameManager.restart(self)

func _input(event: InputEvent) -> void:
    # If you were holding and released, buffer a jump
    if _input_pressed and not event.is_pressed():
        _pending_jump_power = _power
        _power = 0
    _input_pressed = event.is_pressed()

func _process(delta: float) -> void:
    # Make Camera zoom out the faster the character goes
    var target_zoom = clampf(lerpf(_camera_zoom_max, _camera_zoom_min, max(abs(velocity.x) - 500, 0) / 1000), _camera_zoom_min, _camera_zoom_max)
    # Smoothly interpolate current zoom towards target
    # 0.1 is the smoothing factor — tweak this for more/less smoothness
    $Camera2D.zoom.x = lerp($Camera2D.zoom.x, target_zoom, delta)
    $Camera2D.zoom.y = lerp($Camera2D.zoom.y, target_zoom, delta)

func _physics_process(delta: float) -> void:
    velocity.y += gravity * delta

    # Update coyote timer
    if is_on_floor():
        # Build up power while holding
        if _input_pressed:
            _power = min(_power + 1000 * delta, max_power)
        Connector.hud.update_power(_power)
    
        _coyote_timer = coyote_time
    else:
        _coyote_timer -= delta

    # If we have a buffered jump and are within coyote time, jump
    if _pending_jump_power > 0 and _coyote_timer > 0.0:
        velocity.y = -_pending_jump_power
        velocity.x += _pending_jump_power * 0.8
        _pending_jump_power = 0
    move_and_slide()

    # Stop falling if landed
    if is_on_floor() and velocity.y >= 0:
        velocity = Vector2.ZERO
    
    if get_last_slide_collision() != null:
        Connector.pillar_manager.player_touched(get_last_slide_collision().get_collider() as Pillar)

    if position.y > 1500:
        GameManager.restart(self)

    # For debugging
    Connector.hud.set_debug("""Velocity: {0}
On floor: {1}
Position: {2}"""
    .format([Vector2i(velocity), is_on_floor(), Vector2i(position)]))

extends RigidBody2D
class_name Character

@onready var blood: CPUParticles2D = $CPUParticles2D

@export var max_power := 1000
@export var coyote_time := 0.1

var _camera_zoom_max := 0.5
var _camera_zoom_min := 0.05

var _power := 0.0
var _pending_jump_power := 0.0
var _coyote_timer := 0.0
@export var score := 0
var touched_stars: Dictionary[Node, bool] = {}
var checkpoint_stars: Dictionary[Node, bool] = {}
var checkpoint: Area2D = null
var fuel: bool = false
var checkpoint_fuel: bool = false
var parachute_time: float = 0

func _ready():
    $SteamRightAnimatedSprite2D.play("default")
    $SteamLeftAnimatedSprite2D.play("default")
    if not is_multiplayer_authority():
        return
    $Camera2D.make_current()
    GameManager.restart(self)
    print("Spawned with multiplayer authority ", get_multiplayer_authority())        

func _process(delta: float) -> void:
    if not is_multiplayer_authority():
        return
    # Make Camera zoom out the faster the character goes
    var target_zoom = clampf(lerpf(_camera_zoom_max, _camera_zoom_min, max(abs(linear_velocity.x) - 500, 0) / 1000), _camera_zoom_min, _camera_zoom_max)
    # Smoothly interpolate current zoom towards target
    # 0.1 is the smoothing factor — tweak this for more/less smoothness
    $Camera2D.zoom.x = lerp($Camera2D.zoom.x, target_zoom, delta)
    $Camera2D.zoom.y = lerp($Camera2D.zoom.y, target_zoom, delta)
    Connector.hud.set_fuel(fuel)
    Connector.hud.set_parachute(parachute_time > 0)

func _physics_process(delta: float) -> void:
    # No idea how you would sync the material state so we just sync
    # the _power and make every client update
    ($Arm/ArmPowerSprite2D.material as ShaderMaterial).set_shader_parameter("cutoff", lerpf(0, 1, _power/max_power))
    $SteamRightAnimatedSprite2D.visible = _power > 0
    $SteamLeftAnimatedSprite2D.visible = _power > 0
    $Sprite2D.scale.y = lerpf(1, 0.7, _power/max_power)
    $Title/PanelContainer/PointsLabel.text = "Points: {0}".format([score])
    $Title.visible = score > 0 
    $ParachuteSprite2D.visible = parachute_time > 0
    
    parachute_time -= delta
    
    if not is_multiplayer_authority():
        return
    
    if $Area2D.is_stabbed():
        GameManager.die(self)
        return
    
    score = len(touched_stars)

    if CustomInput.left_pressed():
        $Arm.rotation -= delta * 5
    if CustomInput.right_pressed():
        $Arm.rotation += delta * 5        

    if CustomInput.jump_pressed():
        _power = min(_power + 1000 * delta, max_power)
    Connector.hud.update_power(_power)
    if $Area2D.is_colliding():
        _coyote_timer = coyote_time
    else:
        _coyote_timer -= delta

    if CustomInput.jump_just_released():
        _pending_jump_power = _power
        _power = 0

    # If we have a buffered jump and are within coyote time, jump
    if _pending_jump_power > 0 and _coyote_timer > 0.0:
        _jump()
    # If we have a double jump and are outside the coyote time, jump
    if CustomInput.jump_just_released() and fuel and _coyote_timer <= 0:
        fuel = false
        @warning_ignore("integer_division")
        _pending_jump_power = max_power / 2
        _jump()

    if position.y > 1500:
        GameManager.restart(self)

    if parachute_time > 0:
        # Technically this race conditions with die() but idc
        var angle = $Arm.rotation + PI/2
        apply_force(Vector2(cos(angle), sin(angle)) * (_pending_jump_power + 600))

    # For debugging
    Connector.hud.set_debug("""Position: {0}
On floor: {1}"""
    .format([Vector2i(position), $Area2D.is_colliding()]))

func _jump():
    var angle = $Arm.rotation + PI/2
    var jump_impulse = Vector2(cos(angle), sin(angle)) * _pending_jump_power
    apply_central_impulse(jump_impulse)
    _pending_jump_power = 0

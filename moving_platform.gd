extends AnimatableBody2D

@export var move_speed := 250
@onready var path_follow: PathFollow2D = get_parent()

var _path_direction := 1
var _progress_tween: Tween
var _sync_timer := 0.2

func _physics_process(delta: float) -> void:
    path_follow.progress += move_speed * delta * _path_direction
    if path_follow.progress_ratio <= 0\
        or path_follow.progress_ratio >= 1:
        _path_direction *= -1

    if not multiplayer.is_server():
        return
    
    _sync_timer -= delta
    if _sync_timer < 0:
        _sync_timer = 0.2
        reconcile.rpc(path_follow.progress, _path_direction)

@rpc("authority", "call_local")
func reconcile(server_progress: float, server_direction: int):
    if multiplayer.is_server():
        return
    _path_direction = server_direction

    if _progress_tween:
        _progress_tween.kill()
    _progress_tween = create_tween()
    _progress_tween.tween_property(
        path_follow, "progress", server_progress, 1.0
    ).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

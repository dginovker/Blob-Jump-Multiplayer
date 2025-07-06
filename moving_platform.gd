extends AnimatableBody2D

@export var move_speed := 500
@onready var path_follow: PathFollow2D = get_parent()

var path_direction = 1

func _physics_process(delta: float) -> void:
    path_follow.progress += move_speed * delta * path_direction
    if path_follow.progress_ratio <= 0\
        or path_follow.progress_ratio >= 1:
        path_direction *= -1
        

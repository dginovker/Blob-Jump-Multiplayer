extends Area2D
class_name FatRaycast2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)

var _collisions: Dictionary[Node, bool] = {}
var _spikes: Dictionary[Node, bool] = {}

func is_colliding() -> bool:
    return len(_collisions) > 0

func is_stabbed() -> bool:
    return len(_spikes) > 0
    
func _on_body_entered(other: Node):
    if other == Connector.spike_tile_map_layer:
        print("Ouchy!")
        _spikes[other] = true
    else:
        _collisions[other] = true

func _on_body_exited(other: Node):
    _collisions.erase(other)
    _spikes.erase(other)

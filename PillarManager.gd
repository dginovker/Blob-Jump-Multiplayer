extends Node
class_name PillarManager

var _collided_pillars: Dictionary[Pillar, bool] = {}
var _spawned_pillars: Dictionary[Pillar, bool] = {}
var _pillar_scene = preload("res://pillar.tscn")

func _ready():
    Connector.register_pillar_manager(self)

func restart():
    for pillar: Pillar in _spawned_pillars:
        pillar.queue_free()
    _collided_pillars = {}
    _spawned_pillars = {}

func player_touched(pillar: Pillar):
    if pillar in _collided_pillars:
        return
    _collided_pillars[pillar] = true
    # Spawn the next pillar
    var new_pillar: Pillar = _pillar_scene.instantiate()
    # Set the distance relative to the existing pillar
    new_pillar.transform = pillar.transform
    new_pillar.position.x += 200 + 200 * len(_collided_pillars)
    _spawned_pillars[new_pillar] = true
    add_child(new_pillar)

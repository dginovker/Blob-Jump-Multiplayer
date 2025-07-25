extends MultiplayerSpawner

func _ready():
    Connector.register_multiplayer_spawner(self)
    spawn_function = _custom_spawn

var PlayerScene: PackedScene = preload("res://Scenes/character.tscn")
func _custom_spawn(peer_id: int) -> Node:
    print("In custom spawn")
    var p: Character = PlayerScene.instantiate()
    p.name = str(peer_id)
    p.set_multiplayer_authority(peer_id)
    print("Returning ", p)
    return p
    
func _process(_delta: float) -> void:
    var scores: Array[int] = []
    for node in $"..".get_children():
        if node is Character:
            scores.append((node as Character).score)
    Connector.hud.update_hiscores(scores)

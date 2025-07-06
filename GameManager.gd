extends Node

func restart(player: Character) -> void:
    #player.position = Vector2(0, -100)
    player.position = Vector2(7100, -1800)
    player.linear_velocity = Vector2.ZERO
    for obj: Node in player.touched_objs:
        obj.visible = true
    for obj: Node in player.checkpoint_objs:
        obj.visible = false
    player.touched_objs = player.checkpoint_objs.duplicate()

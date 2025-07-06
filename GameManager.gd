extends Node

func restart(player: Character) -> void:
    #player.position = Vector2(0, -100)
    player.position = Vector2(7100, -1200)
    player.linear_velocity = Vector2.ZERO
    for obj: Node in player.touched_objs:
        obj.visible = true
    player.touched_objs = {}

extends Node

func restart(player: Character) -> void:
    var respawn_position = Vector2(0, -100)
    #var respawn_position = Vector2(7100, -1800)
    if player.checkpoint != null:
        respawn_position = player.checkpoint.position
    player.position = respawn_position
    player.linear_velocity = Vector2.ZERO
    for obj: Node in player.touched_stars:
        obj.visible = true
    for obj: Node in player.checkpoint_stars:
        obj.visible = false
    player.touched_stars = player.checkpoint_stars.duplicate()

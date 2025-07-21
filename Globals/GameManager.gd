extends Node

func die(player: Character) -> void:
    if not player.blood.emitting:
        player.blood.restart()
    player.freeze = true
    player.linear_velocity = Vector2.ZERO
    await get_tree().create_timer(0.5).timeout
    player.freeze = false
    player.blood.emitting = false
    restart(player)

func restart(player: Character) -> void:
    #var respawn_position = Vector2(0, -100)
    var respawn_position = Vector2(6500, -5000)
    if player.checkpoint != null:
        respawn_position = player.checkpoint.position
    player.position = respawn_position
    player.linear_velocity = Vector2.ZERO
    for obj: Node in player.touched_stars:
        obj.visible = true
    for obj: Node in player.checkpoint_stars:
        obj.visible = false
    player.touched_stars = player.checkpoint_stars.duplicate()
    player.fuel = player.checkpoint_fuel

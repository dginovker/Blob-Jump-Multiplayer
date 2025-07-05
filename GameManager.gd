extends Node

func restart(player: Character) -> void:
    player.position = Vector2(518, 200)
    player.linear_velocity = Vector2.ZERO
    if Connector.pillar_manager:
        Connector.pillar_manager.restart()

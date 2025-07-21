extends Area2D

func _ready() -> void:
    body_entered.connect(_on_entered)
    
func _on_entered(body: Node):
    if body is not Character:
        return
    var player = body as Character
    if len(player.touched_stars) < 50:
        Connector.hud.set_game_message_box("You need at least 50 stars to reset them!")    
        return
    for obj: Node in player.touched_stars:
        obj.visible = true
    for obj: Node in player.checkpoint_stars:
        obj.visible = true
    player.boosted_stars += len(player.touched_stars)
    player.checkpoint_stars.clear()
    player.touched_stars.clear()
    Connector.hud.set_game_message_box("Go get those stars again!")

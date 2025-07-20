extends Area2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body: Node) -> void:
    if body is not Character:
        return
    var player = body as Character
    if not player.is_multiplayer_authority():
        return
    # Enable this checkpoint
    $RedSprite2D.visible = false
    $GreenSprite2D.visible = true
    # Disable any previous checkpoint
    if player.checkpoint != null and player.checkpoint != self:
        player.checkpoint.get_node("RedSprite2D").visible = true
        player.checkpoint.get_node("GreenSprite2D").visible = false
    player.checkpoint = self
    player.checkpoint_stars = player.touched_stars.duplicate()
    player.checkpoint_fuel = player.fuel

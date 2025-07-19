extends Area2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body: Node) -> void:
    if body is not Character:
        return
    body = body as Character
    if not body.is_multiplayer_authority():
        return
    # Enable this checkpoint
    $RedSprite2D.visible = false
    $GreenSprite2D.visible = true
    # Disable any previous checkpoint
    if body.checkpoint != null and body.checkpoint != self:
        body.checkpoint.get_node("RedSprite2D").visible = true
        body.checkpoint.get_node("GreenSprite2D").visible = false
    body.checkpoint = self
    body.checkpoint_stars = body.touched_stars.duplicate()

extends Area2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body: Node) -> void:
    if body is not Character:
        return
    if not (body as Character).is_multiplayer_authority():
        return        
    visible = false
    (body as Character).touched_stars[self] = true

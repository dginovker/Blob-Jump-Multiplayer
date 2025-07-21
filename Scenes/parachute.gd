extends Area2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body is not Character:
        return
        
    # Give the character a parachute
    self.visible = false
    (body as Character).parachute_time = 5
    # Disable this body for some seconds
    await get_tree().create_timer(5.0).timeout
    self.visible = true

extends Area2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body is Character:
        # Give the character an extra jump
        self.visible = false
        (body as Character).fuel = true
        # Disable this body for 10 seconds
        await get_tree().create_timer(5.0).timeout
        self.visible = true

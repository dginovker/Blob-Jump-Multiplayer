extends Area2D

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body: Node) -> void:
    if body is not Character:
        return
    body = body as Character
    $RedSprite2D.visible = false
    $GreenSprite2D.visible = true
    body.checkpoint_position = position
    body.checkpoint_objs = body.touched_objs.duplicate()

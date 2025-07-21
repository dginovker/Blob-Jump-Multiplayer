extends Area2D

func _ready() -> void:
    body_entered.connect(_body_entered)
    body_exited.connect(_body_exited)
    
func _body_entered(body: Node):
    if body is not Character:
        return
    var character = (body as Character)
    if len(character.touched_stars) >= 50:
        Connector.hud.set_game_message_box("Congratulations!")
        if $GateBody2D != null:
            $GateBody2D.queue_free()
    else:
        Connector.hud.set_game_message_box("You need 50 stars\nto pass this gate")
    
func _body_exited(body: Node):
    if body is not Character:
        return

extends Area2D
class_name RecolorScript

@export var color: String = "blue"

func _ready() -> void:
    body_entered.connect(_body_entered)
    $Sprite2D.texture = color_to_texture(color)
    
func _body_entered(body: Node):
    if body is not Character:
        return
    (body as Character).color = color

const _blue_texture := preload("res://Sprites/slime.png")
const _purple_texture := preload("res://Sprites/purple_slime.png")
const _green_texture := preload("res://Sprites/green_slime.png")
static func color_to_texture(col: String) -> Texture2D:
    if col == "blue":
        return _blue_texture
    elif col == "purple":
        return _purple_texture
    else:
        return _green_texture

extends Control
class_name Hud

@onready var left: TextureButton = $MobileControlsVBox/HBoxContainer2/LeftButton
@onready var right: TextureButton = $MobileControlsVBox/HBoxContainer2/RightButton
@onready var jump: TextureButton = $MobileControlsVBox/HBoxContainer2/JumpButton

func _ready() -> void:
    Connector.register_hud(self)
    var singleplayer_button: Button = $Loading/VBoxContainer/Button
    singleplayer_button.pressed.connect(_start_singleplayer)
    # Debug stuff
    #$PanelContainer/VBoxContainer/PowerLabel.visible = true
    #$PanelContainer/VBoxContainer/DebugLabel.visible = true

func update_power(power: float):
    $PanelContainer/VBoxContainer/PowerLabel.text = "Power: " + str(int(power))
     
func set_debug(data: String):
    var label: Label = $PanelContainer/VBoxContainer/DebugLabel
    label.text = data

func update_hiscores(scores: Array[int]):
    var text = "Hiscores:\n"
    for i in range(min(len(scores), 5)):
        text += str(scores[i]) + "\n"
    text += "Online: " + str(len(scores))
    var label: Label = $PanelContainer/VBoxContainer/HiscoreLabel
    label.text = text
    
func set_fuel(vis: bool) -> void:
    $Items/HBoxContainer/Fuel.visible = vis

func hide_loading() -> void:
    $Loading.visible = false
    
func _start_singleplayer() -> void:
    hide_loading()
    print("Starting singleplayer...")
    Connector.multiplayer_spawner.spawn(1)

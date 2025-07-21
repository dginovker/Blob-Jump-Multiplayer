extends Control
class_name Hud

@onready var left: TouchScreenButton = $MobileControlsVBox/HBoxContainer2/CenterContainer1/LeftTouchScreenButton
@onready var jump: TouchScreenButton = $MobileControlsVBox/HBoxContainer2/CenterContainer2/JumpTouchScreenButton
@onready var right: TouchScreenButton = $MobileControlsVBox/HBoxContainer2/CenterContainer3/RightTouchScreenButton

func _ready() -> void:
    Connector.register_hud(self)
    var singleplayer_button: Button = $Loading/VBoxContainer/Button
    singleplayer_button.pressed.connect(_start_singleplayer)
    # Debug stuff
    #$PanelContainer/VBoxContainer/PowerLabel.visible = true
    $PanelContainer/VBoxContainer/DebugLabel.visible = true

func update_power(power: float):
    $PanelContainer/VBoxContainer/PowerLabel.text = "Power: " + str(int(power))
     
func set_debug(data: String):
    var label: Label = $PanelContainer/VBoxContainer/DebugLabel
    label.text = data

func update_hiscores(scores: Array[int]):
    var text = "Hiscores:\n"
    scores.sort()
    for i in range(min(len(scores), 5)):
        text += str(scores[-i-1]) + "\n"
    text += "Online: " + str(len(scores))
    var label: Label = $PanelContainer/VBoxContainer/HiscoreLabel
    label.text = text
    
func set_fuel(vis: bool) -> void:
    $Items/HBoxContainer/Fuel.visible = vis

func set_parachute(vis: bool) -> void:
    $Items/HBoxContainer/Parachute.visible = vis

func hide_loading() -> void:
    $Loading.visible = false
    
func _start_singleplayer() -> void:
    hide_loading()
    print("Starting singleplayer...")
    Connector.multiplayer_spawner.spawn(1)
    
func set_game_message_box(text: String) -> void:
    $GameMessageBox/VBoxContainer/Label.text = text
    $GameMessageBox.visible = true
    await get_tree().create_timer(10).timeout
    $GameMessageBox.visible = false

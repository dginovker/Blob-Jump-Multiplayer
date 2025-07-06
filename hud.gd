extends Control
class_name Hud

func _ready() -> void:
    Connector.register_hud(self)
    # Debug stuff
    $PanelContainer/VBoxContainer/PowerLabel.visible = false
    #$PanelContainer/VBoxContainer/DebugLabel.visible = false

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

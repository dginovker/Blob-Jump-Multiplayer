extends Control
class_name Hud

func _ready() -> void:
    Connector.register_hud(self)

func update_power(power: float):
    $PanelContainer/VBoxContainer/PowerLabel.text = "Power: " + str(int(power))
     
func set_debug(data: String):
    var label: Label = $PanelContainer/VBoxContainer/DebugLabel
    label.text = data

extends Control
class_name Hud

func _ready() -> void:
    Connector.register_hud(self)

func update_power(power: float):
    $PanelContainer/Label.text = "Power: " + str(int(power))

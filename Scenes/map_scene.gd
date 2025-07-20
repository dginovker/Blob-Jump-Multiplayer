extends Node2D

func _ready() -> void:
    Connector.register_spike_tile_map_layer($SpikeTileMapLayer)

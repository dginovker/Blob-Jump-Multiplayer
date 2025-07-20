extends Node

var hud: Hud
func register_hud(p_hud: Hud):
    hud = p_hud

var multiplayer_spawner: MultiplayerSpawner
func register_multiplayer_spawner(p_multiplayer_spawner: MultiplayerSpawner):
   multiplayer_spawner = p_multiplayer_spawner

var spike_tile_map_layer: TileMapLayer
func register_spike_tile_map_layer(p_spike_tile_map_layer: TileMapLayer):
    spike_tile_map_layer = p_spike_tile_map_layer

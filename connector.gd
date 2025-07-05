extends Node

var hud: Hud
func register_hud(p_hud: Hud):
    hud = p_hud

var pillar_manager: PillarManager
func register_pillar_manager(p_pillar_manager: PillarManager):
    pillar_manager = p_pillar_manager

var multiplayer_spawner: MultiplayerSpawner
func register_multiplayer_spawner(p_multiplayer_spawner: MultiplayerSpawner):
   multiplayer_spawner = p_multiplayer_spawner

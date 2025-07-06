extends Node
class_name ServerManager

func _ready():
    var peer = ENetMultiplayerPeer.new()
    var result = peer.create_server(9999)
    if result == OK:
        print("Server started")
        multiplayer.multiplayer_peer = peer
        multiplayer.peer_connected.connect(_add_player_to_game)
        _add_player_to_game(1)  # Spawn character for server
    elif result == ERR_CANT_CREATE:
        print("Joining as client")
        result = peer.create_client("127.0.0.1", 9999)
        multiplayer.multiplayer_peer = peer

var player_scene = preload("res://Scenes/character.tscn")

func _add_player_to_game(id):
    if not multiplayer.is_server():
        return
    print("As the server, I'm going to spawn ", id)
    Connector.multiplayer_spawner.spawn(id)

extends Node
class_name ServerManager

var player_scene = preload("res://Scenes/character.tscn")
var peer : WebSocketMultiplayerPeer

func _ready():
    peer = WebSocketMultiplayerPeer.new()
    # If we're running in the browser, just connect to the server
    if OS.get_name() == "Web":
        print("Joining as WebSocket client")
        #peer.create_client("ws://127.0.0.1:9999") # Local!!
        peer.create_client("wss://duck.openredsoftware.com/blobjump") # Real server!
        print("Client created")
        get_tree().get_multiplayer().multiplayer_peer = peer
        get_tree().get_multiplayer().peer_connected.connect(_on_client_connected)
        return
        
    # For local development, create the server
    print("Not in browser, running server!")
    var server_result = peer.create_server(9999)
    if server_result == OK:
        print("Server started")
        get_tree().get_multiplayer().multiplayer_peer = peer
        get_tree().get_multiplayer().peer_connected.connect(_add_player_to_game)
        _add_player_to_game(1)
        Connector.hud.hide_loading()
    else:
        print("Server do be failed.")

func _on_client_connected(id):
    print("Connected as client, id: ", id)
    Connector.hud.hide_loading()

func _add_player_to_game(id):
    if not get_tree().get_multiplayer().is_server():
        return
    print("Spawning player ", id)
    Connector.multiplayer_spawner.spawn(id)

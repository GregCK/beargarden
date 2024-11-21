extends Node2D

const GRID_SIZE:int = 32

@onready var gridHelper:Node2D = $GridHelper
@onready var groundTileMapLayer:TileMapLayer = $GroundTileMapLayer
@onready var player:Player = $Player

var tile_pos_in_front_of_player:Vector2i


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("enter_water_state", _on_player_enter_water_state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(_delta):
	if player:
		var player_pos = player.global_position
		var tile_pos_player_is_on = groundTileMapLayer.local_to_map(player_pos)
		tile_pos_in_front_of_player = tile_pos_player_is_on + player.face_direction
		gridHelper.global_position = tile_pos_in_front_of_player * GRID_SIZE

func _on_player_enter_water_state():
	pass

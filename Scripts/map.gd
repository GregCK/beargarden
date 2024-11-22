extends Node2D

const GRID_SIZE:int = 32

const DIRT_DRY:int = 1
const DIRT_WET:int = 2

@onready var gridHelper:Node2D = $GridHelpers/GridHelperFront
@onready var groundTileMapLayer:TileMapLayer = $GroundTileMapLayer
@onready var player:Player = $Player

var tile_pos_in_front_of_player:Vector2i


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("enter_water_state", _on_player_enter_water_state)


func _physics_process(_delta):
	if player:
		tile_pos_in_front_of_player = get_tile_pos_in_front_of_player()
		gridHelper.global_position = tile_pos_in_front_of_player * GRID_SIZE


func get_tile_pos_in_front_of_player():
	var player_pos = player.global_position
	var tile_pos_player_is_on = groundTileMapLayer.local_to_map(player_pos)
	tile_pos_in_front_of_player = tile_pos_player_is_on + player.face_direction
	return tile_pos_in_front_of_player


func _on_player_enter_water_state():
	pass

func _input(event):
	if event.is_action_released("water"):
		if player.state == Player.States.WATER:
			water()

func water():
	groundTileMapLayer.set_cell(tile_pos_in_front_of_player, DIRT_WET, Vector2i(0,0), 0)
	player.switch_state(Player.States.MOVE)

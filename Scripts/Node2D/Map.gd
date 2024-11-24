class_name Map
extends Node2D

const GRID_SIZE:int = 32

const DIRT_DRY:int = 1
const DIRT_WET:int = 2

@export var preMapData:MapData
var mapData:MapData


@onready var gridHelperFront:Node2D = $GridHelpers/GridHelperFront
@onready var gridHelperLarge:Node2D = $GridHelpers/GridHelperLarge
@onready var groundTileMapLayer:TileMapLayer = $GroundTileMapLayer
@onready var plantTileMapLayer:TileMapLayer = $PlantTileMapLayer
@onready var player:Player = $Player

var tile_pos_in_front_of_player:Vector2i
var tile_pos_player_is_on:Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("enter_water_state", _on_player_enter_water_state)
	player.connect("enter_plant_state", _on_player_enter_plant_state)
	gridHelperLarge.hide()
	gridHelperFront.hide()
	mapData = preMapData.duplicate(true)
	groundTileMapLayer.generate_tiles_from_mapData(mapData)

func _physics_process(_delta):
	if player:
		tile_pos_player_is_on = get_tile_pos_player_is_on()
		gridHelperLarge.global_position = tile_pos_player_is_on * GRID_SIZE
		
		tile_pos_in_front_of_player = get_tile_pos_in_front_of_player()
		gridHelperFront.global_position = tile_pos_in_front_of_player * GRID_SIZE
		
		

func get_tile_pos_player_is_on():
	var player_pos = player.global_position
	var tile_pos_player_is_on = groundTileMapLayer.local_to_map(player_pos)
	return tile_pos_player_is_on

func get_tile_pos_in_front_of_player():
	var tile_pos_player_is_on = get_tile_pos_player_is_on()
	tile_pos_in_front_of_player = tile_pos_player_is_on + player.face_direction
	return tile_pos_in_front_of_player


func _on_player_enter_water_state():
	gridHelperLarge.show()

func _on_player_enter_plant_state():
	gridHelperFront.show()

func _input(event):
	if event.is_action_released("water"):
		if player.state == Player.States.WATER:
			water()
	if event.is_action_released("use_item"):
		if player.state == Player.States.PLANT:
			plant()
	if event.is_action_pressed("cancel"):
		gridHelperLarge.hide()
		gridHelperFront.hide()
		player.switch_state(Player.States.MOVE)


func water():
	for i in range(-1, 2):
		for j in range(-1, 2):
			var adjustment_vector = Vector2i(i, j)
			var curr_tile:Vector2i = tile_pos_player_is_on + adjustment_vector
			
			mapData.water_tile(curr_tile)
			groundTileMapLayer.set_cell(curr_tile, DIRT_WET, Vector2i(0,0), 0)
	
	
	gridHelperLarge.hide()
	player.switch_state(Player.States.MOVE)

func plant():
	var plant_source_id = player.inventory[player.inventory_selected_index].plant_type.tilemap_source_id
	if plant_source_id <= 0:
		push_warning("invalid plant source id")
	plantTileMapLayer.set_cell(tile_pos_in_front_of_player, plant_source_id, Vector2i(0,0), 0)
	gridHelperFront.hide()
	player.switch_state(Player.States.MOVE)
	
	
func water_front():
	groundTileMapLayer.set_cell(tile_pos_in_front_of_player, DIRT_WET, Vector2i(0,0), 0)
	player.switch_state(Player.States.MOVE)

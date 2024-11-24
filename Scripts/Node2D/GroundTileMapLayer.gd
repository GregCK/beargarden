class_name GroundTileMapLayer
extends TileMapLayer


func generate_tiles_from_mapData(mapData:MapData):
	clear()
	for pos in mapData.pos_to_cellData:
#		groundTileMapLayer.set_cell(tile_pos_player_is_on + adjustment_vector, DIRT_WET, Vector2i(0,0), 0)
		var source_id:int = -1
		if mapData.pos_to_cellData[pos].groundData.is_wet:
			source_id = Map.DIRT_WET
		else:
			source_id = Map.DIRT_DRY
		set_cell(pos, source_id, Vector2i(0,0), 0)

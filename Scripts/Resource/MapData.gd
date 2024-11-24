class_name MapData
extends Resource


@export var pos_to_cellData:Dictionary = {}


func water_tile(tile:Vector2i):
	if pos_to_cellData.has(tile):
		pos_to_cellData[tile].groundData.is_wet = true
	else:
		var newCellData = CellData.new()
		newCellData.groundData = SoilData.new()
		newCellData.groundData.is_wet = true
		pos_to_cellData[tile] = newCellData
		pass

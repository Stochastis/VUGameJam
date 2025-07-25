extends Node

@export var tileMapLayer: TileMapLayer
@export var outerWallScene: PackedScene
@export var worldNavigation: NavigationRegion2D

const FLOORTILESOURCEID = 2

var outerWalls: Array[OuterWall]

func _ready() -> void:
	get_outer_wall_edges()
	spawn_walls()
	makeRandomWallBreakable()

func makeRandomWallBreakable() -> void:
	var randomOuterWall: OuterWall = outerWalls.pick_random()
	randomOuterWall.makeBreakable()

func _on_wall_breaker_timer_timeout() -> void:
	makeRandomWallBreakable()

func spawn_walls():
	for cell_pos: Vector2i in get_outer_wall_edges():
		var outerWallInst: OuterWall = outerWallScene.instantiate()
		
		#Rotate doors
		match get_rotation_vector(cell_pos):
			#East
			Vector2(1.0, 0.0):
				outerWallInst.rotation_degrees = 90
			#South
			Vector2(0.0, 1.0):
				outerWallInst.rotation_degrees = 180
			#West
			Vector2(-1.0, 0.0):
				outerWallInst.rotation_degrees = 270
			#North
			Vector2(0.0, -1.0):
				pass
			_:
				tileMapLayer.set_cell(cell_pos)
				printerr("Failed to determine outer wall direction for " + str(cell_pos))
		
		# Convert cell coordinates to world position
		var local_pos = tileMapLayer.map_to_local(cell_pos)
		outerWallInst.global_position = tileMapLayer.to_global(local_pos)
		
		worldNavigation.add_child(outerWallInst)
		outerWalls.append(outerWallInst)
		tileMapLayer.set_cell(cell_pos, -1)

func get_outer_wall_edges() -> Array[Vector2i]:
	var outerWallEdgeCellPositions: Array[Vector2i]
	for cell_pos: Vector2i in tileMapLayer.get_used_cells():
		var tileData: TileData = tileMapLayer.get_cell_tile_data(cell_pos)
		if tileData and tileData.has_custom_data("is_outer_wall_edge"):
			if tileData.get_custom_data("is_outer_wall_edge"):
				outerWallEdgeCellPositions.append(cell_pos)
	return outerWallEdgeCellPositions

func get_rotation_vector(coords:Vector2i) -> Vector2:
	var vec = Vector2.UP
	
	var alt = tileMapLayer.get_cell_alternative_tile(coords)
	
	if alt & TileSetAtlasSource.TRANSFORM_TRANSPOSE:
		vec = Vector2(vec.y, vec.x)
	if alt & TileSetAtlasSource.TRANSFORM_FLIP_H:
		vec.x *= -1
	if alt & TileSetAtlasSource.TRANSFORM_FLIP_V:
		vec.y *= -1

	return vec

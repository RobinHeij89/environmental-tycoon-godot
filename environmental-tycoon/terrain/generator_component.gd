class_name GeneratorComponent
extends Node2D

enum TerrainTileType { WATER, GRASS, ROAD }

class TerrainTile:
	var x: int
	var y: int
	var type: TerrainTileType
	var isValid: bool
	var elevation: int
	var treeHM: int

class TerrainInputData:
	var chunkAmount: int
	var chunkSize: int
	var uuid: String
	var displayName: String
	var terrainTiles: Array[TerrainTile]
	var roadTiles: Array[TerrainTile]

var terrain_input_data: TerrainInputData

func _ready() -> void:
	terrain_input_data = TerrainInputData.new()

func generate_terrain():
	var data = import_json()
	set_terrain_input_data(data)

func import_json():
	var file = FileAccess.open("res://levels/level.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data

func set_terrain_input_data(file_data: Variant):
	terrain_input_data.chunkAmount = file_data.chunkAmount
	terrain_input_data.chunkSize = file_data.chunkSize
	terrain_input_data.uuid = file_data.uuid
	terrain_input_data.displayName = file_data.displayName
	for terrainTile in file_data.terrainTiles:
		var terrainTileObject = TerrainTile.new()
		terrainTileObject.x = terrainTile.x
		terrainTileObject.y = terrainTile.y
		terrainTileObject.type = terrainTile.type
		terrainTileObject.isValid = terrainTile.isValid if terrainTile.has("isValid") else false
		terrainTileObject.elevation = terrainTile.elevation
		terrainTileObject.treeHM = terrainTile.treeHM
		terrain_input_data.terrainTiles.append(terrainTileObject)
	# check roadTiles and assign a roadTile texture

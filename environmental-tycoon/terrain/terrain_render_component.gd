class_name TerrainRenderComponent
extends Node2D

const TILE_SIZE: Vector2 = Vector2(130,130)
var gggg = preload("res://terrain/assets/gggg.png")

var gggw = preload("res://terrain/assets/gggw.png")
var ggwg = preload("res://terrain/assets/ggwg.png")
var gwgg = preload("res://terrain/assets/gwgg.png")
var wggg = preload("res://terrain/assets/wggg.png")

var wgwg = preload("res://terrain/assets/wgwg.png")
var gwgw = preload("res://terrain/assets/gwgw.png")

var ggww = preload("res://terrain/assets/ggww.png")
var gwwg = preload("res://terrain/assets/gwwg.png")
var wwgg = preload("res://terrain/assets/wwgg.png")
var wggw = preload("res://terrain/assets/wggw.png")

var wgww = preload("res://terrain/assets/wgww.png")
var wwgw = preload("res://terrain/assets/wwgw.png")

var gwww = preload("res://terrain/assets/gwww.png")
var wwwg = preload("res://terrain/assets/wwwg.png")

var wwww = preload("res://terrain/assets/wwww.png")

var yyyy = preload("res://terrain/assets/roads/yyyy.png")

var yyyn = preload("res://terrain/assets/roads/yyyn.png")
var yyny = preload("res://terrain/assets/roads/yyny.png")
var ynyy = preload("res://terrain/assets/roads/ynyy.png")
var nyyy = preload("res://terrain/assets/roads/nyyy.png")

var ynyn = preload("res://terrain/assets/roads/ynyn.png")
var nyny = preload("res://terrain/assets/roads/nyny.png")

var yynn = preload("res://terrain/assets/roads/yynn.png")
var nyyn = preload("res://terrain/assets/roads/nyyn.png")
var nnyy = preload("res://terrain/assets/roads/nnyy.png")
var ynny = preload("res://terrain/assets/roads/ynny.png")

var ynnn = preload("res://terrain/assets/roads/ynnn.png")
var nynn = preload("res://terrain/assets/roads/nynn.png")
var nnyn = preload("res://terrain/assets/roads/nnyn.png")
var nnny = preload("res://terrain/assets/roads/nnny.png")

var terrain_tiles: Array[LayeredSprite]

func render_terrain(terrain_data: GeneratorComponent.TerrainInputData):
	var grid_size = sqrt(terrain_data.terrainTiles.size()) - 1
	for tile_x in grid_size:
		for tile_y in grid_size:
			var tile = return_tile(tile_x, tile_y, terrain_data.terrainTiles)
			var sprite = LayeredSprite.new()
			sprite.position = Vector2(tile.x*TILE_SIZE.x, -tile.y*TILE_SIZE.y)
			var terrain_texture = return_texture(tile, terrain_data.terrainTiles)
			sprite.add_to_textures(terrain_texture)
			var road_texture = return_road_texture(tile, terrain_data.terrainTiles)
			if road_texture:
				sprite.add_to_textures(road_texture)
			add_child(sprite)
			terrain_tiles.append(sprite)

func return_tile(x: int, y: int, arr: Array[GeneratorComponent.TerrainTile]):
	var results = arr.filter(func(element): return element.x == x and element.y == y)
	if results.size() == 0:
		return null
	else: 
		return results[0]

func coalesce(a, b):
	return a if a else b

func coalesce_type(a,b):
	return a.type if coalesce(a,b) else b

func coalesce_road(a,b):
	return a.type == GeneratorComponent.TerrainTileType.GRASS if coalesce(a,b) else b

func return_texture(tile: GeneratorComponent.TerrainTile, terrain_data: Array[GeneratorComponent.TerrainTile]):
	var north = coalesce_type(return_tile(tile.x, tile.y+1, terrain_data), GeneratorComponent.TerrainTileType.WATER)
	var north_east = coalesce_type(return_tile(tile.x+1, tile.y+1, terrain_data), GeneratorComponent.TerrainTileType.WATER)
	var east = coalesce_type(return_tile(tile.x+1, tile.y, terrain_data), GeneratorComponent.TerrainTileType.WATER)
	var same = coalesce_type(return_tile(tile.x, tile.y, terrain_data), GeneratorComponent.TerrainTileType.WATER)
	
	var texture
	match [north, north_east, east, same]:
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS]: texture = gggg
		
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER]: texture = gggw
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS]: texture = ggwg
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS]: texture = gwgg
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS]: texture = wggg
		
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS]: texture = wgwg
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER]: texture = gwgw
		
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER]: texture = ggww
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS]: texture = gwwg
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS]: texture = wwgg
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER]: texture = wggw
		
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER]: texture = wgww
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER]: texture = wwgw
		
		[GeneratorComponent.TerrainTileType.GRASS,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER]: texture = gwww
		[GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.WATER,GeneratorComponent.TerrainTileType.GRASS]: texture = wwwg
		_: texture = wwww
	
	return texture

func return_road_texture(tile: GeneratorComponent.TerrainTile, terrain_data: Array[GeneratorComponent.TerrainTile]):
	var north = coalesce_road(return_tile(tile.x, tile.y+1, terrain_data), false)
	var north_east = coalesce_road(return_tile(tile.x+1, tile.y+1, terrain_data), false)
	var east = coalesce_road(return_tile(tile.x+1, tile.y, terrain_data), false)
	var same = coalesce_road(return_tile(tile.x, tile.y, terrain_data), false)
	
	var texture
	match [north, north_east, east, same]:
		[true,true,true,true]: texture = yyyy
		[true,true,true,false]: texture = yyyn
		[true,true,false,true]: texture = yyny
		[true,false,true,true]: texture = ynyy
		[false,true,true,true]: texture = nyyy
		[true,false,true,false]: texture = ynyn
		[false,true,false, true]: texture = nyny
		[true,false,false, true]: texture = ynny
		[true, true,false,false]: texture = yynn
		[false, true, true,false]: texture = nyyn
		[false,false,true, true]: texture = nnyy
		_: texture = null
	
	return texture

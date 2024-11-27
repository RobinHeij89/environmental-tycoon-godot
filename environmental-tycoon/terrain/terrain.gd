class_name Terrain
extends Node2D

@export var generator_component: GeneratorComponent
@export var render_component: TerrainRenderComponent


func _ready() -> void:
	generator_component.generate_terrain()
	render_component.render_terrain(generator_component.terrain_input_data)

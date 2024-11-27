class_name LayeredSprite
extends Node2D

@export var textures: Array[Texture2D]

func _ready() -> void:
	render_sprites()

func add_to_textures(texture: Texture2D):
	textures.append(texture)

func render_sprites():
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
	
	for texture in textures:
		var sprite_instance = Sprite2D.new()
		sprite_instance.texture = texture
		add_child(sprite_instance)

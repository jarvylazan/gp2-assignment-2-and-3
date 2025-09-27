extends Node3D

@export var scene_to_instance: PackedScene   # The scene to spawn (tree, rock, etc.)
@export var instance_count: int = 50         # How many instances to create
@export var box_size: Vector3 = Vector3(50, 0, 50)  # Size of scatter area (X,Z matter most)

@export var random_rotation: bool = true
@export var random_scale: Vector2 = Vector2(1.0, 1.0)

func _ready():
	if not scene_to_instance:
		push_error("Please assign scene_to_instance.")
		return

	for i in range(instance_count):
		var inst = scene_to_instance.instantiate()
		add_child(inst)

		# Pick a random point inside the box, relative to this node
		var pos = Vector3(
			randf_range(-box_size.x / 2, box_size.x / 2),
			randf_range(-box_size.y / 2, box_size.y / 2),
			randf_range(-box_size.z / 2, box_size.z / 2)
		)
		inst.global_transform.origin = global_transform.origin + pos

		# Random Y rotation
		if random_rotation:
			inst.rotate_y(randf() * TAU)

		# Random uniform scale
		if random_scale.x != 1.0 or random_scale.y != 1.0:
			var scale = lerp(random_scale.x, random_scale.y, randf())
			inst.scale = Vector3.ONE * scale

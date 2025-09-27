extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_page_up"):
		increase_AA()
	elif Input.is_action_just_pressed("ui_page_down"):
		decrease_AA()
		
	if Input.is_action_just_pressed("increase_resolution"):
		increase_rendering_scale()
	elif Input.is_action_just_pressed("lower_resolution"):
		decrease_rendering_scale()
		
	if Input.is_action_just_pressed("ui_text_delete"):
		change_resolution_scale_mode()
		
func increase_AA():
	var current_aa = get_viewport().msaa_3d
	if current_aa == Viewport.MSAA_DISABLED:
		get_viewport().msaa_3d = Viewport.MSAA_2X
	elif current_aa == Viewport.MSAA_2X:
		get_viewport().msaa_3d = Viewport.MSAA_4X
	elif current_aa == Viewport.MSAA_4X:
		get_viewport().msaa_3d = Viewport.MSAA_8X
		
func decrease_AA():
	var current_aa = get_viewport().msaa_3d
	if current_aa == Viewport.MSAA_8X:
		get_viewport().msaa_3d = Viewport.MSAA_4X
	elif current_aa == Viewport.MSAA_4X:
		get_viewport().msaa_3d = Viewport.MSAA_2X
	elif current_aa == Viewport.MSAA_2X:
		get_viewport().msaa_3d = Viewport.MSAA_DISABLED

var rendering_scale_mod = 0.2
func increase_rendering_scale():
	print("Increasing scale")
	get_viewport().scaling_3d_scale += rendering_scale_mod
	var current_scale = get_viewport().scaling_3d_scale
	print(current_scale)
	
func decrease_rendering_scale():
	print("Decreasing scale")
	get_viewport().scaling_3d_scale -= rendering_scale_mod
	var current_scale = get_viewport().scaling_3d_scale
	print(current_scale)
	
func change_resolution_scale_mode():
	var current_mode = get_viewport().scaling_3d_mode
	if current_mode == Viewport.Scaling3DMode.SCALING_3D_MODE_BILINEAR:
		get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR
		print("FSR")
	elif current_mode == Viewport.Scaling3DMode.SCALING_3D_MODE_FSR:
		get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR2
		print("FSR2")
	elif current_mode == Viewport.Scaling3DMode.SCALING_3D_MODE_FSR2:
		get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_BILINEAR
		print("Bilinear")

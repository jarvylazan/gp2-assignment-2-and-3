extends Control

@onready var FPS_label                = $CanvasLayer/MarginContainer/VBoxContainer/Label
@onready var Primitive_label          = $CanvasLayer/MarginContainer/VBoxContainer/Label2
@onready var DrawCalls_label          = $CanvasLayer/MarginContainer/VBoxContainer/Label3
@onready var Collisions_label         = $CanvasLayer/MarginContainer/VBoxContainer/Label4
@onready var NodeCount_label          = $CanvasLayer/MarginContainer/VBoxContainer/Label5
@onready var ObjectsInFrame_label     = $CanvasLayer/MarginContainer/VBoxContainer/Label6
@onready var ActiveObjects_label      = $CanvasLayer/MarginContainer/VBoxContainer/Label7
@onready var CPUFrameTime_label       = $CanvasLayer/MarginContainer/VBoxContainer/Label8
@onready var GPUFrameTime_label       = $CanvasLayer/MarginContainer/VBoxContainer/Label9

var _vp_rid: RID

func _ready():
	var labels = [
		FPS_label, Primitive_label, DrawCalls_label, Collisions_label,
		NodeCount_label, ObjectsInFrame_label, ActiveObjects_label,
		CPUFrameTime_label, GPUFrameTime_label
	]
	for lbl in labels:
		lbl.add_theme_font_size_override("font_size", 60)

	# Enable per-frame CPU/GPU render time measurement for this viewport.
	_vp_rid = get_viewport().get_viewport_rid()
	RenderingServer.viewport_set_measure_render_time(_vp_rid, true)

func _process(_delta):
	FPS_label.text = "FPS: " + str(Engine.get_frames_per_second())
	Primitive_label.text = "Primitive count: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME))
	DrawCalls_label.text = "Draw calls: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
	Collisions_label.text = "Collision pairs: " + str(Performance.get_monitor(Performance.PHYSICS_3D_COLLISION_PAIRS))
	NodeCount_label.text = "Node count: " + str(Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	ObjectsInFrame_label.text = "Objects in frame: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME))
	ActiveObjects_label.text = "Active Objects in frame: " + str(Performance.get_monitor(Performance.PHYSICS_3D_ACTIVE_OBJECTS))

	# CPU & GPU frame times (ms). These are per-viewport render times.
	var cpu_ms := RenderingServer.viewport_get_measured_render_time_cpu(_vp_rid)
	var gpu_ms := RenderingServer.viewport_get_measured_render_time_gpu(_vp_rid)

	# Values can be 0.0 on the first frame or if the platform/driver can’t report.
	CPUFrameTime_label.text = "CPU Frame Time: " + str(snapped(cpu_ms, 0.01)) + " ms"
	GPUFrameTime_label.text = "GPU Frame Time: " + str(snapped(gpu_ms, 0.01)) + " ms"

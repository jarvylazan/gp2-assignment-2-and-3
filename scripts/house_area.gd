extends Area3D

@onready var default_music: AudioStreamPlayer = %DefaultMusic
@onready var indoor_music: AudioStreamPlayer = %IndoorMusic

var fade_time := 1.5

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	default_music.volume_db = 0
	indoor_music.volume_db = -80

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("camera"):
		indoor_music.play()
		_fade(default_music, -80)
		_fade(indoor_music, 0)

func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("camera"):
		default_music.play()
		_fade(indoor_music, -80)
		_fade(default_music, 0)

func _fade(player: AudioStreamPlayer, target_db: float) -> void:
	var tween := create_tween()
	tween.tween_property(player, "volume_db", target_db, fade_time)
	if target_db <= -79:
		tween.tween_callback(Callable(player, "stop"))

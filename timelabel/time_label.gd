extends CanvasLayer

var time_passed: int = 0
var is_active: bool = true

@onready var timer_label: Label = $TimerLabel
@onready var stopwatch_timer: Timer = $TimerLabel/StopwatchTimer

func _ready():
	time_passed = Global.saved_time
	update_timer_display()
	
	if stopwatch_timer == null:
		return
	
	stopwatch_timer.wait_time = 1.0
	if not stopwatch_timer.timeout.is_connected(_on_timer_timeout):
		stopwatch_timer.timeout.connect(_on_timer_timeout)
	
	stopwatch_timer.start()

func _on_timer_timeout():
	if is_active:
		time_passed += 1
		Global.saved_time = time_passed
		update_timer_display()

func update_timer_display():
	if timer_label:
		var minutes = time_passed / 60
		var seconds = time_passed % 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]

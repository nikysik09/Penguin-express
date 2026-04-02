extends CanvasLayer

var time_passed: int = 0
var is_active: bool = true


@onready var timer_label: Label = $TimerLabel
@onready var stopwatch_timer: Timer = $TimerLabel/StopwatchTimer

func _ready():
	if stopwatch_timer == null:
		print("ПОМИЛКА: Вузол StopwatchTimer не знайдено! Перевірте назву в дереві сцени.")
		return
	
	update_timer_display()
	
	stopwatch_timer.wait_time = 1.0
	stopwatch_timer.autostart = true
	
	if not stopwatch_timer.timeout.is_connected(_on_timer_timeout):
		stopwatch_timer.timeout.connect(_on_timer_timeout)
	
	stopwatch_timer.start()

func _on_timer_timeout():
	if is_active:
		time_passed += 1
		update_timer_display()

func update_timer_display():
	if timer_label:
		var minutes = time_passed / 60
		var seconds = time_passed % 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]

func stop_timer():
	is_active = false
	stopwatch_timer.stop()

func resume_timer():
	is_active = true
	stopwatch_timer.start()

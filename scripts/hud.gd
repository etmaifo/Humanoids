
extends CanvasLayer


var time
var timer
var timescale = 7
var health
var fragments


func _ready():
	health = get_node("health_label")
	fragments = get_node("fragment_score")
	time = get_node("time")
	timer = get_node("timer")
	
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(60 * timescale)
	timer.start()
	
	time.set_text(str(int(timer.get_time_left() / timescale)))
	
	set_process(true)
	

func _process(delta):	
	var seconds = str(int(timer.get_time_left() / timescale))
	if int(timer.get_time_left()) <= 0:
		time.set_text("Game Over!")
	else:
		time.set_text(seconds)
	
	
func _on_timeout():	
	timer.stop()



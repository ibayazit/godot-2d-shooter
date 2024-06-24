extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func hit():
	Globals.health -= 10
	
func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	Globals.player_pos = global_position
	
	# rotate
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	# laser shooting input
	if Input.is_action_pressed("primary action") && can_laser && Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		
		# randomly selected a market 2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers.pick_random()
		
		# reload
		can_laser = false
		$LaserReloadTimer.start()
		
		# emit the position we selected
		laser.emit(selected_laser.global_position, player_direction)
		
	# grenade input
	if Input.is_action_pressed("secondary action") && can_grenade && Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		# reload
		can_grenade = false
		$GrenadeReloadTimer.start()
		
		# selected a market 2D for the grenade start
		var pos = $LaserStartPositions.get_children()[0].global_position
		
		# emit the position we selected
		grenade.emit(pos, player_direction)


func _on_timer_timeout():
	can_laser = true


func _on_grenade_reload_timer_timeout():
	can_grenade = true

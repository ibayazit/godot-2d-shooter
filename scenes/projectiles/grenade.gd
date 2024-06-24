extends RigidBody2D

const SPEED = 750
var explosion_active: bool = false
var explosion_ratius: int = 400

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	
func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_ratius
			if "hit" in target && in_range:
				target.hit()

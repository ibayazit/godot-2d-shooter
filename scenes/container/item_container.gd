extends StaticBody2D
class_name ItemContainer

signal open(position, direciton)

@onready var currenct_direction: Vector2 = Vector2.DOWN.rotated(rotation)

var opened: bool = false

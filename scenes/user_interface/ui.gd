extends CanvasLayer

# Colors
var green: Color = Color("00FF00")
var yellow: Color = Color("FFFF00")
var red: Color = Color("FF0000")

@onready var laserLabel: Label = $LaserCounter/VBoxContainer/Label
@onready var laserIcon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenadeLabel: Label = $GrenadeCounter/VBoxContainer/Label
@onready var grenadeIcon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var healthBar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect("stat_change", update_stat_text)
	update_stat_text()

func update_laser_text():
	laserLabel.text = str(Globals.laser_amount)
	update_color(laserLabel, laserIcon, Globals.laser_amount)
	
func update_grenade_text():
	grenadeLabel.text = str(Globals.grenade_amount)
	update_color(grenadeLabel, grenadeIcon, Globals.grenade_amount)
	
func update_health_text():
	healthBar.value = Globals.health
	
func update_stat_text():
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
func update_color(label: Label, icon: TextureRect, number: int):
	var color = green
	if number > 10:
		color = green
	elif  number > 0:
		color = yellow
	else:
		color = red
		
	label.modulate = color
	icon.modulate = color

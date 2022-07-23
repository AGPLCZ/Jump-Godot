extends Area2D

var speed = 1200

func _ready():
	if speed < 0:
		$Sprite.flip_h = true
		$CollisionShape2D.position.x = - 28

func _physics_process(delta):
	position.x += speed*delta
	
	
	



func _on_Timer_timeout():
	queue_free()

extends KinematicBody2D

var motion = Vector2(0,0)

export var SPEED = 500 #ค่าความเร็วเริ่มต้น
export var JUMP = 900 #ค่าความเร็วเริ่มต้น
export var GRAVITY = 60 #ค่าแรงดึงดูด
var jump_count = 0 #ค่าจำนวนครั่งการกระโดดเริ่มต้น

func is_dead():
	if motion.y > 4000:
		return true
	return false

func _physics_process(delta): #ตัวแปรพิเศษ
	apply_gravity()
	jump()
	walk()
	move_and_slide(motion, Vector2(0,-1))
	update_animation()
	
func update_animation(): #เพิ่ม Sprite Animated
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif motion.x < 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
	
func apply_gravity():
	if is_on_floor():
		motion.y = 0
		print("I'm floor")
		jump_count = 0
	else:
		motion.y = motion.y + GRAVITY

func walk():
	if Input.is_action_pressed("left_A") and not Input.is_action_pressed("right_A"):
		motion.x = -SPEED
		print("I'm walk left")
	elif Input.is_action_pressed("right_A") and not Input.is_action_pressed("left_A"):
		motion.x = SPEED
		print("I'm walk right")
	else:
		motion.x = 0
		
func jump(): #กระโดด
	if jump_count < 2: #สร้างการจำกัดจำนวนครั้ง
		if Input.is_action_just_pressed("jump_A"):
			$Jump_SFX.play()
			jump_count = jump_count + 1
			motion.y = -JUMP
			print("I'm jumped")
	if is_on_floor():
		jump_count = 0
	
func _on_Area2D_body_entered(body):
		if body.name == "Player_A":
			get_tree().change_scene("res://Scenes/GOAL_Scn.tscn")
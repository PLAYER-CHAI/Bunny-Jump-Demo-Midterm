extends KinematicBody2D

var motion = Vector2(0,0)

export var SPEED = 500 #ค่าความเร็วเริ่มต้น
export var JUMP = 900 #ค่าความเร็วเริ่มต้น
export var GRAVITY = 60 #ค่าแรงดึงดูด
var jump_count = 0 #ค่าจำนวนครั่งการกระโดดเริ่มต้น

func _physics_process(delta): #ตัวแปรพิเศษ
	
	apply_gravity()
	jump()
	walk()
	
	move_and_slide(motion, Vector2(0,-1))
	
func apply_gravity():
	motion.y = motion.y + GRAVITY
	if is_on_floor():
		motion.y = 0
		print("I'm floor")

func jump(): #กระโดด
	if jump_count < 1: #สร้างการจำกัดจำนวนครั้ง
		if Input.is_action_just_pressed("jump_B"):
			jump_count = jump_count + 1
			motion.y = -JUMP
			print("I'm jumped")
	if is_on_floor(): 
		jump_count = 0 #ลงพื้นแล้วให้ค่าเป็น 0

func walk():
	if Input.is_action_pressed("left_B") and not Input.is_action_pressed("right_B"):
		motion.x = -SPEED
		print("I'm walk left")
	elif Input.is_action_pressed("right_B") and not Input.is_action_pressed("left_B"):
		motion.x = SPEED
		print("I'm walk right")
	else:
		motion.x = 0
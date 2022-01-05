extends Node
var score_player = "user://player.save"
var score_opponent = "user://opponent.save"

var PlayerSore = 0
var OpponentScore = 0

func save_score(score, score_file):
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_var(score)
	f.close()
	
func _on_Left_body_entered(body):
	score_achieved()
	PlayerSore += 1
	
func _on_Right_body_entered(body):
	score_achieved()
	OpponentScore += 1

func _process(delta):
	if len(str(int($Timer.time_left))) == 2:
		$Time.text = "0: "+ str(int($Timer.time_left))
	else:
		$Time.text = "0: 0"+ str(int($Timer.time_left))
	$PlayerScore.text = str(PlayerSore)
	save_score(OpponentScore, score_opponent)
	$OpponentScore.text = str(OpponentScore)
	save_score(PlayerSore, score_player)
	$CountDownLabel.text = str(int($CountdownTimer.time_left) + 1)

func _on_CountdownTimer_timeout():
	$Timer.set_paused(false)
	get_tree().call_group('BallGroup', 'restart_ball')
	$CountDownLabel.visible = false

func _ready():
	$Ball.position = Vector2(640,360)
	get_tree().call_group('BallGroup', 'stop_ball')
	$CountDownLabel.visible = false
	var starttimer = Timer.new()
	starttimer.set_one_shot(true)
	starttimer.set_wait_time(2)
	starttimer.connect("timeout", self, "start_it")
	add_child(starttimer)
	starttimer.start()

func start_it():
	$Timer.set_one_shot(true)
	$Timer.set_wait_time(60)
	$Timer.connect("timeout", self, "on_timeout")
	$Timer.start()
	get_tree().call_group('BallGroup', 'restart_ball')
	$CountDownLabel.visible = false
		
func on_timeout():
	$CountdownTimer.stop()
	get_tree().change_scene("res://GameOver/GameOver.tscn")
	
func score_achieved():
	if int($Timer.time_left) == 0:
		on_timeout()
	$Timer.set_paused(true)
	$Ball.position = Vector2(640,360)
	get_tree().call_group('BallGroup', 'stop_ball')
	$CountdownTimer.start()
	$CountDownLabel.visible = true
	$ScoreSound.play()
	$Player.position.x = 1135
	$Opponent.position.x = 130


func _on_Reset_pressed():
	score_achieved()

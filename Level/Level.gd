extends Node

var PlayerSore = 0
var OpponentScore = 0

func _on_Left_body_entered(body):
	score_achieved()
	OpponentScore += 1
	
func _on_Right_body_entered(body):
	score_achieved()
	PlayerSore += 1

func _process(delta):
	$PlayerScore.text = str(PlayerSore)
	$OpponentScore.text = str(OpponentScore)
	$CountDownLabel.text = str(int($CountdownTimer.time_left) + 1)

func _on_CountdownTimer_timeout():
	get_tree().call_group('BallGroup', 'restart_ball')
	$CountDownLabel.visible = false
	
func score_achieved():
	$Ball.position = Vector2(640,360)
	get_tree().call_group('BallGroup', 'stop_ball')
	$CountdownTimer.start()
	$CountDownLabel.visible = true
	$ScoreSound.play()
	$Player.position.x = 100
	$Opponent.position.x = 1175

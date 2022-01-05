extends Node
var score_player = "user://player.save"
var score_opponent = "user://opponent.save"
var highscore = "user://highscore.save"

func load_score(score_file):
	var score
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		score = f.get_var()
		f.close()
	else:
		score = 0
	return score
	
func save_score(score, score_file):
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_var(score)
	f.close()
	
func _process(delta):
	var Player_score = load_score(score_player)
	var Opponent_score = load_score(score_opponent)
	var High_score = load_score(highscore)
	
	if int(Player_score) > int(Opponent_score):
		$Comment.text = "You Won!"
	elif int(Player_score) == int(Opponent_score):
		$Comment.text = "That's a Tie"
	else:
		$Comment.text == 'You Loose!'
	$YourScore.text = "Your Score: "+str(Player_score)
	if High_score == null:
		save_score(Player_score, highscore)
	if int(Player_score) > int(High_score):
		save_score(Player_score, highscore)
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://Level/Level.tscn")

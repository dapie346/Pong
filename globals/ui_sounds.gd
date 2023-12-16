extends Node

var music_playing: bool = false

func connect_hover_sound(button):
	button.connect("mouse_entered", Callable(self, "_on_button_mouse_entered"))
	
func connect_switch_sound(button):
	button.connect("pressed", Callable(self, "_on_switch_mouse_pressed"))

func connect_click_sound(button):
	button.connect("pressed", Callable(self, "_on_button_mouse_pressed"))
	
func _on_button_mouse_entered():
	$Hover.play()

func _on_button_mouse_pressed():
	play_click()

func _on_switch_mouse_pressed():
	$Switch.play()

func play_click():
	$Click.play()

func play_music():
	if not music_playing:
		music_playing = true
		$Music.play()

func stop_music():
	$Music.stop()
	music_playing = false

func play_point_scored():
	$PointScored.play()

func play_win():
	$Win.play()

func play_counting():
	$Counting.play()

func play_start():
	$Start.play()

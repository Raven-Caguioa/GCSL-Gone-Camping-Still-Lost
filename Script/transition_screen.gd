extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var color_rect = $ColorRect

func transition_in():
	color_rect.visible = true  # Make sure it's visible
	anim_player.play("swipe_in")
	await anim_player.animation_finished  # Wait until animation completes

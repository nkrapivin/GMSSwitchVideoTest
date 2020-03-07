/// @description Set volume

for (var i = 0; i < 10; i++)
{
	if (gamepad_is_connected(i))
	{
		gamepad_set_axis_deadzone(i, 0.5);
		vol += gamepad_axis_value(i, gp_axislh) * 0.01;
		if (gamepad_button_check_pressed(i, gp_face1) || gamepad_button_check_pressed(i, gp_face2))
			vol = 1;
			
		vol = clamp(vol, 0, 1);
		video_set_volume(vol);
	}
}
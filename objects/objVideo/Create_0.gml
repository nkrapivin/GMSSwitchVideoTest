/// @description Load video

#region Switch init stuff
	switch_accounts_get_accounts();
	switch_accounts_select_account(true, false, false);

	switch_controller_set_supported_styles(
		switch_controller_handheld |
		switch_controller_pro_controller |
		switch_controller_joycon_dual |
		switch_controller_joycon_left |
		switch_controller_joycon_right);
	switch_controller_joycon_set_holdtype(switch_controller_joycon_holdtype_vertical);

	// Ensure that the handheld joycon style requires both joy-cons connected to be active.
	switch_controller_set_handheld_activation_mode(switch_controller_handheld_activation_dual);

	switch_controller_support_set_defaults();
	switch_controller_support_set_singleplayer_only(true);
	switch_controller_support_show(); //show the applet
#endregion

#region Video init stuff
	if (shaders_are_supported() && shader_is_compiled(shdVideo))
	{
		doit = true;
		vol = 1;
		video_width = 1280;
		video_height = 720;
		video_sampler = shader_get_sampler_index(shdVideo, "v_chroma");
	
	
		video_open("test.mp4");
		video_set_volume(vol);
	}
	else { instance_destroy(); doit = false; } // oh no.
#endregion

// formats:
// mp4 m4a m4v - Video(H.264) Audio(AAC)
// webm - Video(VP8,VP9) Audio(Vorbis)
// mkv - Video(VP8,VP9,H.264) Audio(Vorbis)
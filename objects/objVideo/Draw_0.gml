/// @description Draw video frame

if (!doit) exit;

var arr_rv = video_draw();
if (arr_rv[0] < 0)
{
	video_close();
	show_debug_message("беды с башкой прошли...");
	instance_destroy();
}
else
{
	var _surface = arr_rv[1];
	var _chroma_surface = arr_rv[2];
	if (surface_exists(_surface) && surface_exists(_chroma_surface))
	{
		shader_set(shdVideo);
		var _tex_id = surface_get_texture(_surface);
		var _chroma_tex_id = surface_get_texture(_chroma_surface);
		texture_set_stage(video_sampler, _chroma_tex_id);
		gpu_set_texfilter(false); //disable interpolation ???
		draw_primitive_begin_texture(pr_trianglestrip, _tex_id);
		draw_vertex_texture(0, 0, 0, 0);
		draw_vertex_texture(video_width, 0, 1, 0);
		draw_vertex_texture(0, video_height, 0, 1);
		draw_vertex_texture(video_width, video_height, 1, 1);
		draw_primitive_end();
		shader_reset();
	}
	else show_debug_message("с головой пиздец...");
}

draw_text(32, 32, "video player sample\nuse left analog stick to change volume\nA or B to reset volume to 1\nvolume " + string_format(vol, 1, 2));
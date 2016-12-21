luapath=string.match(GetInfo(35),"^.*\\")

include=function(str)
	dofile(luapath..str)
end
loadmod=function(str)
	include("class\\"..str)
end

me={}
me.charid=GetAlphaOption("player")
me.pwd=GetAlphaOption("password")
include("config_"..me.charid..".lua")
----------------------------------------------------------------------------------
-- 基础配置部份 结束
-- 下面开始的代码看不懂就不要动了。
----------------------------------------------------------------------------------
version="2.0.0"

SetAlphaOption("auto_log_file_name","%L%P-%H.log")
SetAlphaOption("auto_say_override_prefix","-")
SetAlphaOption("auto_say_string","say ")
SetAlphaOption("beep_sound","")
SetAlphaOption("chat_file_save_directory","")
SetAlphaOption("chat_name","Name-not-set")
SetAlphaOption("chat_message_prefix","")
SetAlphaOption("command_stack_character",";")
SetAlphaOption("connect_text","")
SetAlphaOption("editor_window_name","")
SetAlphaOption("filter_aliases","")
SetAlphaOption("filter_timers","")
SetAlphaOption("filter_triggers","")
SetAlphaOption("filter_variables","")
SetAlphaOption("input_font_name","Fixedsys")
SetAlphaOption("log_file_postamble","")
SetAlphaOption("log_file_preamble","")
SetAlphaOption("log_line_postamble_input","")
SetAlphaOption("log_line_postamble_notes","")
SetAlphaOption("log_line_postamble_output","")
SetAlphaOption("log_line_preamble_input","[%H:%M:%S]")
SetAlphaOption("log_line_preamble_notes","[%H:%M:%S]")
SetAlphaOption("log_line_preamble_output","[%H:%M:%S]")
SetAlphaOption("mapping_failure","Alas, you cannot go that way.")
SetAlphaOption("new_activity_sound","(No sound)")
SetAlphaOption("notes","")
SetAlphaOption("on_mxp_close_tag","")
SetAlphaOption("on_mxp_error","")
SetAlphaOption("on_mxp_open_tag","")
SetAlphaOption("on_mxp_set_variable","")
SetAlphaOption("on_mxp_start","")
SetAlphaOption("on_mxp_stop","")
SetAlphaOption("on_world_close","")
SetAlphaOption("on_world_save","")
SetAlphaOption("on_world_connect","alias.atconnect")
SetAlphaOption("on_world_disconnect","alias.atdisconnect")
SetAlphaOption("on_world_get_focus","")
SetAlphaOption("on_world_lose_focus","")
SetAlphaOption("on_world_open","")
SetAlphaOption("output_font_name","新宋体")
SetAlphaOption("paste_line_postamble","")
SetAlphaOption("paste_line_preamble","")
SetAlphaOption("paste_postamble","")
SetAlphaOption("paste_preamble","")
SetAlphaOption("player",me.charid)
SetAlphaOption("recall_line_preamble","")
SetAlphaOption("script_editor","notepad")
SetAlphaOption("script_editor_argument","%file")
SetAlphaOption("script_language","Lua")
SetAlphaOption("script_prefix","/")
SetAlphaOption("send_to_world_file_postamble","")
SetAlphaOption("send_to_world_file_preamble","")
SetAlphaOption("send_to_world_line_postamble","")
SetAlphaOption("send_to_world_line_preamble","")
SetAlphaOption("spam_message","look")
SetAlphaOption("speed_walk_filler","")
SetAlphaOption("speed_walk_prefix","#")
SetAlphaOption("tab_completion_defaults","")
SetAlphaOption("timestamp_input","")
SetAlphaOption("timestamp_notes","")
SetAlphaOption("timestamp_output","")

SetOption("accept_chat_connections",0)
SetOption("alternative_inverse",0)
SetOption("alt_arrow_recalls_partial",0)
SetOption("always_record_command_history",0)
SetOption("arrows_change_history",1)
SetOption("arrow_keys_wrap",0)
SetOption("arrow_recalls_partial",0)
SetOption("autosay_exclude_macros",0)
SetOption("autosay_exclude_non_alpha",0)
SetOption("auto_allow_files",0)
SetOption("auto_allow_snooping",0)
SetOption("auto_copy_to_clipboard_in_html",0)
SetOption("auto_pause",1)
SetOption("auto_repeat",1)
SetOption("auto_resize_command_window",0)
SetOption("auto_resize_minimum_lines",1)
SetOption("auto_resize_maximum_lines",20)
SetOption("auto_wrap_window_width",0)
SetOption("carriage_return_clears_line",0)
SetOption("chat_foreground_colour",255)
SetOption("chat_background_colour",0)
SetOption("chat_max_lines_per_message",0)
SetOption("chat_max_bytes_per_message",0)
SetOption("chat_port",4050)
SetOption("confirm_before_replacing_typing",1)
SetOption("confirm_on_paste",1)
SetOption("confirm_on_send",1)
SetOption("connect_method",0)
SetOption("copy_selection_to_clipboard",0)
SetOption("convert_ga_to_newline",0)
SetOption("ctrl_n_goes_to_next_command",0)
SetOption("ctrl_p_goes_to_previous_command",0)
SetOption("ctrl_z_goes_to_end_of_buffer",0)
SetOption("custom_16_is_default_colour",0)
SetOption("default_trigger_send_to",0)
SetOption("default_trigger_sequence",100)
SetOption("default_trigger_regexp",0)
SetOption("default_trigger_expand_variables",0)
SetOption("default_trigger_keep_evaluating",0)
SetOption("default_trigger_ignore_case",0)
SetOption("default_alias_send_to",0)
SetOption("default_alias_sequence",100)
SetOption("default_alias_regexp",0)
SetOption("default_alias_expand_variables",0)
SetOption("default_alias_keep_evaluating",0)
SetOption("default_alias_ignore_case",0)
SetOption("default_timer_send_to",0)
SetOption("detect_pueblo",1)
SetOption("do_not_add_macros_to_command_history",0)
SetOption("do_not_show_outstanding_lines",0)
SetOption("do_not_translate_iac_to_iac_iac",0)
SetOption("disable_compression",0)
SetOption("display_my_input",0)
SetOption("double_click_inserts",0)
SetOption("double_click_sends",0)
SetOption("echo_colour",0)
SetOption("echo_hyperlink_in_output_window",1)
SetOption("edit_script_with_notepad",1)
SetOption("enable_aliases",1)
SetOption("enable_auto_say",0)
SetOption("enable_beeps",1)
SetOption("enable_command_stack",1)
SetOption("enable_scripts",1)
SetOption("enable_spam_prevention",0)
SetOption("enable_speed_walk",0)
SetOption("enable_timers",1)
SetOption("enable_triggers",1)
SetOption("enable_trigger_sounds",1)
SetOption("escape_deletes_input",0)
SetOption("flash_taskbar_icon",0)
SetOption("history_lines",1000)
SetOption("hyperlink_adds_to_command_history",1)
SetOption("hyperlink_colour",16744448)
SetOption("ignore_chat_colours",0)
SetOption("ignore_mxp_colour_changes",0)
SetOption("indent_paras",1)
SetOption("input_background_colour",16777215)
SetOption("input_font_height",9)
SetOption("input_font_italic",0)
SetOption("input_font_weight",400)
SetOption("input_font_charset",0)
SetOption("input_text_colour",0)
SetOption("keep_commands_on_same_line",1)
SetOption("keypad_enable",1)
SetOption("line_information",1)
SetOption("line_spacing",0)
SetOption("log_html",0)
SetOption("log_input",1)
SetOption("log_in_colour",0)
SetOption("log_notes",1)
SetOption("log_output",1)
SetOption("log_raw",0)
SetOption("log_script_errors",1)
SetOption("lower_case_tab_completion",0)
SetOption("map_failure_regexp",0)
SetOption("max_output_lines",5000)
SetOption("mud_can_change_link_colour",1)
SetOption("mud_can_remove_underline",0)
SetOption("mud_can_change_options",1)
SetOption("mxp_debug_level",0)
SetOption("naws",0)
SetOption("note_text_colour",4)
SetOption("no_echo_off",0)
SetOption("omit_date_from_save_files",0)
SetOption("output_font_height",9)
SetOption("output_font_weight",400)
SetOption("output_font_charset",134)
SetOption("paste_commented_softcode",0)
SetOption("paste_delay",0)
SetOption("paste_delay_per_lines",1)
SetOption("paste_echo",0)
SetOption("play_sounds_in_background",0)
SetOption("pixel_offset",1)
SetOption("port",5555)
SetOption("proxy_port",1080)
SetOption("proxy_type",0)
SetOption("re_evaluate_auto_say",0)
SetOption("save_deleted_command",0)
SetOption("save_world_automatically",0)
SetOption("script_reload_option",0)
SetOption("script_errors_to_output_window",1)
SetOption("send_echo",0)
SetOption("send_file_commented_softcode",0)
SetOption("send_file_delay",0)
SetOption("send_file_delay_per_lines",1)
SetOption("send_keep_alives",0)
SetOption("send_mxp_afk_response",1)
SetOption("show_bold",0)
SetOption("show_connect_disconnect",1)
SetOption("show_italic",1)
SetOption("show_underline",1)
SetOption("spam_line_count",20)
SetOption("speed_walk_delay",50)
SetOption("spell_check_on_send",0)
SetOption("start_paused",0)
SetOption("tab_completion_lines",200)
SetOption("tab_completion_space",0)
SetOption("timestamp_input_text_colour",128)
SetOption("timestamp_notes_text_colour",16711680)
SetOption("timestamp_output_text_colour",16777215)
SetOption("timestamp_input_back_colour",0)
SetOption("timestamp_notes_back_colour",0)
SetOption("timestamp_output_back_colour",0)
SetOption("tool_tip_visible_time",5000)
SetOption("tool_tip_start_time",400)
SetOption("translate_backslash_sequences",0)
SetOption("translate_german",0)
SetOption("treeview_triggers",1)
SetOption("treeview_aliases",1)
SetOption("treeview_timers",1)
SetOption("underline_hyperlinks",1)
SetOption("unpause_on_send",1)
SetOption("use_custom_link_colour",1)
SetOption("use_default_aliases",0)
SetOption("use_default_colours",0)
SetOption("use_default_input_font",1)
SetOption("use_default_macros",0)
SetOption("use_default_output_font",0)
SetOption("use_default_timers",0)
SetOption("use_default_triggers",0)
SetOption("use_mxp",0)
SetOption("utf_8",0)
SetOption("validate_incoming_chat_calls",0)
SetOption("warn_if_scripting_inactive",1)
SetOption("wrap",1)
SetOption("wrap_input",0)
SetOption("wrap_column",120)
SetOption("write_world_name_to_log",0)

-- 读取保存的配置文件


Execute("/set_"..setting.."()")
gold.num=0
if setting_resetidle>0 then resetidle=1 else resetidle=0 end
if workflow.ftb>0 then				-- FTB模块开启时，强行关闭QZWD，CM,YB模块
	workflow.ftb=1
	workflow.qzwd=0
	workflow.cm=0
	workflow.yb=0
end
if workflow.qzwd>0 then
	workflow.qzwd=1
	workflow.ftb=0
	workflow.cm=0
	workflow.yb=0
end
if workflow.yb>0 then
	workflow.yb=1
	workflow.ftb=0
	workflow.qzwd=0
	workflow.cm=0
end
if workflow.cm>0 then
	workflow.cm=1
	workflow.ftb=0
	workflow.qzwd=0
	workflow.yb=0
end
if per.roomno==1061 then
	per.roomno=1061
	per.npcid="zei"
	per.way="nu;sd"
end
if per.roomno==609 then
	per.roomno=609
	per.npcid="robber"
	per.way="w;e"
end
if per.roomno==1392 then
	per.roomno=1392
	per.npcid="robber"
	per.way="nd;su"
end
if per.roomno==936 then
	per.roomno=936
	per.npcid="robber"
	per.way="n;s"
end
if per.roomno==1369 then
	per.roomno=1369
	per.npcid="robber"
	per.way="s;n"
end
if per.roomno==1328 then
	per.roomno=1328
	per.npcid="robber"
	per.way="n;s"
end

if wantxuelit==1 then havegoldxuelit=1;xuelit=1 end
if wantxuelit==2 then havegoldxuelit=0;xuelit=1 end
if wantxuelit==3 then havegoldxuelit=0;xuelit=0 end

-----------------------------------------------------------------------------------
weapon_now=""

if GetTriggerList() ~= nil then
	for k,v in pairs(GetTriggerList()) do
		DeleteTrigger(v)
	end
end
if GetAliasList() ~= nil then
	for k,v in pairs(GetAliasList()) do
		DeleteAlias(v)
	end
end
if GetTimerList() ~= nil then
	for k,v in pairs(GetTimerList()) do
		DeleteTimer(v)
	end
end

loadlua_list={
	"michen_system.lua",
	"michen_alias.lua",
	"always.lua",
	"check.lua",
	"common.lua",
	"gps_lib.lua",
	"gps.lua",
	"kill.lua",
	"skills.lua",
	"xinfa.lua",
	"fj.lua",
	"ftb.lua",
	"chongmai.lua",
	"qzwd.lua",
	"michen_mp_gb.lua",
	"michen_mp_dl.lua",
	"michen_mp_hs.lua",
	"michen_mp_qz.lua",
	"michen_mp_wd.lua",
	"michen_mp_sl.lua",
	"michen_mp_xs.lua",
	"michen_mp_em.lua",
	"michen_mp_gm.lua",
	"michen_mp_bt.lua",
	"michen_mp_xx.lua",
	"michen_mp_th.lua",
	"michen_mp_mj.lua",
	--"pk.lua",
	"michen_config.lua",
	--"charinfo.lua",
  }

for i=1,table.getn(loadlua_list) do
	loadmod(loadlua_list[i])
end

alias.initialize_variable()
notconnect=0
if IsConnected() then run("score;hp;jifa;cha") end
print("所有模块加载成功！")
ColourNote("red","blue","欢迎使用XKX RBT FOR MUSHCLIENT VER."..version)
ColourNote("red","blue","本RBT由Michen按照Kiss版本zmud7.21完整重写而成")
ColourNote("red","blue","目前实现了XX、BT、GM、GB、QZ、HS、SL、XS、EM、WD和DL MP+FJ+LW+XUE+CHONGMAI+XINFA+FTB功能")
ColourNote("red","blue","欢迎测试和提报BUG。")
if not IsLogOpen() then OpenLog("",false) end

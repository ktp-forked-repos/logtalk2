// =================================================================
// Logtalk - Object oriented extension to Prolog
// Release 2.20.1
//
// Copyright (c) 1998-2004 Paulo Moura.  All Rights Reserved.
// =================================================================

if (WScript.Arguments.Unnamed.Length > 0) {
	usage_help();
	WScript.Quit(0);
}

WScript.Echo('');
WScript.Echo('Creating a shortcut named "Logtalk - GNU Prolog" for running Logtalk');
WScript.Echo('with GNU Prolog...');
WScript.Echo('');

var WshShell = new ActiveXObject("WScript.Shell");

var prolog_path = WshShell.RegRead("HKCU\\Software\\GnuProlog\\RootPath") + "\\bin\\gplc.exe";

var FSObject = new ActiveXObject("Scripting.FileSystemObject");

if (!FSObject.FileExists(prolog_path)) {
	WScript.Echo("Error! Cannot find gplc.exe at the expected place!");
	WScript.Quit(1);
}

var WshProcessEnv = WshShell.Environment("PROCESS");
var WshSystemEnv = WshShell.Environment("SYSTEM");
var WshUserEnv = WshShell.Environment("USER");
var logtalk_home;

if (WshProcessEnv.Item("LOGTALKHOME"))
	logtalk_home = WshProcessEnv.Item("LOGTALKHOME");
else if (WshSystemEnv.Item("LOGTALKHOME"))
	logtalk_home = WshSystemEnv.Item("LOGTALKHOME");
else if (WshUserEnv.Item("LOGTALKHOME"))
	logtalk_home = WshUserEnv.Item("LOGTALKHOME")
else {
	WScript.Echo("Error! The system environment variable LOGTALKHOME must be defined first!");
	usage_help();
	WScript.Quit(1);
}

logtalk_home = logtalk_home.replace(/\\/g, "\\\\");

if (!FSObject.FolderExists(logtalk_home + "\\bin")) 
	FSObject.CreateFolder(logtalk_home + "\\bin");

FSObject.CopyFile(logtalk_home + "\\configs\\gnu.config", logtalk_home + "\\bin\\gnu.pl");

var f = FSObject.CreateTextFile(logtalk_home + "\\bin\\logtalkgp.pl", true);
f.WriteLine(":- built_in.");
f.Close();

WshShell.Run("cmd /c type " + logtalk_home + "\\compiler\\logtalk.pl" + " >> " + logtalk_home + "\\bin\\logtalkgp.pl", true);

WshShell.Run("cmd /c " + prolog_path + " -o " + logtalk_home + "\\bin\\gplgt.exe" + logtalk_home + "\\bin\\gnu.pl" + " " + logtalk_home + "\\bin\\logtalkgp.pl", true);

var ProgramsPath = WshShell.SpecialFolders("AllUsersPrograms");
var link = WshShell.CreateShortcut(ProgramsPath + "\\Logtalk - GNU Prolog.lnk");
link.Arguments = "";
link.Description = "Runs Logtalk with GNU Prolog";
link.IconLocation = "app.exe,1";
link.TargetPath = logtalk_home + "\\bin\\gplgt.exe";
link.WindowStyle = 1;
link.WorkingDirectory = logtalk_home;
link.Save();

WScript.Echo('Done. The "Logtalk - GNU Prolog" shortcut was been added to the');
WScript.Echo('Start Menu Programs. Make sure that the LOGTALKHOME environment');
WScript.Echo('variable is defined for all users wishing to use the shortcut.');
WScript.Echo('');

WScript.Quit(0);

function usage_help() {
	WScript.Echo('');
	WScript.Echo('This script creates a shortcut named "Logtalk - GNU Prolog" for running Logtalk');
	WScript.Echo('with GNU Prolog. The script must be run by a user with administrative rights.');
	WScript.Echo('The LOGTALKHOME environment variable must be defined before running this');
	WScript.Echo('script.');
	WScript.Echo('');
	WScript.Echo('Usage:');
	WScript.Echo('  ' + WScript.ScriptName + ' help');
	WScript.Echo('  ' + WScript.ScriptName);
	WScript.Echo('');
}

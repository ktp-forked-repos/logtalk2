// =================================================================
// Logtalk - Object oriented extension to Prolog
// Release 2.19.2
//
// Copyright (c) 1998-2004 Paulo Moura.  All Rights Reserved.
// =================================================================

var WshShell = new ActiveXObject("WScript.Shell");

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
	WScript.Echo("Error! The environment variable LOGTALKHOME must be defined first!");
	usage_help();
	WScript.Quit(1);
}

if (WScript.Arguments.Unnamed.Length > 0) {
	usage_help();
	WScript.Quit(0);
}

WScript.Echo("");
WScript.Echo("Making a shortcut named sicstuslgt for running Logtalk with SICStus Prolog...");

var fso = new ActiveXObject("Scripting.FileSystemObject");

if (!fso.FolderExists(logtalk_home + "\\bin")) 
	fso.CreateFolder(logtalk_home + "\\bin"));

var f = fso.CreateTextFile(logtalk_home + "\\bin\\logtalksicstus.rc", true);

f.WriteLine(":- consult('" + logtalk_home + "\\configs\\sicstus.config').");
f.WriteLine(":- consult('" + logtalk_home + "\\compiler\\logtalk.pl').");
f.Close();

f = fso.CreateTextFile(logtalk_home + "\\bin\\sicstuslgt.bat", true).

f.WriteLine("sicstus -l " + logtalk_home + "\\bin\\logtalksicstus.rc");
f.Close();

var ProgramsPath = WshShell.SpecialFolders("AllUsersPrograms");
var link = WshShell.CreateShortcut(ProgramsPath + "\\sicstuslgt.lnk");
link.Arguments = "-l "+ logtalk_home + "\\bin\\logtalksicstus.rc";
link.Description = "Logtalk & SICStus Prolog";
link.IconLocation = "app.exe,1";
link.TargetPath = WshShell.RegRead("HKEY_LOCAL_MACHINE\\Software\\SWI\\Prolog\\") + "\\bin\\eclipse.exe";
link.WindowStyle = 1;
link.WorkingDirectory = logtalk_home;
link.Save();

WScript.Echo("Done. The sicstuslgt shortcut was been added to the Start Menu Programs.");
WScript.Echo("Users should define the environment variable LOGTALKHOME in");
WScript.Echo("order to use the script.");
WScript.Echo("");

WScript.Quit(0);

function usage_help() {
	WScript.Echo("");
	WScript.Echo("This script creates a shortcut named sicstuslgt");
	WScript.Echo("for running Logtalk with SICStus Prolog.");
	WScript.Echo("");
	WScript.Echo("Usage:");
	WScript.Echo("  " + WScript.ScriptName + " help");
	WScript.Echo("  " + WScript.ScriptName);
	WScript.Echo("");
}

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

var html_xslt = logtalk_home + "\\xml\\lgthtml.xsl";
var xhtml_xslt = logtalk_home + "\\xml\\lgtxhtml.xsl";
var xslt;

var format = "xhtml";
// var format = "html";

var directory = WshShell.CurrentDirectory;

var index_file = "index.html";
var index_title = "Entity documentation index";

var processor = "xsltproc";
// var processor = "xalan";
// var processor = "sabcmd";

if (WScript.Arguments.Unnamed.Length > 0)
	usage_help();

if (WScript.Arguments.Named.Exists("f"))
	format = WScript.Arguments.Named.Item("f");

if (WScript.Arguments.Named.Exists("d"))
	directory = WScript.Arguments.Named.Item("d");

if (WScript.Arguments.Named.Exists("i"))
	index_file = WScript.Arguments.Named.Item("i");

if (WScript.Arguments.Named.Exists("t"))
	index_title = WScript.Arguments.Named.Item("t");

if (WScript.Arguments.Named.Exists("p"))
	processor = WScript.Arguments.Named.Item("p");

if (format = "xhtml")
	xslt = xhtml_xslt;
else if (format = "html")
	xslt = html_xslt;
else {
	WScript.Echo("Error! Unsupported output format: " + format);
	usage_help;
	WScript.Quit(1);
}

if (processor != "xsltproc" && processor != "xalan" && processor != "sabcmd") {
	WScript.Echo("Error! Unsupported XSLT processor:" + processor);
	WScript.Echo("");
	WScript.Quit(1);
}

var fso = new ActiveXObject("Scripting.FileSystemObject");

fso.CopyFile(logtalk_home + "\\xml\\logtalk.dtd", WshShell.CurrentDirectory + "\\logtalk.dtd");
fso.CopyFile(logtalk_home + "\\xml\\logtalk.xsd", WshShell.CurrentDirectory + "\\logtalk.xsd");
fso.CopyFile(logtalk_home + "\\xml\\logtalk.css", directory + "\\logtalk.css");

WScript.Echo("");
WScript.Echo("converting XML files...");

var files = new Enumerator(fso.GetFolder(WshShell.CurrentDirectory).Files);

for (files.moveFirst(); !files.atEnd(); files.moveNext()) {
	var file = files.item().name;
	if (fso.GetExtensionName(file) == "xml") {
		WScript.Echo("  converting " + file);
		var html_file = directory + "\\" + fso.GetBaseName(file) + ".html";
		switch (processor) {
			case "xsltproc" :
				WshShell.Run("xsltproc -o " + html_file + " " + xslt + " " + file, true);
				break;
			case "xalan" :
				WshShell.Run("xalan -o " + html_file + " " + file + " " + xslt, true);
				break;
			case "sabcmd" :
				WshShell.Run("sabcmd " + xslt + " " + file + " " + html_file, true);
				break;
		}
	}
}

WScript.Echo("conversion done");
WScript.Echo("");
WScript.Echo("generating index file...");

index_file = directory + "\\" + index_file;
create_index_file();

WScript.Echo("index file generated");
WScript.Echo("");

fso.DeleteFile("logtalk.dtd");
fso.DeleteFile("logtalk.xsd");

WScript.Quit(0);

function usage_help() {
	WScript.Echo("");
	WScript.Echo("This script converts all Logtalk XML files documenting files in the");
	WScript.Echo("current directory to XHTML or HTML files");
	WScript.Echo("");
	WScript.Echo("Usage:");
	WScript.Echo("  " + WScript.ScriptName + " [help] [/f:format] [/o:directory] [/i:index] [/t:title] [/p:processor]");
	WScript.Echo("");
	WScript.Echo("Optional arguments:");
	WScript.Echo("  f - output file format (either xhtml or html; default is " + format + ")");
	WScript.Echo("  o - output directory for the generated files (default is " + directory + ")");
	WScript.Echo("  i - name of the index file (default is " + index_file + ")");
	WScript.Echo("  t - title to be used on the index file (default is " + title + ")");
	WScript.Echo("  p - XSLT processor (xsltproc, xalan, or sabcmd; default is " + processor + ")");
	WScript.Echo("  help - print usage help");
	WScript.Echo("");
	WScript.Quit(1);
}

function create_index_file() {

	var f = fso.CreateTextFile(index_file, true);

	switch (format) {
		case "xhtml" :
			f.WriteLine("<?xml version=\"1.0\"?>");
			f.WriteLine("<?xml-stylesheet href=\"logtalk.css\" type=\"text/css\"?>");
			f.WriteLine("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
			f.WriteLine("<html lang=\"en\" xml:lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\">");
			break;
		case "html" :
			f.WriteLine("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">");
			f.WriteLine("<html>");
			break;
	}

	f.WriteLine("<head>");
	f.WriteLine("    <meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/>");
	f.WriteLine("    <title>" + index_title + "</title>");
	f.WriteLine("    <link rel=\"stylesheet\" href=\"logtalk.css\" type=\"text/css\"/>");
	f.WriteLine("</head>");
	f.WriteLine("<body>");
	f.WriteLine("<h1>" + index_title + "</h1>");
	f.WriteLine("<ul>");

	var files = new Enumerator(fso.GetFolder(WshShell.CurrentDirectory).Files);

	for (files.moveFirst(); !files.atEnd(); files.moveNext()) {
		var file = files.item().name;
		if (fso.GetExtensionName(file) == "xml") {
			var html_file = fso.GetBaseName(file) + ".html";
			WScript.Echo("  indexing " + html_file);
			f.WriteLine("    <li><a href=\"" + html_file + "\">" + fso.GetBaseName(file) + "</a></li>");
		}
	}

	f.WriteLine("</ul>");

	var today = new Date();
	var year  = today.getFullYear();
	var month = today.getMonth() + 1;
	if (month < 10)
        month = "0" + month;
	day   = today.getDate();
	if (day < 10)
        day = "0" + day;
	strToday = year + "/" + month + "/" + day;
	var hours = today.getHours();
	if (hours < 10)
        hours = "0" + hours;
	var mins = today.getMinutes();
	if (mins < 10)
        mins = "0" + mins;
	var secs = today.getSeconds();
	if (secs < 10)
        secs = "0" + secs;
	strTime = hours + ":" + mins + ":" + secs;
	f.WriteLine("<p>Generated on " + strToday + " - " + strTime + "</p>");

	f.WriteLine("</body>");
	f.WriteLine("</html>");

	f.Close();
}

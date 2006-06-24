; Script generated by the Inno Setup Script Wizard.

#define MyAppName "Logtalk"
#define MyAppVerName "Logtalk 2.28.0"
#define MyAppPublisher "Paulo Moura"
#define MyAppURL "http://logtalk.org"
#define MyAppUrlName "Logtalk Web Site.url"

#define LOGTALKHOME "{reg:HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment,LOGTALKHOME|{pf}\Logtalk}"
#define LOGTALKUSER "{reg:HKCU\Environment,LOGTALKUSER|{userdocs}\logtalk}"

[Setup]
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ChangesEnvironment=yes
DefaultDirName={#LOGTALKHOME}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=C:\logtalk\LICENSE
InfoBeforeFile=C:\logtalk\README
OutputBaseFilename=lgt2280
Compression=lzma
SolidCompression=yes

VersionInfoVersion=2.28.0
VersionInfoCopyright=� Paulo Moura, 1998-2006

AllowRootDirectory=yes

MinVersion=0,5.0

[Types]
Name: "full"; Description: "Full installation (recommended)"
Name: "base"; Description: "Base system installation"
Name: "user"; Description: "User-modifiable files installation (must be run by all end-users)"
Name: "prolog"; Description: "Prolog integration (see documentation for compatibility details)"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "base"; Description: "Base system"; Types: full base custom
Name: "user"; Description: "User-modifiable files"; Types: full user custom; Flags: checkablealone
Name: "user\backup"; Description: "Backup current user-modifiable files"; Types: full user custom
Name: "prolog"; Description: "Prolog integration"; Types: full prolog custom
Name: "prolog\ciao"; Description: "Ciao Prolog integration"; Types: full prolog custom
Name: "prolog\eclipse"; Description: "ECLiPSe integration"; Types: full prolog custom
Name: "prolog\gprolog"; Description: "GNU Prolog integration"; Types: full prolog custom
Name: "prolog\plc"; Description: "K-Prolog integration"; Types: full prolog custom
Name: "prolog\sicstus"; Description: "SICStus Prolog integration"; Types: full prolog custom
Name: "prolog\swi"; Description: "SWI-Prolog integration"; Types: full prolog custom
Name: "prolog\xsb"; Description: "XSB integration"; Types: full prolog custom
Name: "prolog\yap"; Description: "YAP integration"; Types: full prolog custom

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel=      Logtalk 2.28.0 � Paulo Moura, 1998-2006

[Dirs]
Name: {code:GetLgtUserDir}; Flags: uninsneveruninstall

[Files]
Source: "C:\logtalk\compiler\*"; Excludes: "CVS"; DestDir: "{app}\compiler"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\configs\*"; Excludes: "CVS"; DestDir: "{app}\configs"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\contributions\*"; Excludes: "CVS"; DestDir: "{app}\contributions"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\examples\*"; Excludes: "CVS"; DestDir: "{app}\examples"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\libpaths\*"; Excludes: "CVS"; DestDir: "{app}\libpaths"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\library\*"; Excludes: "CVS"; DestDir: "{app}\library"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\manuals\*"; Excludes: "CVS"; DestDir: "{app}\manuals"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\scripts\*"; Excludes: "CVS"; DestDir: "{app}\scripts"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\wenv\*"; Excludes: "CVS"; DestDir: "{app}\wenv"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\xml\*"; Excludes: "CVS"; DestDir: "{app}\xml"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\logtalk\BIBLIOGRAPHY"; DestDir: "{app}"; DestName: "BIBLIOGRAPHY.txt"; Components: base; Flags: ignoreversion
Source: "C:\logtalk\INSTALL"; DestDir: "{app}"; DestName: "INSTALL.txt"; Components: base; Flags: ignoreversion
Source: "C:\logtalk\LICENSE"; DestDir: "{app}"; DestName: "LICENSE.txt"; Components: base; Flags: ignoreversion
Source: "C:\logtalk\QUICK_START"; DestDir: "{app}"; DestName: "QUICK_START.txt"; Components: base; Flags: ignoreversion
Source: "C:\logtalk\README"; DestDir: "{app}"; DestName: "README.txt"; Components: base; Flags: ignoreversion
Source: "C:\logtalk\RELEASE_NOTES"; DestDir: "{app}"; DestName: "RELEASE_NOTES.txt"; Components: base; Flags: ignoreversion
Source: "C:\logtalk\UPGRADING"; DestDir: "{app}"; DestName: "UPGRADING.txt"; Components: base; Flags: ignoreversion

Source: "{code:GetLgtUserDir}\*"; DestDir: "{code:GetLgtUserDir} backup"; Components: user\backup; Flags: external recursesubdirs createallsubdirs skipifsourcedoesntexist uninsneveruninstall

Source: "C:\logtalk\configs\*"; Excludes: "CVS"; DestDir: "{code:GetLgtUserDir}\configs"; Components: user; Flags: ignoreversion recursesubdirs createallsubdirs uninsneveruninstall
Source: "C:\logtalk\contributions\*"; Excludes: "CVS"; DestDir: "{code:GetLgtUserDir}\contributions"; Components: user; Flags: ignoreversion recursesubdirs createallsubdirs uninsneveruninstall
Source: "C:\logtalk\examples\*"; Excludes: "CVS"; DestDir: "{code:GetLgtUserDir}\examples"; Components: user; Flags: ignoreversion recursesubdirs createallsubdirs uninsneveruninstall
Source: "C:\logtalk\libpaths\*"; Excludes: "CVS"; DestDir: "{code:GetLgtUserDir}\libpaths"; Components: user; Flags: ignoreversion recursesubdirs createallsubdirs uninsneveruninstall
Source: "C:\logtalk\library\*"; Excludes: "CVS"; DestDir: "{code:GetLgtUserDir}\library"; Components: user; Flags: ignoreversion recursesubdirs createallsubdirs uninsneveruninstall
Source: "C:\logtalk\xml\*"; Excludes: "CVS"; DestDir: "{code:GetLgtUserDir}\xml"; Components: user; Flags: ignoreversion recursesubdirs createallsubdirs uninsneveruninstall

[INI]
Filename: "{app}\{#MyAppUrlName}"; Section: "InternetShortcut"; Key: "URL"; String: "{#MyAppURL}"; Components: base

[Icons]
Name: "{group}\{#MyAppName} Bibliography"; Filename: "{app}\BIBLIOGRAPHY.txt"; Components: base
Name: "{group}\{#MyAppName} Documentation"; Filename: "{app}\manuals\index.html"; Components: base
Name: "{group}\{#MyAppName} License"; Filename: "{app}\LICENSE.txt"; Components: base
Name: "{group}\{#MyAppName} Release Notes"; Filename: "{app}\RELEASE_NOTES.txt"; Components: base
Name: "{group}\{#MyAppName} Read Me"; Filename: "{app}\README.txt"; Components: base

Name: "{group}\{#MyAppName} Web Site"; Filename: "{app}\{#MyAppUrlName}"; Components: base
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; Components: base

Name: "{code:GetLgtUserDir}\manuals"; Filename: "{app}\manuals"; Components: user
Name: "{code:GetLgtUserDir}\wenv"; Filename: "{app}\wenv"; Components: user

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "LOGTALKHOME"; ValueData: "{app}"; Flags: deletevalue uninsdeletevalue
Root: HKCU; Subkey: "Environment"; ValueType: expandsz; ValueName: "LOGTALKUSER"; ValueData: "{code:GetLgtUserDir}"; Flags: createvalueifdoesntexist

[Run]
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_ciaolgt.js"""; Description: "Ciao Prolog integration"; Components: prolog\ciao
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_eclipselgt.js"""; Description: "ECLiPSe integration"; Components: prolog\eclipse
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_gplgt.js"""; Description: "GNU Prolog integration"; Components: prolog\gprolog
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_plclgt.js"""; Description: "K-Prolog integration"; Components: prolog\plc
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_sicstuslgt.js"""; Description: "SICStus Prolog integration"; Components: prolog\sicstus
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_swilgt.js"""; Description: "SWI-Prolog integration"; Components: prolog\swi
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_xsblgt.js"""; Description: "XSB integration"; Components: prolog\xsb
Filename: "{cmd}"; Parameters: "/C cscript ""{app}\scripts\make_yaplgt.js"""; Description: "YAP integration"; Components: prolog\yap

Filename: "{app}\RELEASE_NOTES.txt"; Description: "View the release notes"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\INSTALL.txt"; Description: "Review the install instructions for completing your setup"; Flags: postinstall shellexec skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
Type: filesandordirs; Name: "{group}"

[Code]
var
  LgtUserDirPage: TInputDirWizardPage;

procedure InitializeWizard;
begin
  LgtUserDirPage := CreateInputDirPage(wpSelectDir,
    'Select Folder for Logtalk User-modifiable Files', 'Where should Logtalk user-modifiable files be installed?',
    'Select the folder in which Setup should install Logtalk user-modifiable files, then click Next.',
    False, 'New Folder');
  LgtUserDirPage.Add('');
  LgtUserDirPage.Values[0] := ExpandConstant('{#LOGTALKUSER}');
end;

function GetLgtUserDir(Param: String): String;
begin
  { Return the selected DataDir }
  Result := LgtUserDirPage.Values[0];
end;


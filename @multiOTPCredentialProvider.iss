#define MyAppName "multiOTP Credential Provider"
#define MyAppVersion "5.8.1.1"
#define MyAppShortName "multiOTP"
#define MyAppPublisher "SysCo systemes de communication sa"
#define MyAppURL "https://github.com/multiOTP/multiOTPCredentialProvider"
#define MyAppCopyright "Copyright (c) 2010-2021 SysCo / ArcadeJust / LastSquirrelIT (Apache License)"
#define MyAppId="{FCEFDFAB-B0A1-4C4D-8B2B-4FF4E0A3D978}"

;Dependency installation based on: http://github.com/stfx/innodependencyinstaller
#define use_msiproduct
#define use_vc2015_2019

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
VersionInfoVersion={#MyAppVersion}
VersionInfoCopyright={#MyAppCopyright}
VersionInfoProductName={#MyAppName}
; DefaultDirName={sd}\{#MyAppShortName}
DefaultDirName={commonpf32}\{#MyAppShortName}
DefaultGroupName={#MyAppName}
UninstallDisplayIcon={app}\multiotp.exe
DisableProgramGroupPage=yes
OutputDir=installer
OutputBaseFilename=multiOTPCredentialProvider-5.8.1.1
SetupIconFile=ico\multiOTP.ico
WizardImageFile=bmp\multiOTP-wizard-164x314.bmp
WizardSmallImageFile=bmp\multiOTP-wizard-55x58.bmp
Compression=lzma
SolidCompression=yes

PrivilegesRequired=admin

; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
; On all other architectures it will install in "32-bit mode".
ArchitecturesInstallIn64BitMode=x64
; Note: We don't set ProcessorsAllowed because we want this
; installation to run on all architectures (including Itanium,
; since it's capable of running 32-bit code too).

; downloading and installing dependencies will only work if the memo/ready page is enabled (default and current behaviour)
DisableReadyPage=no
DisableReadyMemo=no

; Signing options
;SignTool=standard
;SignedUninstaller=yes

;[Languages]
;Name: "english"; MessagesFile: "compiler:Default.isl"
;Name: "french"; MessagesFile: "compiler:Languages\French.isl"

; supported languages for Dependency installer
#include "scripts\lang\english.iss"
;#include "scripts\lang\french.iss"

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
; ignoreversion is used on specific files here, as we have to be consistant and be able to upgrade/downgrade
Source: "stable\multiotp.exe"; DestDir: "{app}"; Flags: ignoreversion; AfterInstall: AfterInstallProcedure
Source: "stable\x64\multiOTPCredentialProvider.dll"; DestDir: "{sys}"; Flags: ignoreversion; Check: Is64BitInstallMode
Source: "stable\i386\multiOTPCredentialProvider.dll"; DestDir: "{sys}"; Flags: ignoreversion; Check: not Is64BitInstallMode
Source: "stable\php\*"; DestDir: "{app}\php"; Flags: ignoreversion createallsubdirs recursesubdirs
Source: "stable\templates\template.html"; DestDir: "{app}\templates"; Flags: ignoreversion
Source: "stable\templates\emailtemplate.html"; DestDir: "{app}\templates"; Flags: ignoreversion
Source: "stable\templates\scratchtemplate.html"; DestDir: "{app}\templates"; Flags: ignoreversion
Source: "stable\x64\SetACL.exe"; DestDir: "{app}\tools"; Flags: ignoreversion; Check: Is64BitInstallMode
Source: "stable\i386\SetACL.exe"; DestDir: "{app}\tools"; Flags: ignoreversion; Check: not Is64BitInstallMode

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Registry]
; Imported Registry File: "register.reg"
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{{#MyAppId}"; ValueType: string; ValueData: "multiOTPCredentialProvider"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Provider Filters\{{#MyAppId}"; ValueType: string; ValueData: "multiOTPCredentialProvider"; Flags: uninsdeletekey
Root: "HKCR"; Subkey: "CLSID\{{#MyAppId}\InprocServer32"; ValueType: string; ValueData: "multiOTPCredentialProvider.dll"; Flags: uninsdeletekey
Root: "HKCR"; Subkey: "CLSID\{{#MyAppId}\InprocServer32"; ValueType: string; ValueName: "ThreadingModel"; ValueData: "Apartment"; Flags: uninsdeletekey
Root: "HKCR"; Subkey: "CLSID\{{#MyAppId}"; ValueType: string; ValueData: "multiOTPCredentialProvider"; Flags: uninsdeletekey
Root: "HKCR"; Subkey: "CLSID\{{#MyAppId}"; ValueType: string; ValueName: "multiOTPPath"; ValueData: "{app}\"; Flags: uninsdeletekey

[CustomMessages]
ProgramOnTheWeb=%1 on the Web
UninstallProgram=Uninstall %1
multiOTPDefaultPrefixLabel=Default logon prefix
multiOTPDefaultPrefixSample=(. = local computer, default is empty for automatic detection of domain name)
multiOTPLoginTitleLabel=multiOTP Login Title
multiOTPserversLabel=URL of your multiOTP server(s), separated by semi-colons
multiOTPServersSample=Example: https://192.168.1.88 ; http://ip.address.of.server:8112
multiOTPconfiguration=multiOTP configuration
multiOTPconfigurationDescription=Type the needed multiOTP server information, then click Next.
multiOTPServerTimeoutLabel=Timeout (in seconds) before switching to the next server
multiOTPSharedSecretLabel=Secret shared with your multiOTP server(s)
multiOTPSharedSecretSample=On your multiOTP server, Menu Configuration/Devices, Edit/Add a device
multiOTPSharedSecretSample2=that match the IP and subnet mask of this current Windows machine
multiOTPCacheEnabledCheckBox=Enable cache support on this machine if authorized by the server(s)
multiotpDisableAutoReconnectCheckBox=Disable automatic RDP reconnection
multiOTPRDPOnlyCheckBox=Only RDP connection must be protected with strong authentication
multiOTPPrefixPassCheckBox=Send to multiOTP the concatenation of the windows password and the OTP
multiOTPDisplaySmsLinkCheckBox=Display the [Receive an OTP by SMS] link
multiOTPUPNFormatCheckBox=Send the username to multiOTP in UPN format (user@domain.name)
multiOTPTimeoutLabel=Timeout (in seconds) for the Credential Provider
multiOTPLibraryVersion=multiOTP library version
multiOTPCredentialProviderState=Credential Provider state
multiOTPErrorConfiguration=Error during multiOTP configuration
multiOTPPleaseWait=please wait...
multiOTPConfigurationTest=multiOTP configuration test
multiOTPCheckServer=Check if multiOTP is working correctly.
multiOTPWindowsUsername=Windows username
multiOTPWindowsPassword=Windows password
multiOTPUserOTP=OTP for this user
multiOTPTestButton=Test the multiOTP authentication to activate the Credential Provider
multiOTPTestResult=multiOTP test result
multiOTPUsernamePasswordOrOtpMissing=Username, password or OTP is missing
multiOTPWindowsUsernameOrPasswordIncorrect=The windows user name or password is incorrect
multiOTPWindowsLoginFailed=Windows login failed
multiOTPSystemErrorDuringmultiOTPTest=System error during multiOTP test
multiOTPInstalledAndActivated=installed and activated
multiOTPNotActivated=NOT activated
multiOTPReturnCode0=username and OTP validated by the multiOTP server
multiOTPReturnCode21=User doesn't exist
multiOTPReturnCode24=User locked (too many tries)
multiOTPReturnCode25=User delayed (too many tries)
multiOTPReturnCode26=This token has already been used
multiOTPReturnCode28=Unable to write the changes for the user
multiOTPReturnCode30=Username or password is missing
multiOTPReturnCode98=Wrong token length, check if a prefix is required
multiOTPReturnCode99=Authentication failed (and other possible unknown errors)
multiOTPReturnCodePrefix=Check exit code 
multiOTPReturnCodeSuffix= in multiOTP documentation

;french.ProgramOnTheWeb=%1 sur Internet
;french.UninstallProgram=D�sinstaller %1
;french.multiOTPDefaultPrefixLabel=Default logon prefix
;french.multiOTPDefaultPrefixSample=(. = local computer, default is empty for automatic detection of domain name)
;french.multiOTPLoginTitleLabel=Titre du fournisseur de connexion multiOTP
;french.multiOTPserversLabel=URL de votre/vos serveur(s) multiOTP, s�par�s par un point-virgule
;french.multiOTPServersSample=Exemple: https://192.168.1.88 ; http://adresse.ip.du.serveur:8112
;french.multiOTPconfiguration=Configuration multiOTP
;french.multiOTPconfigurationDescription=Saisir les donn�es concernant multiOTP, puis cliquer sur Suivant.
;french.multiOTPServerTimeoutLabel=Temps d'attente (en secondes) avant de passer au serveur suivant
;french.multiOTPSharedSecretLabel=Secret partag� avec le(s) serveur(s) multiOTP
;french.multiOTPSharedSecretSample=Sur votre serveur multiOTP, Menu Configuration/Appareils, Editer/Ajouter un appareil
;french.multiOTPSharedSecretSample2=that match the IP and subnet mask of this current Windows machine
;french.multiOTPCacheEnabledCheckBox=Enable cache support on this machine if authorized by the server(s)
;french.multiotpDisableAutoReconnect=Disable automatic RDP reconnection
;french.multiOTPRDPOnlyCheckBox=Only RDP connection must be protected with strong authentication
;french.multiOTPPrefixPassCheckBox=Send to multiOTP the concatenation of the windows password and the OTP
;french.multiOTPDisplaySmsLinkCheckBox=Display the [Receive an OTP by SMS] link
;french.multiOTPUPNFormatCheckBox=Send the username to multiOTP in UPN format (user@domain.name)
;french.multiOTPTimeoutLabel=Temps d'attente (en secondes) pour l'ex�cution du Credential Provider
;french.multiOTPLibraryVersion=Version de la librairie multiOTP
;french.multiOTPCredentialProviderState=Etat du Credential Provider
;french.multiOTPErrorConfiguration=Erreur pendant la configuration de multiOTP
;french.multiOTPPleaseWait=merci de patienter...
;french.multiOTPConfigurationTest=Test de configuration multiOTP
;french.multiOTPCheckServer=Test si multiOTP fonctionne correctemnt.
;french.multiOTPWindowsUsername=Utilisateur Windows
;french.multiOTPWindowsPassword=Mot de passe Windows
;french.multiOTPUserOTP=OTP pour cet utilisateur
;french.multiOTPTestButton=Tester l'authentification par multiOTP pour activer le Credential Provider
;french.multiOTPTestResult=R�sultat du test multiOTP
;french.multiOTPUsernamePasswordOrOtpMissing=Username, password or OTP is missing
;french.multiOTPWindowsUsernameOrPasswordIncorrect=The windows user name or password is incorrect
;french.multiOTPWindowsLoginFailed=Windows login failed
;french.multiOTPSystemErrorDuringmultiOTPTest=System error during multiOTP test
;french.multiOTPInstalledAndActivated=install� et activ�
;french.multiOTPNotActivated=PAS activ�
;french.multiOTPReturnCode0=username and OTP validated by the multiOTP server
;french.multiOTPReturnCode21=User doesn't exist
;french.multiOTPReturnCode24=User locked (too many tries)
;french.multiOTPReturnCode25=User delayed (too many tries)
;french.multiOTPReturnCode26=This token has already been used
;french.multiOTPReturnCode28=Unable to write the changes for the user
;french.multiOTPReturnCode30=Username or password is missing
;french.multiOTPReturnCode98=Wrong token length, check if a prefix is required
;french.multiOTPReturnCode99=Authentication failed (and other possible unknown errors)
;french.multiOTPReturnCodePrefix=Check exit code 
;french.multiOTPReturnCodeSuffix= in multiOTP documentation

DependenciesDir=MyProgramDependencies
WindowsServicePack=Windows %1 Service Pack %2

; shared code for installing the Dependency products
#include "scripts\products.iss"

; helper functions
#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"

; actual products
#ifdef use_msiproduct
#include "scripts\products\msiproduct.iss"
#endif
#ifdef use_vc2015_2019
#include "scripts\products\vcredist2015_2019.iss"
#endif


[Code]
var
  testPage: TWizardPage;
  testDone: Boolean;
  testSuccess: Boolean;
  testButton: TNewButton;
  testButtonResult: TNewStaticText;
  credentialProviderState: TNewStaticText;
  credentialProviderInstalled: Boolean;
  multiOTPversion: TNewStaticText;

  testUsernameEdit: TEdit;
  testPasswordEdit: TEdit;
  testOtpdEdit: TEdit;

  multiOTPDefaultPrefix: String;
  multiOTPLoginTitle: String;
  multiOTPServers: String;
  multiOTPServerTimeout: Cardinal;
  multiOTPSharedSecret: String;
  multiOTPCacheEnabled: Cardinal;
  multiotpDisableAutoReconnect: Cardinal;
  multiOTPRDPOnly: Cardinal;
  multiOTPTimeout: Cardinal;
  multiOTPPrefixPass: Cardinal;
  multiOTPDisplaySmsLink: Cardinal;
  multiOTPUPNFormat: Cardinal;

  multiOTPDefaultPrefixEdit: TEdit;
  multiOTPLoginTitleEdit: TEdit;
  multiOTPServersEdit: TEdit;
  multiOTPServerTimeoutEdit: TEdit;
  multiOTPSharedSecretEdit: TEdit;
  multiOTPCacheEnabledCheckBox: TCheckBox;
  multiOTPDisableAutoReconnectCheckBox: TCheckBox;
  multiOTPRDPOnlyCheckBox: TCheckBox;
  multiOTPTimeoutEdit: TEdit;
  multiOTPPrefixPassCheckBox: TCheckBox;
  multiOTPDisplaySmsLinkCheckBox: TCheckBox;
  multiOTPUPNFormatCheckBox: TCheckBox;

#ifdef UNICODE
  #define AW "W"
#else
  #define AW "A"
#endif

const  
  LOGON32_LOGON_INTERACTIVE = 2;
  LOGON32_LOGON_NETWORK = 3;
  LOGON32_LOGON_BATCH = 4;
  LOGON32_LOGON_SERVICE = 5;
  LOGON32_LOGON_UNLOCK = 7;
  LOGON32_LOGON_NETWORK_CLEARTEXT = 8;
  LOGON32_LOGON_NEW_CREDENTIALS = 9;

  LOGON32_PROVIDER_DEFAULT = 0;
  LOGON32_PROVIDER_WINNT40 = 2;
  LOGON32_PROVIDER_WINNT50 = 3;

  ERROR_SUCCESS = 0;
  ERROR_LOGON_FAILURE = 1326;
  ERROR_MORE_DATA = 234;
  
  NameUnknown           = 0;
  NameFullyQualifiedDN  = 1;
  NameSamCompatible     = 2;
  NameDisplay           = 3;
  NameUniqueId          = 6;
  NameCanonical         = 7;
  NameUserPrincipal     = 8;
  NameCanonicalEx       = 9;
  NameServicePrincipal  = 10;
  NameDnsDomain         = 12; 

type
  TComputerNameFormat = (
    ComputerNameNetBIOS,
    ComputerNameDnsHostname,
    ComputerNameDnsDomain,
    ComputerNameDnsFullyQualified,
    ComputerNamePhysicalNetBIOS,
    ComputerNamePhysicalDnsHostname,
    ComputerNamePhysicalDnsDomain,
    ComputerNamePhysicalDnsFullyQualified,
    ComputerNameMax
  );

  
// Initialize Dependency distribution
function InitializeSetup(): boolean;
begin
	// initialize windows version
	initwinversion();

#ifdef use_vc2015_2019
	vcredist2015_2019('14.20'); // min allowed version is 14.2 for VC 2019, Check https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B for detail
#endif
	Result := true;
end;


function LogonUser(lpszUsername, lpszDomain, lpszPassword: string;
  dwLogonType, dwLogonProvider: DWORD; var phToken: THandle): BOOL;
  external 'LogonUser{#AW}@advapi32.dll stdcall';

function TranslateName(lpAccountName: String; AccountNameFormat, DesiredNameFormat: Cardinal; lpTranslatedName: string; var nSize: DWORD): BOOL;
  external 'TranslateName{#AW}@Secur32.dll stdcall';

function GetComputerNameEx(NameType: TComputerNameFormat; lpBuffer: string; var nSize: DWORD): BOOL;
  external 'GetComputerNameEx{#AW}@kernel32.dll stdcall';
  
function DsGetDcName(lpComputerName: String; lpDomainName: String; lpDomainGuid: String; lpSiteName: String; Flags: DWORD; var lpDomainControllerInfo: THandle): DWORD;
  external 'DsGetDcName{#AW}@NetApi32.dll stdcall';

function TryLogonUser(const Domain, UserName, Password: string; var ErrorCode: Longint): Boolean;
var
  Token: THandle;
begin
  Result := LogonUser(UserName, Domain, Password, LOGON32_LOGON_INTERACTIVE, LOGON32_PROVIDER_DEFAULT, Token);
  if (Result) then begin
    ErrorCode := ERROR_SUCCESS;
  end else begin
    ErrorCode := DLLGetLastError;
  end;
end;

function TryGetComputerName(Format: TComputerNameFormat; out Output: string): Boolean;
var
  BufLen: DWORD;
begin
  Result := False;
  BufLen := 0;
  if not Boolean(GetComputerNameEx(Format, '', BufLen)) and (DLLGetLastError = ERROR_MORE_DATA) then
  begin
    SetLength(Output, BufLen);
    if (GetComputerNameEx(Format, Output, BufLen)) then begin
      SetLength(Output, BufLen-1);
    end
  end;    
end;

procedure ParseDomainUserName(const Value: string; var Domain, UserName, UPNUserName: string);
var
  DelimPos: Integer;
  buffer : string;
  buffer2 : string;
  nSize : DWORD;
begin
  buffer := Value;
  DelimPos := Pos('@', Value);
  if DelimPos <> 0 then
  begin
    UPNUserName := Value;
    nSize := 256;
    buffer := StringOfChar(#0, nSize);
    SetLength(buffer, nSize);
    if (TranslateName(Value, NameUserPrincipal, NameSamCompatible, buffer, nSize)) then begin
      SetLength(buffer, nSize-1);
    end
  end
  else
  begin
    nSize := 256;
    buffer2 := StringOfChar(#0, nSize);
    SetLength(buffer2, nSize);
    if (TranslateName(Value, NameSamCompatible, NameUserPrincipal, buffer2, nSize)) then begin
      SetLength(buffer2, nSize-1);
      UPNUserName := buffer2;
    end
  end;

  DelimPos := Pos('\', buffer);
  if DelimPos = 0 then
  begin
    Domain := '.';
    UserName := buffer;
  end
  else
  begin
    Domain := Copy(buffer, 1, DelimPos - 1);
    UserName := Copy(buffer, DelimPos + 1, MaxInt);
  end;
end;

procedure AfterInstallProcedure;

begin
end;

procedure CreateSetupPage1of2;
var
  Page: TWizardPage;
  multiOTPLoginTitleLabel: TNewStaticText;
  multiOTPServersLabel: TNewStaticText;
  multiOTPServersSample: TNewStaticText;
  multiOTPServerTimeoutLabel: TNewStaticText;
  multiOTPSharedSecretLabel: TNewStaticText;
  multiOTPSharedSecretSample: TNewStaticText;
  multiOTPSharedSecretSample2: TNewStaticText;

  pageTop: Integer;
  pageLeft: Integer;

begin
  pageTop := 0;
  pageLeft := 0;

  // Create the page
  Page := CreateCustomPage(wpSelectTasks,
    ExpandConstant('{cm:multiOTPconfiguration}'),
    ExpandConstant('{cm:multiOTPconfigurationDescription}'));

  multiOTPLoginTitleLabel := TNewStaticText.Create(Page);
  with multiOTPLoginTitleLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPLoginTitleLabel}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPLoginTitleLabel.Height + ScaleY(0);

  multiOTPLoginTitleEdit := TEdit.Create(Page);
  with multiOTPLoginTitleEdit do
  begin
    Parent := Page.Surface;
    Left := pageLeft;
    Top := pageTop;
    Width := Page.SurfaceWidth - Left;
    Text := multiOTPLoginTitle;
  end;
  pageTop := pageTop + 2 * multiOTPLoginTitleEdit.Height + ScaleY(0);

  multiOTPServersLabel := TNewStaticText.Create(Page);
  with multiOTPServersLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPServersLabel}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPServersLabel.Height + ScaleY(0);

  multiOTPServersSample := TNewStaticText.Create(Page);
  with multiOTPServersSample do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsItalic];
    Caption := ExpandConstant('{cm:multiOTPServersSample}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPServersSample.Height + ScaleY(0);

  multiOTPServersEdit := TEdit.Create(Page);
  with multiOTPServersEdit do
  begin
    Parent := Page.Surface;
    Left := pageLeft;
    Top := pageTop;
    Width := Page.SurfaceWidth - Left;
    Text := multiOTPServers;
  end;
  pageTop := pageTop + 2 * multiOTPServersEdit.Height;

  multiOTPServerTimeoutLabel := TNewStaticText.Create(Page);
  with multiOTPServerTimeoutLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPServerTimeoutLabel} : ');
    Parent := Page.Surface;
  end;

  multiOTPServerTimeoutEdit := TEdit.Create(Page);
  with multiOTPServerTimeoutEdit do
  begin
    Parent := Page.Surface;
    Left := pageLeft + multiOTPServerTimeoutLabel.Width;
    Top := pageTop - ScaleY(3);
    Width := 2 * multiOTPServerTimeoutLabel.Height;
    Text := IntToStr(multiOTPServerTimeout);
  end;
  pageTop := pageTop + 2 * multiOTPServerTimeoutLabel.Height;

  pageTop := pageTop + ScaleY(4);
  multiOTPSharedSecretLabel := TNewStaticText.Create(Page);
  with multiOTPSharedSecretLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPSharedSecretLabel}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPSharedSecretLabel.Height + ScaleY(0);


  multiOTPSharedSecretEdit := TEdit.Create(Page);
  with multiOTPSharedSecretEdit do
  begin
    Parent := Page.Surface;
    Left := pageLeft;
    Top := pageTop;
    Width := 20 * ScaleX(multiOTPSharedSecretLabel.Font.Size);
    Text := multiOTPSharedSecret;
  end;
  pageTop := pageTop + multiOTPSharedSecretEdit.Height + ScaleY(0);

  multiOTPSharedSecretSample := TNewStaticText.Create(Page);
  with multiOTPSharedSecretSample do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsItalic];
    Caption := ExpandConstant('{cm:multiOTPSharedSecretSample}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPSharedSecretSample.Height;
  multiOTPSharedSecretSample2 := TNewStaticText.Create(Page);
  with multiOTPSharedSecretSample2 do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsItalic];
    Caption := ExpandConstant('{cm:multiOTPSharedSecretSample2}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPSharedSecretSample2.Height + ScaleY(0);

end;


procedure CreateSetupPage2of2;
var
  Page: TWizardPage;
  multiOTPDefaultPrefixLabel: TNewStaticText;
  multiOTPDefaultPrefixSample: TNewStaticText;
  multiOTPTimeoutLabel: TNewStaticText;
  pageTop: Integer;
  pageLeft: Integer;

begin
  pageTop := 0;
  pageLeft := 0;

  // Create the page
  Page := CreateCustomPage(wpSelectTasks,
    ExpandConstant('{cm:multiOTPconfiguration}'),
    ExpandConstant('{cm:multiOTPconfigurationDescription}'));

  multiOTPRDPOnlyCheckBox := TCheckBox.Create(Page);
  with multiOTPRDPOnlyCheckBox do begin
    Top := pageTop;
    Left := pageLeft + 12;
    Width := Page.SurfaceWidth;
    Caption := ExpandConstant('{cm:multiOTPRDPOnlyCheckBox}');
    if (1 = multiOTPRDPOnly) then begin
      State := cbChecked;
    end else begin
      State := cbUnchecked;
    end;
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPRDPOnlyCheckBox.Height + ScaleY(0);
  
  multiOTPDisableAutoReconnectCheckBox := TCheckBox.Create(Page);
  with multiOTPDisableAutoReconnectCheckBox do begin
    Top := pageTop;
    Left := pageLeft + 12;
    Width := Page.SurfaceWidth;
    Caption := ExpandConstant('{cm:multiOTPDisableAutoReconnectCheckBox}');
    if (1 = multiOTPDisableAutoReconnect) then begin
      State := cbChecked;
    end else begin
      State := cbUnchecked;
    end;
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPDisableAutoReconnectCheckBox.Height + ScaleY(4);
  
  multiOTPCacheEnabledCheckBox := TCheckBox.Create(Page);
  with multiOTPCacheEnabledCheckBox do begin
    Top := pageTop;
    Left := pageLeft + 12;
    Width := Page.SurfaceWidth;
    Caption := ExpandConstant('{cm:multiOTPCacheEnabledCheckBox}');
    if (1 = multiOTPCacheEnabled) then begin
      State := cbChecked;
    end else begin
      State := cbUnchecked;
    end;
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPCacheEnabledCheckBox.Height + ScaleY(4);

  multiOTPDisplaySmsLinkCheckBox := TCheckBox.Create(Page);
  with multiOTPDisplaySmsLinkCheckBox do begin
    Top := pageTop;
    Left := pageLeft + 12;
    Width := Page.SurfaceWidth;
    Caption := ExpandConstant('{cm:multiOTPDisplaySmsLinkCheckBox}');
    if (1 = multiOTPDisplaySmsLink) then begin
      State := cbChecked;
    end else begin
      State := cbUnchecked;
    end;
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPDisplaySmsLinkCheckBox.Height + ScaleY(4);

  multiOTPPrefixPassCheckBox := TCheckBox.Create(Page);
  with multiOTPPrefixPassCheckBox do begin
    Top := pageTop;
    Left := pageLeft + 12;
    Width := Page.SurfaceWidth;
    Caption := ExpandConstant('{cm:multiOTPPrefixPassCheckBox}');
    if (1 = multiOTPPrefixPass) then begin
      State := cbChecked;
    end else begin
      State := cbUnchecked;
    end;
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPPrefixPassCheckBox.Height + ScaleY(0);

  multiOTPUPNFormatCheckBox := TCheckBox.Create(Page);
  with multiOTPUPNFormatCheckBox do begin
    Top := pageTop;
    Left := pageLeft + 12;
    Width := Page.SurfaceWidth;
    Caption := ExpandConstant('{cm:multiOTPUPNFormatCheckBox}');
    if (1 = multiOTPUPNFormat) then begin
      State := cbChecked;
    end else begin
      State := cbUnchecked;
    end;
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPUPNFormatCheckBox.Height + ScaleY(8);
  
  multiOTPTimeoutLabel := TNewStaticText.Create(Page);
  with multiOTPTimeoutLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft + 12;
    Caption := ExpandConstant('{cm:multiOTPTimeoutLabel} : ');
    Parent := Page.Surface;
  end;

  multiOTPTimeoutEdit := TEdit.Create(Page);
  with multiOTPTimeoutEdit do
  begin
    Parent := Page.Surface;
    Left := pageLeft + 12 + multiOTPTimeoutLabel.Width;
    Top := pageTop - ScaleY(3);
    Width := 2 * multiOTPTimeoutLabel.Height;
    Text := IntToStr(multiOTPTimeout);
  end;
  pageTop := pageTop + multiOTPTimeoutLabel.Height + ScaleY(8);

  multiOTPDefaultPrefixLabel := TNewStaticText.Create(Page);
  with multiOTPDefaultPrefixLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft + 12;
    Caption := ExpandConstant('{cm:multiOTPDefaultPrefixLabel} : ');
    Parent := Page.Surface;
  end;

  multiOTPDefaultPrefixEdit := TEdit.Create(Page);
  with multiOTPDefaultPrefixEdit do
  begin
    Parent := Page.Surface;
    Left := pageLeft + 12 + multiOTPDefaultPrefixLabel.Width;
    Top := pageTop - ScaleY(3);
    Width := 15 * ScaleX(multiOTPDefaultPrefixLabel.Font.Size);
    Text := multiOTPDefaultPrefix;
  end;
  pageTop := pageTop + multiOTPDefaultPrefixEdit.Height + ScaleY(0);

  multiOTPDefaultPrefixSample := TNewStaticText.Create(Page);
  with multiOTPDefaultPrefixSample do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft + 12;
    Font.Style := [fsItalic];
    Caption := ExpandConstant('{cm:multiOTPDefaultPrefixSample}');
    Parent := Page.Surface;
  end;
  pageTop := pageTop + multiOTPDefaultPrefixSample.Height;

end;


procedure ReadMultiotpInteractiveValue;
begin
  multiOTPDefaultPrefix := multiOTPDefaultPrefixEdit.Text;
  multiOTPLoginTitle := multiOTPLoginTitleEdit.Text;
  multiOTPServers := multiOTPServersEdit.Text;
  multiOTPServerTimeout := StrToIntDef(multiOTPServerTimeoutEdit.Text, multiOTPServerTimeout);
  multiOTPSharedSecret := multiOTPSharedSecretEdit.Text;

  if (cbChecked = multiOTPCacheEnabledCheckBox.State) then begin
    multiOTPCacheEnabled := 1;
  end else begin
    multiOTPCacheEnabled := 0;
  end;

  if (cbChecked = multiOTPRDPOnlyCheckBox.State) then begin
    multiOTPRDPOnly := 1;
  end else begin
    multiOTPRDPOnly := 0;
  end;
  
  if (cbChecked = multiOTPDisableAutoReconnectCheckBox.State) then begin
    multiotpDisableAutoReconnect := 1;
  end else begin
    multiotpDisableAutoReconnect := 0;
  end;

  multiOTPTimeout := StrToIntDef(multiOTPTimeoutEdit.Text, multiOTPTimeout);

  if (cbChecked = multiOTPPrefixPassCheckBox.State) then begin
    multiOTPPrefixPass := 1;
  end else begin
    multiOTPPrefixPass := 0;
  end;

  if (cbChecked = multiOTPDisplaySmsLinkCheckBox.State) then begin
    multiOTPDisplaySmsLink := 1;
  end else begin
    multiOTPDisplaySmsLink := 0;
  end;

  if (cbChecked = multiOTPUPNFormatCheckBox.State) then begin
    multiOTPUPNFormat := 1;
  end else begin
    multiOTPUPNFormat := 0;
  end;
end;


procedure WriteMultiotpRegValue;
var
  ResultCode: Integer;
  ResultBoolean : Boolean;
  
begin
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPDefaultPrefix', multiOTPDefaultPrefix);
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPLoginTitle', multiOTPLoginTitle);
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPServers', multiOTPServers);
  RegWriteDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPServerTimeout', multiOTPServerTimeout);
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPSharedSecret', multiOTPSharedSecret);
  RegWriteDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPCacheEnabled', multiOTPCacheEnabled);
  RegWriteDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPRDPOnly', multiOTPRDPOnly);
  RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services','fDisableAutoReconnect', multiotpDisableAutoReconnect);
  RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services','fDisableAutoReconnect', multiotpDisableAutoReconnect);
  RegWriteDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPPrefixPass', multiOTPPrefixPass);
  RegWriteDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPDisplaySmsLink', multiOTPDisplaySmsLink);
  RegWriteDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPUPNFormat', multiOTPUPNFormat);
  
  ResultBoolean := Exec(ExpandConstant('{app}\tools\SetACL.exe'), '-on "HKEY_CLASSES_ROOT\CLSID\{#MyAppId}" -ot reg -actn setprot -op "dacl:p_c"', ExpandConstant('{app}'), SW_HIDE, ewNoWait, ResultCode);
  ResultBoolean := Exec(ExpandConstant('{app}\tools\SetACL.exe'), '-on "HKEY_CLASSES_ROOT\CLSID\{#MyAppId}" -ot reg -actn ace -ace "n:S-1-5-32-545;m:revoke;p:read"', ExpandConstant('{app}'), SW_HIDE, ewNoWait, ResultCode);
end;


procedure ActivateMultiotpCredentialProvider;
begin
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{#MyAppId}','', 'multiOTPCredentialProvider');
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Provider Filters\{#MyAppId}','', 'multiOTPCredentialProvider');
end;


procedure DeActivateMultiotpCredentialProvider;
begin
    RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{#MyAppId}');
    RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Provider Filters\{#MyAppId}');
end;


procedure TestButtonClick(Sender: TObject);
var
  ResultCode: Integer;
  Domain: string;
  UserName: string;
  UPNUserName: string;
  ErrorCode: Longint;
  PrefixPass: string;
  OTPUsername: string;

  // ResultCode: Integer;
  TmpFileName: string;
  ExecStdout: AnsiString;

begin
  
  ReadMultiotpInteractiveValue;
  WriteMultiotpRegValue;

  // multiOTP configuration
  if Not Exec(ExpandConstant('{app}\multiotp.exe'), '-cp -config server-secret='+multiOTPSharedSecret+' server-cache-level='+IntToStr(multiOTPCacheEnabled)+' server-timeout='+IntToStr(multiOTPServerTimeout)+' server-url='+multiOTPServers+'', ExpandConstant('{app}'), SW_HIDE, ewWaitUntilTerminated, ResultCode) then begin
    MsgBox(ExpandConstant('{cm:multiOTPErrorConfiguration}'), mbCriticalError, MB_OK);
    // MsgBox(SysErrorMessage(ResultCode), mbInformation, MB_OK);
    ResultCode := 99;
  end;

 
  // Get multiOTP version
  TmpFileName := ExpandConstant('{tmp}\multiotp_version.txt');
  Exec('>', 'cmd.exe /C multiotp.exe -cp -version > "' + TmpFileName + '"', ExpandConstant('{app}'), SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if (LoadStringFromFile(TmpFileName, ExecStdout)) then begin
    multiOTPversion.Caption := ExecStdout;
  end;
  DeleteFile(TmpFileName);

  testButtonResult.Caption := ExpandConstant('{cm:multiOTPPleaseWait}');
  credentialProviderState.Caption := ExpandConstant('{cm:multiOTPPleaseWait}');

  testDone := true;
  testSuccess := false;

  // testOtpdEdit can be empty now (5.3.0.3 and further)
  if ('' = testUsernameEdit.Text) Or ('' = testPasswordEdit.Text) Then Begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPUsernamePasswordOrOtpMissing}');
  end else begin
    ParseDomainUserName(testUsernameEdit.Text, Domain, UserName, UPNUserName);
    TryLogonUser(Domain, UserName, testPasswordEdit.Text, ErrorCode);
    if (1 = multiOTPPrefixPass) then begin
      PrefixPass := testPasswordEdit.Text
    end else begin
      PrefixPass := ''
    end;
    if (1 = multiOTPUPNFormat) then begin
      OTPUsername := UPNUserName
    end else begin
      OTPUsername := UserName
    end;
    if (ERROR_LOGON_FAILURE = ErrorCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPWindowsUsernameOrPasswordIncorrect}');
    end else if (ERROR_SUCCESS <> ErrorCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPWindowsLoginFailed}: ') + SysErrorMessage(DLLGetLastError);
    end else if Not Exec(ExpandConstant('{app}\multiotp.exe'), '-cp "' + OTPUsername + '" "' + PrefixPass + testOtpdEdit.Text + '"', ExpandConstant('{app}'), SW_HIDE, ewWaitUntilTerminated, ResultCode) then begin
      MsgBox(ExpandConstant('{cm:multiOTPSystemErrorDuringmultiOTPTest}') + ' ('+IntToStr(ResultCode)+')', mbCriticalError, MB_OK);
      ResultCode := 99;
    end else if (0 = ResultCode) then begin
      testSuccess := true;
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode0}');
    end else if (21 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode21}');
    end else if (24 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode24}');
    end else if (25 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode25}');
    end else if (26 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode26}');
    end else if (28 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode28}');
    end else if (30 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode30}');
    end else if (98 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode98}');
    end else if (99 = ResultCode) then begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCode99}');
    end else begin
      testButtonResult.Caption := ExpandConstant('{cm:multiOTPReturnCodePrefix}') + IntToStr(ResultCode) + ExpandConstant('{cm:multiOTPReturnCodeSuffix}');
    end;
  end;

  testOtpdEdit.Text := '';

  WizardForm.NextButton.Enabled := testDone

  if (testSuccess) then begin
    // testButton.Enabled := false;
    ActivateMultiotpCredentialProvider;
    credentialProviderState.Caption := ExpandConstant('{cm:multiOTPInstalledAndActivated}');
  end else begin
    DeActivateMultiotpCredentialProvider;
    credentialProviderState.Caption := ExpandConstant('{cm:multiOTPNotActivated}');
  end;
end;


procedure CreateTestPage;
var
  testUsernameLabel: TNewStaticText;
  testPasswordLabel: TNewStaticText;
  testOtpLabel: TNewStaticText;
  testButtonResultLabel: TNewStaticText;
  credentialProviderStateLabel: TNewStaticText;
  multiOTPversionLabel: TNewStaticText;

  pageTop: Integer;
  pageLeft: Integer;

begin

  pageTop := 0;
  pageLeft := 0;

  // Create the page
  testPage := CreateCustomPage(wpInstalling,
    ExpandConstant('{cm:multiOTPConfigurationTest}'),
    ExpandConstant('{cm:multiOTPCheckServer}'));

  testUsernameLabel := TNewStaticText.Create(testPage);
  with testUsernameLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPWindowsUsername} : ');
    Parent := testPage.Surface;
  end;

  testUsernameEdit := TEdit.Create(testPage);
  with testUsernameEdit do
  begin
    Parent := testPage.Surface;
    Left := pageLeft + testUsernameLabel.Width;
    Top := pageTop - ScaleY(2);
    Width := ScaleX(200); // testPage.SurfaceWidth - testUsernameLabel.Width;
    Text := AddBackslash(GetEnv('USERDOMAIN')) + GetUserNameString;
  end;
  pageTop := pageTop + testUsernameLabel.Height + ScaleY(8);

  testPasswordLabel := TNewStaticText.Create(testPage);
  with testPasswordLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPWindowsPassword} : ');
    Parent := testPage.Surface;
  end;

  testPasswordEdit := TEdit.Create(testPage);
  with testPasswordEdit do
  begin
    PasswordChar := '*';
    Parent := testPage.Surface;
    Left := pageLeft + testPasswordLabel.Width;
    Top := pageTop - ScaleY(2);
    Width := ScaleX(200); // testPage.SurfaceWidth - testPasswordLabel.Width;
    Text := '';
  end;
  pageTop := pageTop + testPasswordLabel.Height + ScaleY(8);

  testOtpLabel := TNewStaticText.Create(testPage);
  with testOtpLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Font.Style := [fsBold];
    Caption := ExpandConstant('{cm:multiOTPUserOTP} : ');
    Parent := testPage.Surface;
  end;

  testOtpdEdit := TEdit.Create(testPage);
  with testOtpdEdit do
  begin
    PasswordChar := '*';
    Parent := testPage.Surface;
    Left := pageLeft + testOtpLabel.Width;
    Top := pageTop - ScaleY(2);
    Width := ScaleX(200); // testPage.SurfaceWidth - testOtpLabel.Width;
    Text := '';
  end;
  pageTop := pageTop + testOtpLabel.Height + ScaleY(16);

  testButton := TNewButton.Create(testPage);
  with testButton do begin
    Top := pageTop;
    Left := pageLeft;
    Caption := ExpandConstant('{cm:multiOTPTestButton}');
    Width := testPage.SurfaceWidth - Left;
    Parent := testPage.Surface;
    OnClick := @TestButtonClick;
  end;
  pageTop := pageTop + testButton.Height + ScaleY(16);

  testButtonResultLabel := TNewStaticText.Create(testPage);
  with testButtonResultLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Caption := ExpandConstant('{cm:multiOTPTestResult} : ');
    Parent := testPage.Surface;
  end;

  testButtonResult := TNewStaticText.Create(testPage);
  with testButtonResult do
  begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft + testButtonResultLabel.Width;
    Font.Style := [fsBold];
    Caption := '...';
    Parent := testPage.Surface;
  end;
  pageTop := pageTop + testButtonResultLabel.Height + ScaleY(2);

  credentialProviderStateLabel := TNewStaticText.Create(testPage);
  with credentialProviderStateLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Caption := ExpandConstant('{cm:multiOTPCredentialProviderState} : ');
    Parent := testPage.Surface;
  end;

  credentialProviderState := TNewStaticText.Create(testPage);
  with credentialProviderState do
  begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft + credentialProviderStateLabel.Width;
    Font.Style := [fsBold];
    Caption := '...';
    Parent := testPage.Surface;
  end;
  pageTop := pageTop + credentialProviderStateLabel.Height + ScaleY(24);

  pageTop := testPage.SurfaceHeight - credentialProviderStateLabel.Height;
  multiOTPversionLabel := TNewStaticText.Create(testPage);
  with multiOTPversionLabel do begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft;
    Caption := ExpandConstant('{cm:multiOTPLibraryVersion} : ');
    Font.Style := [fsItalic];
    Parent := testPage.Surface;
  end;

  multiOTPversion := TNewStaticText.Create(testPage);
  with multiOTPversion do
  begin
    AutoSize := True;
    WordWrap := False;
    Top := pageTop;
    Left := pageLeft + multiOTPversionLabel.Width;
    Font.Style := [fsItalic,fsBold];
    Parent := testPage.Surface;
  end;

end;


procedure InitializeWizard;

begin
  // Default values
  multiOTPDefaultPrefix := '';
  multiOTPLoginTitle := 'multiOTP Login';
  multiOTPServers := 'https://192.168.1.88';
  multiOTPServerTimeout := 5;
  multiOTPSharedSecret := 'ClientServerSecret';
  multiOTPCacheEnabled := 1;
  multiotpDisableAutoReconnect := 0;
  multiOTPRDPOnly := 1;
  multiOTPTimeout := 60;
  multiOTPPrefixPass := 0;
  multiOTPDisplaySmsLink := 0;
  multiOTPUPNFormat := 0;

  // Read registry values if they exists
  RegQueryStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPDefaultPrefix', multiOTPDefaultPrefix);
  RegQueryStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPLoginTitle', multiOTPLoginTitle);
  RegQueryStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPServers', multiOTPServers);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPServerTimeout', multiOTPServerTimeout);
  RegQueryStringValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPSharedSecret', multiOTPSharedSecret);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPCacheEnabled', multiOTPCacheEnabled);
  RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services','fDisableAutoReconnect', multiotpDisableAutoReconnect);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPRDPOnly', multiOTPRDPOnly);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPTimeout', multiOTPTimeout);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPPrefixPass', multiOTPPrefixPass);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPDisplaySmsLink', multiOTPDisplaySmsLink);
  RegQueryDWordValue(HKEY_CLASSES_ROOT, 'CLSID\{#MyAppId}','multiOTPUPNFormat', multiOTPUPNFormat);

  if WizardSilent() then begin
    WriteMultiotpRegValue;
    ActivateMultiotpCredentialProvider;
  end else begin
    // credentialProviderInstalled := RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{#MyAppId}','', stringValue);
    credentialProviderInstalled := false;

    // Create two custom pages
    CreateSetupPage2of2; // Create first the second page (after wpSelectTasks)
    CreateSetupPage1of2; // Create the first page (which is now just after wpSelectTasks)

    CreateTestPage; // This page is after wpInstalling

    // Test variables initialization
    testDone := false;
    testSuccess := false;
  end;
end;


procedure CurPageChanged(CurPageID: Integer);
begin
  if (Not WizardSilent()) then begin
    if CurPageID = TestPage.ID then begin
      if (credentialProviderInstalled) then begin
        credentialProviderState.Caption := ExpandConstant('{cm:multiOTPInstalledAndActivated}');
      end else begin
        credentialProviderState.Caption := ExpandConstant('{cm:multiOTPNotActivated}');
        RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{#MyAppId}');
        RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Provider Filters\{#MyAppId}');
      end;
      WizardForm.NextButton.Enabled := testDone;
    end;
  end;
end;

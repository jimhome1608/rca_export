unit FtpSend;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, File_Utils, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdFTP1: TIdFTP;
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SendXMLToMaximumWorks( const strFilename: String;
   var outFilesSent: Integer ): Boolean;  

function SendXMLToOnTheHouse( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
function SendZipFile( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
function Ftp_SendFile( strHost, strRemoteDir, strUsername,
   strPassword, strFileName: String; var outFilesTransfered: integer ): Boolean;
function SendXMLToHomeHound( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToRentFind( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXML_realestatebookings_com( const strFilename: String; var outFilesSent: Integer ): Boolean;

function SendXMLToInspectRealEstate( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToPermitReady( const strFilename: String;
   var outFilesSent: Integer ): Boolean;   

function SendXMLACProperty( const strFilename: String;
      var outFilesSent: Integer ): Boolean;
function SendHomely( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToHomeSales( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToActivePipe( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToExcel( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToProEstate( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToRateMyAgent( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToMillionPus( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToRentDotCom( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendXMLToRentBuy( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
function SendXMLToFletchers( const strFilename: String;
   var outFilesSent: Integer ): Boolean;

function SendNickThorn( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
   


var
  Form1: TForm1;
  bFtpReady: Boolean;

implementation
uses main;

{$R *.DFM}

function SendListOnce( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     result:= false;
     outFilesSent := 0;
     strHost := '172.16.97.9';
     strUserName := 'administrator';
     strPassword := '*****************!';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;

function SendNickThorn( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     SendListOnce(strFilename,   outFilesSent);
     if (Now > EncodeDate(2020, 10, 3)) then
       exit;
     result:= false;
     outFilesSent := 0;
     strHost := '103.223.138.4';  
     strUserName := 'xml_multilink';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;



function SendXMLToMaximumWorks( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'ftp.maximumworks.com';//'173.254.28.15';// feeds ftp.maximumworks.com

     strUserName := 'erer1740';//'elite@maximumworks.com';
     strPassword := '*****************';
     strRemoteDir := 'multilink';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendZipFile( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'reaxml.realestate.com.au'; //changed again was ->'202.58.52.12';// had to change lost DNS on server ?? strUserName := 'multilink';
     ` '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     else
          raise Exception.Create( 'ftp send failed.' );
end;




function SendHomely( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin

     outFilesSent := 0;
     strHost := 'ftp.homely.com.au';
     strUserName := 'MultiLink';
     strPassword := 'a*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendXMLACProperty( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'ftp.drivehq.com';
     strUserName := 'multilink';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendXMLToRentFind( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin

     result:= false;
     outFilesSent := 0;
     strHost := '172.16.97.9';
     strUserName := 'administrator';
     strPassword := '*****************';
     strRemoteDir := '';

     
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;

function SendXML_realestatebookings_com( const strFilename: String; var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     result:= false;
     outFilesSent := 0;
     strHost := '172.16.97.9';
     strUserName := 'administrator';
     strPassword := '*****************!';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     
end;


function SendXMLToPermitReady( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
     (*
     Host: 45.32.246.51
     User: ftp_xml
     Pass: 5{%ZjbR&.4|(&k7
    *)
begin
     result:= false;
     outFilesSent := 0;
     strHost := '45.32.246.51';

     strUserName := 'ftp_xml';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;


function SendXMLToInspectRealEstate( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     result:= false;
     outFilesSent := 0;
     strHost := 'ftp.inspectrealestate.com.au';

     strUserName := 'xmlfeed';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;




function SendXMLToHomeSales( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'feeds.homesales.com.au';

     strUserName := 'multilink';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;



function SendXMLToProEstate( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;

     strHost := 'ftp.progroup.com.au';
     strUserName := 'multilink@progroup.com.au';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendXMLToActivePipe( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'warehouse.activepipe.com';//'173.254.28.15';// feeds ftp.maximumworks.com

     strUserName := 'multilink.warehouse';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendXMLToRateMyAgent( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'propertydata.ratemyagent.com.au';//'173.254.28.15';// feeds ftp.maximumworks.com

     strUserName := 'multilink';
     strPassword := 'l*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendXMLToExcel( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
// Host: ftp.excelaustralasia.com.au
// Username: multilink
// Password: mlink
     outFilesSent := 0;
     strHost := 'ftp.excelaustralasia.com.au';
     strUserName := 'multilink';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;



function SendXMLToHomeHound( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     exit;
     outFilesSent := 0;
     strHost := 'ftp.homehound.com.au';
     strUserName := 'mtl';
     strPassword := '*****************';
     strRemoteDir := '*****************';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;

function SendXMLToFletchers( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'fletchers.net.au';
     strUserName := '*****************';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
end;


function SendXMLToRentBuy( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     //strHost := '116.240.195.204';// xml.millionplus.com.au  was 203.94.160.82 changed to 116.240.195.204
     strHost := '101.0.106.210';
     strUserName := 'Multilink';
     strPassword := 'O*****************';
     strRemoteDir := 'files';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;



function SendXMLToOnTheHouse( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     //strHost := '116.240.195.204';
     strHost := 'ftp1.onthehouse.com.au';
     strUserName := 'multilink';
     strPassword := '*****************g';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;


function SendXMLToMillionPus( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := '184.169.154.249';
     strUserName := 'multilink';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
     //     raise Exception.Create( 'ftp send failed.' );
end;

function SendXMLToRentDotCom( const strFilename: String;
   var outFilesSent: Integer ): Boolean;
var
     bResult: Boolean;
     strHost, strRemoteDir, strUsername, strPassword: String;
     nFilesTransfered: Integer;
begin
     outFilesSent := 0;
     strHost := 'feeds-ftp.rent.com.au';// WAS'203.23.213.165'; //Server: ftp.rent.com.au  203.23.213.165
     strUserName := '13bc23ba';// 'muk4ftp';
     strPassword := '*****************';
     strRemoteDir := '';
     bResult := Ftp_SendFile( strHost, strRemoteDir,
        strUsername, strPassword, strFilename, nFilesTransfered );
     if( bResult = True ) and ( nFilesTransfered > 0 ) then
     begin
          Result := True;
          outFilesSent := nFilesTransfered;
     end
     //else
    //      raise Exception.Create( 'ftp send failed.' );
end;




function Ftp_SendFile( strHost, strRemoteDir, strUsername,
   strPassword, strFileName: String; var outFilesTransfered: integer ): Boolean;
var
     strDestFilename: String;
begin
     Result := False;
     with Form1.IdFTP1 do
     try
          outFilesTransfered := 0;
          Host := strHost;
          UserName := strUsername;
          Password := strPassword;

          bFtpReady := False;
          Connect;
          while( bFtpReady = False ) do
             Application.ProcessMessages;

          if( Length( strRemoteDir ) > 0 ) then
             ChangeDir( strRemoteDir );

          strDestFilename := ExtractFileName( strFilename );
          Put( strFileName, strDestFilename );
          Quit;
          Result := True;
          outFilesTransfered := 1;
     except
       on E: Exception do begin
         Log(strHost+' -> '+e.Message);

       end;
     end;
end;

procedure TForm1.IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
     if( AStatus = ftpReady ) then
         bFtpReady := True;
end;

end.

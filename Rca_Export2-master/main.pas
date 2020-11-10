unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, DBGrids, Db, DBTables, Export_SQL, File_Utils,
  Export_Text, Str_Utils, Image_Utils, VCLUnZip, VCLZip, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, IdEMailAddress, FtpSend, Variants, classPropLastChanged,
  Contnrs, ClassRealEstateDotComFeatures, MemDS, DBAccess, MSAccess, clipBrd;

type

  TRentDotComList = class(TstringList)
  public
     Office_id: integer;
  end;

  TRentDotComListOfLists =  class(TObjectlist)
     procedure AddItem(_Office_id: integer; s: string);
     function getItem(_idx: integer):  TRentDotComList;
  end;

  TfrmMain = class(TForm)
    Timer1: TTimer;
    memLog: TMemo;
    zipText: TVCLZip;
    Memo1: TMemo;
    zipPics: TVCLZip;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    conMultilinkDotCom: TMSConnection;
    qryProp: TMSQuery;
    qryPropDetail: TMSQuery;
    qryExport: TMSQuery;
    qryInsert: TMSQuery;
    qryUpdate: TMSQuery;
    qryDelete: TMSQuery;
    qryPropSold: TMSQuery;
    qryTranslatedAgentId: TMSQuery;
    qryUsers: TMSQuery;
    qryPropOFI: TMSQuery;
    qryPropDistCategory: TMSQuery;
    qryPropImage: TMSQuery;
    qryPropImageFile: TMSQuery;
    qryPropWebLinks: TMSQuery;
    qryWorker: TMSQuery;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    testMode: boolean;
    debugMode: boolean;

  public
    ExportFile: TStringList;
    ExportRateMyAgent: TStringList;
    ExportActivePipe: TStringList;
    ExportProEstate: TStringList;
    ExportExcel: TStringList;
    ExportProEstateCount: integer;
    ExportExcelCount: integer;
    Exportrentbuy: TStringList;
    ExportFletchers: TStringList;
    ExportOnTheHouse: TStringList;
    ExportRentFind: TStringList;
    ExportACProperty: TStringList;
    ExportFileHomeHound: TStringList;
    ExportMillionPlus: TStringList;
    ExportHomeSales: TStringList;
    ExportInspectRealEstate: TStringList;
    ExportPermitReady: TStringList;
    ExportRealEstateBookings: TStringList;
    ExportNickThorn: TStringList;

    ExportRentFindCount: integer;
    ExportACPropertyCount: integer;
    ExportHomeHoundCount: integer;
    ExportOnTheHouseCount: integer;
    ExportFletchersCount: integer;
    ExportrentbuyCount: integer;
    ExportActivePipeCount: integer;
    ExportRateMyAgentCount: integer;
    ExportHomeSalesCount:integer;
    ExportInspectRealEstateCount: integer;
    ExportPermitReadyCount: integer;
    ExportRealEstateBookingsCount: integer;
    ExportNickThornCount: integer;





    MillionPlusCount: integer;
    RentDotComListOfLists: TRentDotComListOfLists;
    RealEstateDotComFeatureList: TRealEstateDotComFeatureList;
    function OKforRentDotCom(_office_id, _id: integer; var _TRANSLATED_ID: string): boolean;
  end;

TUserDetails = record
   strAgentName, strAgentPhoneBH, strAgentMobile, strAgentEmail:
      String;
end;

procedure ControlCenter( var outError: Integer );
procedure Log( strLog: String );
procedure ClearWorkDir;
procedure CreateExportFiles( var outRecords: Integer );
function AddXMLToFile( const Id, OfficeId: Integer; _UNIQUE_REA_ID: string;  AddToFiles: boolean): string;
function AddWithdrawnXMLToFile(const Id, OfficeId: Integer;const strListingType: string; _UNIQUE_REA_ID: string;  AddToFiles: boolean) : string;
procedure CheckPropSold( const Id, OfficeId: Integer;
   var outSold, outValid: Boolean );
function GetTranslatedAgentId( const nOfficeId: Integer ): String;

procedure ExportTable_InsertUpdate;
procedure ExportTable_Delete;
procedure ExportTable_Insert(  const Id, OfficeId: Integer;
   const LastChanged: TDateTime;
   const strListingType: String; _UNIQUE_REA_ID: string );
procedure ExportTable_Update(const Id, OfficeId: Integer;
   const LastChanged: TDateTime;
   const strListingType: String);
procedure ExportTable_DeleteProp( const Id, OfficeId: Integer );

function SavePhoto( Id, OfficeId, PhotoNum, Image_File_Id: Integer; Photo: TBlobField;
   var outFilename: String ): Boolean;
function SavePlan( Id, OfficeId, PhotoNum, Image_File_Id: Integer; Photo: TBlobField;
   var outFilename: String ): Boolean;
function CreateZipFile: String;
function MoveZipFile( strFilename: String ): String;

procedure OpenQueries;
procedure CloseQueries;

procedure GetUser( const nOfficeId, nUserId: Integer;
   var outUserDetails: TUserDetails; var outResult: Boolean );

procedure GetPropTypes( const Id, OfficeId: Integer; var outPropType_Array:
   Array of string; var outResult: Boolean );
function Process_Images( const nId, nOfficeId: Integer ): String;
procedure Process_Image( const nImageId, nId, nOfficeId, nImageOrder: Integer;
   var outFilename: String; var outResult: Boolean );
function Get_Rca_Image_Id( const nImageIndex: Integer ): String;
function Process_Plans( const nId, nOfficeId: Integer ): String;
procedure Process_Plan( const nImageId, nId, nOfficeId, nImageOrder: Integer;
   const strOriginalFilename: String; var outFilename: String;
   var outResult: Boolean );
function Process_Virtual_Tours( const nId, nOfficeId: Integer ): String;
function get_VIDEO_ON_REA( const nId, nOfficeId: Integer ): String;
function get_StatementOfInformation( const nId, nOfficeId: Integer ): String;


function OKforHomeHound(_office_id: integer): boolean;
function OKforHomeSales(_office_id: integer): boolean;
function OKforInspectRealEstate(_office_id: integer): boolean;
function OKforPermitReady(_office_id: integer; _ListingType: String): boolean;
function OKforRealEstateBookings(_office_id: integer; _ListingType: String): boolean;
function OKforNickThorn(_office_id: integer; _ListingType: String): boolean;
function OKforRateMyAgent(_office_id: integer): boolean;
function OKforActivePipe(_office_id: integer): boolean;
function OKforProEstate(_office_id: integer): boolean;
function OKforExcel(_office_id: integer): boolean;
function OKforOnTheHouse(_office_id: integer): boolean;
function OKforRentBuy(_office_id: integer): boolean;
function OKforFletchers(_office_id: integer): boolean;
function OKforRentFind(_office_id: integer): boolean;
function AgentIDForHomeSales(_office_id: integer): string;
function AgentIDForInspectRealEstate(_office_id: integer): string;
function AgentIDForRealEstateBookings(_office_id: integer): string;
function AgentIDForOnTheHouse(_office_id: integer): string;
function AgentIDForRentBuy(_office_id: integer): string;
function AgentIDForFletchers(_office_id: integer): string;
function AgentIDForRentFind(_office_id: integer): string;
function AgentIDACProperty(_office_id: integer): string;
function OKforMillionPlus(_office_id: integer): boolean;


const

     DUMMY_REA_CODE_NOT_TO_BE_SENT = 'XXXX';

     WEB_LINK_TYPE_VIDEO_ON_REA          = 'VIDEO ON REA';

     ENRICH_PROPERTY_GROUP = 2044;
     TRIPLE_EIGHT =          2043;
     IVY_REALESTATE =      2049;
     ELITE_REALESTATE =      2021;


     (*  Noel Jones Offices
      91	Noel Jones Camberwell Pty Ltd	883 Toorak Road
      92	Noel Jones (Camberwell) P/L Rentals	883 Toorak Road
      95	Noel Jones (Balwyn) Pty Ltd	289 Whitehorse Road
      2051	Noel Jones (Glen Iris)	58 High Street
      *)


     DEVELOPMENT_OFFICE = 2071;

     NJ_CAMBERWELL_RENT =  92;
     NJ_CAMBERWELL_SALES = 91;
     NOEL_J0NES_BALWYN = 95;
     NOEL_JONES_GLEN_IRS =  2051;

     NJ_BOXHILL =          222;

     FLETCHERS_GLEN_IRIS = 93;

     PRO_ESTATE = 2048;
     JY_PROPERTY = 259;

     IVY_DOCKLANDS = 2053;
     IVY_SPENSER =   2054;


     WORK_DRIVE = 'C';
     DIST_ID = 6;
     DIST_ID_RENTDOTCOM = 30;


     WorkDir = WORK_DRIVE   + ':\InetPub\rca_export_xml\work_dir\';
     ExportDir = WORK_DRIVE + ':\InetPub\rca_export_xml\';

     IniDir = WorkDir + 'text\';
     ExportRentDotComDir = WorkDir + 'RentDotCom\';

     IMAGES_DIR = WorkDir + 'images\';
     IMAGES_PUBLIC_URL = 'http://www.multilink.com.au/rca_xml_images/%s';

     MULTILINK_USERNAME = 'multilink';
     MULTILINK_PASSWORD = 'squ1gg1e';
     FILENAME_TIMESTAMP_FORMAT = 'yyyy-mm-dd_hh_nn_ss';
     TIMESTAMP_FORMAT = 'yyyy-mm-dd-hh:nn:ss';
     DATE_FORMAT = 'yyyy-mm-dd';
     TIME_FORMAT = 'hh:nn';//'hh:nn:ss';

     SMTP_HOST = 'smtphost';

     ACTION_CREATE = 1;
     ACTION_UPDATE = 2;
     ACTION_SOLD = 3;
     ACTION_WITHDRAWN = 4;

     METHOD_AUCTION = 'Auction';
     METHOD_RENT = 'Rent';
     METHOD_BOTH = 'Both';
     METHOD_PRIVATE = 'Private';
     METHOD_EXCLUSIVE = 'Exclusive';

     COMMERCIAL_LISTING_TYPE_SALE = 'sale';
     COMMERCIAL_LISTING_TYPE_LEASE = 'lease';

     PROPERTY_STATES_SOLD = 2;

     LAND_AREA_UNITS = 'sqm';
     RENT_PERIOD = 'pw';

     MLS_PROP_TYPE_HOUSE  = 'House';
     MLS_PROP_TYPE_UNIT = 'Unit';
     MLS_PROP_TYPE_APARTMENT = 'Apartment';
     MLS_PROP_TYPE_WAREHOUSE_SHELL = 'Warehouse Shell';
     MLS_PROP_TYPE_TOWNHOUSE = 'Townhouse';
     MLS_PROP_TYPE_LAND = 'Land';
     MLS_PROP_TYPE_COMMERCIAL = 'Comm/Ind/Retail';
     MLS_PROP_TYPE_BUSINESS = 'business';

     RCA_PROP_TYPE_HOUSE  = 'House';
     RCA_PROP_TYPE_UNIT = 'Unit';
     RCA_PROP_TYPE_APARTEMENT = 'Apartment';
     RCA_PROP_TYPE_TOWNHOUSE = 'Townhouse';
     RCA_PROP_TYPE_LAND = 'Land';


     MAX_NUM_PHOTOS = 26;
     MAX_NUM_PLANS = 2;
     MAX_NUM_VIRTUAL_TOURS = 2;
     MIN_PHOTO_SIZE = 1000;

     EXPORT_AUTHORITY_AUCTION = 'auction';
     // changed default to open to avoid the "Sale by Negotiaion" text that goes with sale. EXPORT_AUTHORITY_SALE = 'sale';
     EXPORT_AUTHORITY_SALE = 'open';
     EXPORT_AUTHORITY_EXCLUSIVE = 'exclusive';

     STATUS_CURRENT = 'current';
     STATUS_SOLD = 'sold';
     STATUS_LEASED = 'leased';
     STATUS_WITHDRAWN = 'withdrawn';

     LISTING_TYPE_RESIDENTIAL = 'residential';
     LISTING_TYPE_RENTAL =      'rental';
     LISTING_TYPE_LAND =        'land';
     LISTING_TYPE_COMMERCIAL =  'commercial';
     LISTING_TYPE_BUSINESS =    'business';

     HEATING_GAS = 'gas';
     HEATING_ELECTRIC = 'electric';
     HEATING_GDH = 'GDH';
     HEATING_SOLID = 'solid';
     HEATING_OTHER = 'other';

     EXTERNAL_LINK_NORMAL = 'VirtualTour';

     HWS_GAS = 'gas';
     HWS_ELECTRIC = 'electric';
     HWS_SOLAR = 'solar';

     ADDRESS_DISPLAY_YES = 'yes';
     ADDRESS_DISPLAY_NO  = 'no';

     JPEG_EXTENSION = '.jpg';

     MAX_PROPERTY_TYPES = 3;

     ALPHA_BASE = 97;

     SEND_FLAG_FILE =
        '\if_this_file_is_here_do_not_send.txt';

     CATEGORY_PHOTOGRAPH  = 'Photograph';
     CATEGORY_FLOORPLAN   = 'Floorplan';
     CATEGORY_OTHER       = 'Other';

     RESOLUTION_HIRES     = 'Hi-Res';
     RESOLUTION_WEB       = 'Web';
     RESOLUTION_THUMBNAIL = 'Thumbnail';

     WEB_LINK_TYPE_VIRTUAL_TOUR          = 'Virtual_Tour';
     WEB_LINK_TYPE_INTERACTIVE_FLOORPLAN = 'Interactive_Floorplan';
     WEB_LINK_TYPE_OTHER                 = 'Other';
var
  frmMain: TfrmMain;
  strFilename: String;
  FilenameACProperty: string;
  FilenameRentFind: string;
  FileNameHomeSales: string;
  FileNameInspectRealEstate: string;
  FileNamePermitReady: string;
  FileNameRealEstateBookings: string;
  FileNameNickThorn: string;
  FileNameRateMyAgent: string;
  FileNameActivePipe: string;
  FileNameProEstate: string;
  FileNameExcel: string;
  FileNameOnTheHouse: string;
  FileNameRentBuy: string;
  FileNameFletchers: string;
  FilenameHomeHound: String;
  FilenameMillionPlus: String;
  FileNameDigitalMotorWorks: string;

implementation

{$R *.DFM}



function OKforMillionPlus(_office_id: integer): boolean;
//92,91,93, 222, 110, 95, 106, 223, 104,
begin
   Result:= True;         //THIS GOES TO HOMEPAGE.COM.AU TOO IF LESS THAN 1 MILLION.
   if  _office_id = 90 then exit;  //Noel Jones (Caulfield
   if  _office_id = 91 then exit;  //Noel Jones (Camberwell)
   if  _office_id = 92 then exit;  //Noel Jones (Camberwell) P/L Rentals
   if  _office_id = 95 then exit;  //Noel Jones (Balwyn)
   if  _office_id = 104 then exit;   //Noel Jones Blackburn
   if  _office_id = 222 then exit;  //Noel Box Hill
   if  _office_id = 223 then exit;  //Noel Jones Real Estate (Berwick)
   if  _office_id = JY_PROPERTY then exit;  //Noel Jones Real Estate (Glen Waverley)
   if  _office_id = 2006 then exit;   //Head Office
   Result:= False;
end;




function OKforHomeHound(_office_id: integer): boolean;
begin
   Result:= True;
    if  _office_id = 1   then 	  //Real Estate Gallery
      exit;
    if  _office_id = 90	 then  //Noel Jones Caulfield
      exit;
    if  _office_id = 91	 then  //Noel Jones - Camberwell
      exit;
    if  _office_id = 95	 then  //Noel Jones Balwyn
      exit;
    if  _office_id = 104 then 	  //Noel Jones Blackburn
      exit;
    if  _office_id = 110 then 	  //Noel Jones - Kew
      exit;
    if  _office_id = 222 then 	  //Noel Jones Box Hill
      exit;
    if  _office_id = 223	then   //Noel Jones Berwick
      exit;
    if  _office_id = JY_PROPERTY	then   //Noel Jones Glen Waverley
      exit;
    if  _office_id = ELITE_REALESTATE	then
      exit;
    if  _office_id = 2011	then //Moe John Kerr
      exit;
    if  _office_id = 2032 	then //Trafalgar John Kerr
      exit;
    if  _office_id = 2043 	then //TripleEight Real Estate
      exit;
   Result:= False;

End;

function OKforRentFind(_office_id: integer): boolean;
begin
   Result:= True;
   if  _office_id = ELITE_REALESTATE then exit;
   if  _office_id = 92 then exit;	  //Noel Jones- Camberwell Rent
   if  _office_id = 222 then exit;	//Noel Jones-  Box Hill
   if  _office_id = 95 then exit;	  //Noel Jones-  Balwyn
   if  _office_id = 104 then exit;	  //Noel Jones-  BlackBurn
   if  _office_id =  NOEL_JONES_GLEN_IRS     then exit;
   Result:= False;
end;


function OKforACProperty(_office_id: integer): boolean;
begin
   // Result:= True;
   // if  _office_id = JY_PROPERTY then exit;  //they are not using anymore but Ivy might want to in the future.
   Result:= False;
end;



function AgentIDACProperty(_office_id: integer): string;
begin
  result:= '';
  if  _office_id = JY_PROPERTY then Result:= 'njones_gw';
  if  _office_id = IVY_REALESTATE then Result:= 'IvyRE';   //Ivy Real Estate
end;

function AgentIDForRentFind(_office_id: integer): string;
begin
  result:= '';
  if  _office_id = ELITE_REALESTATE then Result:= '11961';
  if  _office_id = 92 then Result:= '10691';	  //Noel Jones- Camberwell Rent
  if  _office_id = 222 then Result:= '10783';	//Noel Jones- Box Hill
  if  _office_id = 95 then Result:= '10784';	  //Noel Jones- Balwyn
  if  _office_id = 104 then Result:= '10916';	  //Noel Jones-  BlackBurn
  if  _office_id =  NOEL_JONES_GLEN_IRS   then Result:= '14350';
end;


function OKforActivePipe(_office_id: integer): boolean;
begin
   Result:= True;         // all Noel Jones
   if  _office_id = 104 then  exit;//BLACKBURN
   if  _office_id = 95  then  exit;//Balwyn
   if  _office_id = 223 then  exit;//Berwick
   if  _office_id = 222 then  exit;//Box Hill
   if  _office_id = 91 then  exit;//Camberwell Sales
   if  _office_id = 92 then  exit;//Camberwell Rent
   if  _office_id = 90 then  exit;//Caulfield
   if  _office_id = JY_PROPERTY then  exit;//Glen Waverley
   Result:= False;
end;

function OKforProEstate(_office_id: integer): boolean;
begin
   Result:= True;         // all Noel Jones
   if  _office_id = 2048 then  exit;//ProEstate
   Result:= False;
end;

function OKforExcel(_office_id: integer): boolean;
begin
   Result:= True;
   if  _office_id = 2002 then  exit;//First national
   Result:= False;
end;





function OKforRateMyAgent(_office_id: integer): boolean;
begin
   Result:= True;         // all Noel Jones
   if  _office_id = 95  then  exit;//Balwyn
//   if  _office_id = 222 then  exit;//Box Hill
//   if  _office_id = 91 then  exit;//Camberwell Sales
   if  _office_id = 92 then  exit;//Camberwell Rent
   if  _office_id = NOEL_JONES_GLEN_IRS then exit;
   if  _office_id = JY_PROPERTY then  exit;//Glen Waverley
   Result:= False;
end;

function OKforOnTheHouse(_office_id: integer): boolean;
begin
   Result:= True;         // all Noel Jones
   if  _office_id = 223 then  exit;//Berwick
   Result:= False;
end;



function OKforFletchers(_office_id: integer): boolean;
begin
   Result:= True;         // all Noel Jones
   if  _office_id = FLETCHERS_GLEN_IRIS then  exit;//2044 Enrich Property Group
   Result:= False;
end;


function OKforRentBuy(_office_id: integer): boolean;
begin
   Result := False;
   exit;
   //Enrich not with us any more and the FTP conneciton is broken
   Result:= True;         // all Noel Jones
   if  _office_id = 2044 then  exit;//2044 Enrich Property Group
   Result:= False;
end;

function OKforHomeSales(_office_id: integer): boolean;
begin
   Result:= True;
   if  _office_id = 2011 then exit;	  //Moe John Kerr
   if  _office_id =  2032 then exit;	  //Trafalgar John Kerr
   if  _office_id = 104 then exit;	  //Noel Jones Blackburn
   if  _office_id = ELITE_REALESTATE  then exit;
   if  _office_id = NJ_CAMBERWELL_SALES then exit;
   if  _office_id = NJ_CAMBERWELL_RENT then exit;

   Result:= False;
end;

function AgentIDForInspectRealEstate(_office_id: integer): string;
begin
  result:= '';
  if  _office_id =  FLETCHERS_GLEN_IRIS then Result:= 'ML-FLETCHGI';
  if  _office_id =  ELITE_REALESTATE then Result:=  'ML-ELITEMELBOURNE';
  if  _office_id =  NOEL_J0NES_BALWYN then Result:=  'ML-NJBAL';
end;



function OKforInspectRealEstate(_office_id: integer): boolean;
begin
   Result:= True;
   if  _office_id = FLETCHERS_GLEN_IRIS then   exit;
   if  _office_id = ELITE_REALESTATE then exit;
   if  _office_id = NOEL_J0NES_BALWYN then exit;
   Result:= False;
End;

function OKforNickThorn(_office_id: integer; _ListingType: String): boolean;
begin
   Result:= true;
   // if  _office_id = DEVELOPMENT_OFFICE then exit;
   // if  _office_id = NJ_CAMBERWELL_RENT then exit;
   // if  _office_id = NJ_CAMBERWELL_SALES then exit;
   // if  _office_id = NOEL_JONES_GLEN_IRS then exit;
   if  (_office_id = NOEL_J0NES_BALWYN) and SameText(_ListingType,'rental') then exit;
   Result:= False;
End;



function OKforPermitReady(_office_id: integer; _ListingType: String): boolean;
begin
   Result:= False;
   if  _ListingType = 'rental' then  exit; // sales only
   Result:= True;
   if  _office_id = NJ_BOXHILL then   exit;
   Result:= False;
End;


function OKforRealEstateBookings(_office_id: integer; _ListingType: String): boolean;
begin
   Result:= True;
  // clipBoard.asText:=  _ListingType;
   if  _office_id = NOEL_JONES_GLEN_IRS 	then exit;
   if  _office_id = NJ_BOXHILL 	then exit;
   if  _office_id = NJ_CAMBERWELL_RENT 	then exit;
   if  _office_id = NJ_CAMBERWELL_SALES 	then exit;
   if  _office_id = NOEL_J0NES_BALWYN 	then  begin   // only rent not sales
      if  _ListingType = 'rental' then  exit;
   end;
   Result:= False;
End;




function AgentIDForHomeSales(_office_id: integer): string;
begin
  result:= '';
  if  _office_id =  2032 then Result:= 'multi3824johnkerr';	  //Trafalgar John Kerr
  if  _office_id = 2011 then Result:= 'multi3825';	  //Moe John Kerr
  if  _office_id = 104 then Result:=  'multi3130njb';	  //Noel Jones Blackburn
  if  _office_id = ELITE_REALESTATE then Result:=  'multi3000';	  // Elite Real Estate
  if  _office_id = NJ_CAMBERWELL_SALES then Result:=  'multi3124njc38310';	  // Agent Name: Noel Jones Camberwell  Agent ID: multi3124njc38310
end;

function AgentIDForRealEstateBookings(_office_id: integer): string;
begin
  result:= '';
  if  _office_id =  NOEL_JONES_GLEN_IRS then Result:=  'NJG-001';
  if  _office_id =  NJ_CAMBERWELL_RENT then Result:=  'NJC-001';
  if  _office_id =  NJ_CAMBERWELL_SALES then Result:= 'NJC-001';
  if  _office_id =  NOEL_J0NES_BALWYN then Result:=   'NJC-002';
  if  _office_id =  NJ_BOXHILL then Result:=   'NJB-010';
end;




function AgentIDForRateMyAgent(_office_id: integer): string;
begin
  result:= intToStr(_office_id);
end;


function AgentIDForOnTheHouse(_office_id: integer): string;
begin
   result:= '';
   if  _office_id = 223 then  result:= '423464';
end;


function AgentIDForFletchers(_office_id: integer): string;
begin
   result:= '';
   if  _office_id = FLETCHERS_GLEN_IRIS then  result:= 'FLETCHERS_GLEN_IRIS';    //2044 Enrich Property Group
end;


function AgentIDForRentBuy(_office_id: integer): string;
begin
   result:= '';
   if  _office_id = 2044 then  result:= '999888139';    //2044 Enrich Property Group
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
     nError: Integer;
begin
     try
            Timer1.Enabled := False;
            ControlCenter( nError );
            if testMode then
               messageDlg('Finished. Application will now close',mtInformation,[mbOk],0);
     finally
            Halt( nError );
     end;
end;

procedure ControlCenter( var outError: Integer );
var
   nRecords, nFilesSent, nHomeHoundFilesSet, _HomeSalesFilesSent, _InspectRealEstateFilesSent, _RentFindFilesSent, _RealEstateBookingsFilesSent, _PermitReadyFilesSent,
   _NickThornFilesSent, 
   _ACpropertyFilesSent,  _RateMyAgentFilesSent, _ActivePipeFilesSent,
   _ProEstateFilesSent, _ExcelFilesSent, _OnTheHouseFilesSent, _RentBuyFilesSent, _FletchersFilesSent, i: Integer;
   t: TDatetime;
   strZipFilename, strNewZipFilename: String;
   _rentDotComFileName: string;
   _RentDotComList: TRentDotComList;
   _RentDotCount: integer;
   _sendResult: boolean;
begin
     outError := 0;
     Application.ProcessMessages;
     try
           with frmMain do
           begin
                ExportHomeSalesCount:= 0;
                ExportInspectRealEstateCount:= 0;
                ExportPermitReadyCount := 0;
                ExportRealEstateBookingsCount:= 0;
                ExportNickThornCount := 0;
                ExportRateMyAgentCount:= 0;
                ExportActivePipeCount:= 0;
                ExportProEstateCount:= 0;
                ExportExcelCount:= 0;
                ExportOnTheHouseCount:= 0;
                ExportRentBuyCount:= 0;
                ExportFletchersCount:= 0;
                ExportRentFindCount:= 0;
                ExportACPropertyCount:= 0;
                ExportHomeHoundCount:= 0;
                MillionPlusCount:= 0;
                Log( 'Distributor Export v' + GetAppVersion );
                Log( 'Start' );
                Log( 'Processing Distributor No: ' + IntToStr( DIST_ID ) );
                t := Now;

                ClearWorkDir;
                OpenQueries;
                CreateExportFiles( nRecords );
                 (*
                if RentDotComListOfLists.Count > 0 then
                   for i:= 0 to  RentDotComListOfLists.Count - 1 do begin
                      _RentDotComList:=  RentDotComListOfLists.getItem(i);
                      if _RentDotComList <> Nil then begin
                        _RentDotComList.Add( EXPORT_FOOTER );
                        _rentDotComFileName:=  Format('ml_rental_%s_%d.XML',[FormatDateTime( FILENAME_TIMESTAMP_FORMAT, Now ),_RentDotComList.Office_id] );
                        _rentDotComFileName:=  ExportRentDotComDir + _rentDotComFileName;
                        _RentDotComList.SaveToFile(_rentDotComFileName  );
                        // SendXMLToRentDotCom(_rentDotComFileName,_RentDotCount);
                      end;
                   end;
                 *)
                if( nRecords > 0 ) then
                begin
                     strZipFilename := CreateZipFile;
                     strNewZipFilename := MoveZipFile( strZipFilename );
                     if not testMode then  begin
                         if( FileExists( ProgramPath + SEND_FLAG_FILE ) = False ) then begin
                             try
                               SendZipFile( strNewZipFilename, nFilesSent );
                               if ExportACpropertyCount > 0 then
                                  SendXMLACProperty(FilenameACproperty,_ACpropertyFilesSent);
                               if ExportRentFindCount > 0 then
                                  SendXMLToRentFind(FilenameRentFind,_RentFindFilesSent);
                               if ExportHomeSalesCount > 0 then
                                   SendXMLToHomeSales(FilenameHomeSales,_HomeSalesFilesSent);

                               if ExportPermitReadyCount > 0 then
                                  SendXMLToPermitReady(FileNamePermitReady,_PermitReadyFilesSent);

                               if ExportInspectRealEstateCount > 0 then
                                   SendXMLToInspectRealEstate(FileNameInspectRealEstate,_InspectRealEstateFilesSent);

                               if ExportRealEstateBookingsCount > 0 then
                                   SendXML_realestatebookings_com(FileNameRealEstateBookings,_RealEstateBookingsFilesSent);
                               if ExportNickThornCount > 0 then begin
                                   Log('sendNickThorn ->'+  FileNameNickThorn);
                                   _sendResult:=sendNickThorn(FileNameNickThorn,_NickThornFilesSent);
                                   if  _sendResult then
                                      Log('sendNickThorn ->'+  FileNameNickThorn+ '  SUCCESS')
                                   else
                                      Log('sendNickThorn ->'+  FileNameNickThorn+ '  FAILED')
                               end;

                               if ExportOnTheHouseCount > 0 then
                                   SendXMLToOnTheHouse(FilenameOnTheHouse,_OnTheHouseFilesSent);
                               if ExportFletchersCount > 0 then
                                   SendXMLToFletchers(FilenameFletchers,_FletchersFilesSent);
                               if ExportRentBuyCount > 0 then
                                   SendXMLToRentBuy(FilenameRentBuy,_RentBuyFilesSent);
                               if ExportRateMyAgentCount > 0 then
                                   SendXMLToRateMyAgent(FilenameRateMyAgent,_RateMyAgentFilesSent);
                               if ExportActivePipeCount > 0 then
                                   SendXMLToActivePipe(FilenameActivePipe,_ActivePipeFilesSent);
                               if ExportProEstateCount > 0 then
                                   SendXMLToProEstate(FilenameProEstate,_ProEstateFilesSent);
                               if ExportExcelCount > 0 then
                                   SendXMLToExcel(FilenameExcel,_ExcelFilesSent);
                               if debugMode then
                                  showMessage(Format('Debug Mode: _HomeSalesFilesSent: %d',[_HomeSalesFilesSent]));
                               if ExportHomeHoundCount > 0 then
                                  SendXMLToHomeHound(FilenameHomeHound,nHomeHoundFilesSet);
                               if debugMode then
                                  showMessage(Format('Debug Mode: SendXMLToMillionPus: %d',[MillionPlusCount]));
                               if  MillionPlusCount > 0 then
                                  SendXMLToMillionPus(FilenameMillionPlus,MillionPlusCount);
                              if debugMode then
                                  showMessage(Format('Debug Mode: RentDotComListOfLists: %d',[RentDotComListOfLists.Count]));

                               if RentDotComListOfLists.Count > 0 then
                                 for i:= 0 to  RentDotComListOfLists.Count - 1 do begin
                                    _RentDotComList:=  RentDotComListOfLists.getItem(i);
                                    if _RentDotComList <> Nil then begin
                                      _RentDotComList.Add( EXPORT_FOOTER );
                                      _rentDotComFileName:=  Format('ml_rental_%s_%d.XML',[FormatDateTime( FILENAME_TIMESTAMP_FORMAT, Now ),_RentDotComList.Office_id] );
                                      _rentDotComFileName:=  ExportRentDotComDir + _rentDotComFileName;
                                      _RentDotComList.SaveToFile(_rentDotComFileName  );
                                      SendXMLToRentDotCom(_rentDotComFileName,_RentDotCount);
                                    end;
                                 end;
                             except //not worthing breaking the upload if problem with one of these guys
                             end;
                         end;
                         if( ( nFilesSent > 0 ) or
                             ( FileExists( ProgramPath + SEND_FLAG_FILE ) = True ) ) then
                         begin
                              ExportTable_InsertUpdate;
                              ExportTable_Delete;
                         end;
                     end
                end;
                CloseQueries;
           end;
           Log( 'Number of records: ' + IntToStr( nRecords ) );
           Log( 'Files sent via ftp: ' + IntToStr( nFilesSent ) );
           Log( 'Exec duration: ' + FormatDateTime( 'hh"h":nn"m":ss"s"',
              Now - t ) );
           Log( 'End' );
     except
           outError := 1;
           Log( 'Error: ' + Exception( ExceptObject ).Message );
     end;
     frmMain.memLog.Lines.SaveToFile(ChangeFileExt(Application.exename,'.log'));

end;

procedure Log( strLog: String );
begin
     frmMain.memLog.Lines.Add( strLog );
     WriteLn( strLog + '.   ' );
end;

procedure OpenQueries;
const
sqlProp = 'SELECT                                                       ' +
               '       A.ID,                                                 ' +
               '       A.OFFICE_ID,                                          ' +
               '       A.LAST_CHANGED,                                       ' +
               '       A.PROPERTY_TYPE,                                      ' +
               '       A.SALES_METHOD,                                       ' +
               '       isnull(off_market,0) as off_market, ' +
               '       A.InterNetID,                                          ' +
               '       A.UNIQUE_REA_ID                                         ' +
               'FROM   PROP  A  '+#13+
               'INNER JOIN DIST_AGENCY_ID_TRANSLATION E  ON  ( E.DIST_ID = %0:d ) ' +
               '    AND  ( E.OFFICE_ID = A.OFFICE_ID )  '+#13+
               'WHERE                                                        ' +
               '       ( A.PROPERTY_STATES = 0 )                             ' +
               'AND                                                          ' +
               '       ( A.SEND_MODE > 0 )                                   ' +
               'AND                                                          ' +
               '       ( E.DIST_ID IS NOT NULL )                             ' +
               'AND                                                          ' +
               '       ( ( A.DISTRIBUTOR1 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR2 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR3 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR4 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR5 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR6 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR7 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR8 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR9 = %0:d )                           ' +
               '         OR                                                  ' +
               '         ( A.DISTRIBUTOR10 = %0:d ) )                        ' ;
begin
     with frmMain do
     begin
          qryProp.SQL.Text := Format( sqlProp, [DIST_ID] );
          (*if testMode then begin
             messageDlg('Test Mode. Only ready South Yarra properties.',mtInformation,[mbOk],0);
             qryProp.SQL.Add(' and  A.OFFICE_ID = 94 ');
          end;*)
          qryProp.Open;
          //clipboard.asText:= qryProp.sql.text;
          qryExport.SQL.Text := Format( sqlExport, [DIST_ID] );
          qryExport.Open;
     end;
end;

procedure CloseQueries;
begin
     with frmMain do
     begin
          qryProp.Close;
          qryExport.Close;
          qryPropDetail.Close;
     end;
end;

function REAListingTypeFromSalesMethodAndPropertyType(_salesMethod, _propertyType: string): string;
begin
   result := '';
   if( _salesMethod = METHOD_RENT ) then
   begin
        if( _propertyType = MLS_PROP_TYPE_COMMERCIAL ) then
            result := LISTING_TYPE_COMMERCIAL
        else
            result := LISTING_TYPE_RENTAL;
   end
   else
       if( _propertyType = MLS_PROP_TYPE_LAND ) then
           result := LISTING_TYPE_LAND
       else
           if( _propertyType = MLS_PROP_TYPE_COMMERCIAL ) then
               result := LISTING_TYPE_COMMERCIAL
           else
               if sameText(_propertyType,MLS_PROP_TYPE_BUSINESS) then
                  result := LISTING_TYPE_BUSINESS
               else
                  result := LISTING_TYPE_RESIDENTIAL;

end;

procedure CreateExportFiles( var outRecords: Integer );
var
     Id, OfficeId: integer;
     strDateTime, strHeader, strHeaderNoPassword,  strListingType: String;
     LastChanged, Export_LastChanged: TDateTime;
     bExists, bSold, bValid: Boolean;
     _UNIQUE_REA_ID: string;
     _REBFilename: string;
     _XML: string;
     _OffMarketProperties: TMSQuery;
     _SentProperties: TMSQuery;
     _UpdatePropSentLog: TMSQuery;
     _iJim: integer;
begin
      _UNIQUE_REA_ID:= '';
     with frmMain do
     begin
          outRecords := 0;
          RentDotComListOfLists.Clear;
          ExportFile := TStringList.Create;
          ExportFileHomeHound:= TStringList.Create;
          ExportHomeSales:= TStringList.Create;
          ExportInspectRealEstate:= TStringList.Create;
          ExportPermitReady:= TStringList.Create;
          ExportRealEstateBookings:= TStringList.Create;
          ExportNickThorn:= TStringList.Create;


          ExportRateMyAgent:=  TStringList.Create;
          ExportActivePipe:=  TStringList.Create;
          ExportProEstate:=  TStringList.Create;
          ExportExcel:=  TStringList.Create;
          ExportOnTheHouse:=  TStringList.Create;
          ExportRentBuy:=  TStringList.Create;
          ExportFletchers:=  TStringList.Create;
          ExportRentFind:= TStringList.Create;
          ExportACProperty:= TStringList.Create;
          ExportMillionPlus:= TStringList.Create;
          strDateTime := FormatDateTime( TIMESTAMP_FORMAT, Now );
          strHeader := Format( EXPORT_HEADER, [strDateTime,MULTILINK_USERNAME, MULTILINK_PASSWORD] );
          ExportFile.Add( strHeader );
          strHeaderNoPassword := Format( EXPORT_HEADER, [strDateTime,'', ''] );
          ExportFileHomeHound.Add( strHeaderNoPassword );
          ExportMillionPlus.Add( strHeaderNoPassword );
          ExportRateMyAgent.Add( strHeaderNoPassword );
          ExportActivePipe.Add( strHeaderNoPassword );
          ExportProEstate.Add( strHeaderNoPassword );
          ExportExcel.Add( strHeaderNoPassword );
          ExportRentBuy.Add( strHeaderNoPassword );
          ExportFletchers.Add( strHeaderNoPassword );
          ExportOnTheHouse.Add(Format( EXPORT_HEADER, [strDateTime,'multilink.com.au','JuhYu67_d!']));
          ExportHomeSales.Add( strHeaderNoPassword );
          ExportInspectRealEstate.Add( strHeaderNoPassword );
          ExportPermitReady.Add(strHeaderNoPassword);
          ExportRealEstateBookings.Add( strHeaderNoPassword );
          ExportNickThorn.Add(strHeaderNoPassword);

          ExportRentFind.Add( strHeaderNoPassword );
          ExportACProperty.Add( strHeaderNoPassword );
          qryProp.First;
          qryExport.First;
          while( not( qryProp.EOF ) ) do
          begin
               Id := qryProp.FieldByName( 'ID' ).AsInteger;
               OfficeId := qryProp.FieldByName( 'OFFICE_ID' ).AsInteger;
               LastChanged := qryProp.FieldByName( 'LAST_CHANGED' ).AsDateTime;
               bExists := qryExport.Locate( 'ID;OFFICE_ID',
                  VarArrayOf([Id, OfficeId]), [] );

               if( bExists = True ) then
               begin
                    Export_LastChanged :=
                       qryExport.FieldByName( 'LAST_CHANGED' ).AsDateTime;
                    if( LastChanged <> Export_LastChanged ) then
                    begin
                         PropLastChangedList.addItem(Id,OfficeId, LastChanged );
                         _UNIQUE_REA_ID:=  qryProp.FieldByName( 'UNIQUE_REA_ID' ).AsString;
                         AddXMLToFile(Id, OfficeId, _UNIQUE_REA_ID, true );
                         Inc( outRecords );
                    end;
               end
               else
               begin
	                  CheckPropSold( Id, OfficeId, bSold, bValid );
                    // dont create a new ad if it's sold
                    if( bSold = False ) then
                    begin
                       _UNIQUE_REA_ID:=  qryProp.FieldByName( 'UNIQUE_REA_ID' ).AsString;
                    	 AddXMLToFile(Id, OfficeId, _UNIQUE_REA_ID, true);
                    	 Inc( outRecords );
                    end;
               end;

               qryProp.Next;
          end;
          //first loop checks current property data to see if already exists in export data
          //covers 1. already exported by has update 2. not exported and not sold so send new export
          //second loop checks export data to see if still exists in current property data
          //covers 1. has been sold so send export, 2. has dissapeared so withdrawn

          qryProp.First;
          qryExport.First;
          while( not( qryExport.EOF ) ) do
          begin
               Id := qryExport.FieldByName( 'ID' ).AsInteger;
               OfficeId := qryExport.FieldByName( 'OFFICE_ID' ).AsInteger;
               _UNIQUE_REA_ID:= '';
               bExists := qryProp.Locate( 'ID;OFFICE_ID',
                  VarArrayOf([Id, OfficeId]), [] );

               if( bExists = False ) then
               begin
                    CheckPropSold( Id, OfficeId, bSold, bValid );
                    if( bSold = True ) then
                    begin
                        _UNIQUE_REA_ID:=  qryExport.FieldByName( 'UNIQUE_REA_ID' ).AsString;
                         AddXMLToFile(Id, OfficeId, _UNIQUE_REA_ID, true);
                         Inc( outRecords );
                    end
                    else begin
                         strListingType :=
                            qryExport.FieldByName( 'LISTING_TYPE' ).AsString;
                         _UNIQUE_REA_ID:=  qryExport.FieldByName( 'UNIQUE_REA_ID' ).AsString;
                         AddWithdrawnXMLToFile(Id, OfficeId, strListingType,_UNIQUE_REA_ID, true );
                         Inc( outRecords );
                    end;
               end;

               qryExport.Next;
          end;

          if( outRecords > 0 ) then
          begin
               _OffMarketProperties :=   TMSQuery.Create(Nil);
               _UpdatePropSentLog :=   TMSQuery.Create(Nil);
               _SentProperties :=   TMSQuery.Create(Nil);
               _OffMarketProperties.connection := qryProp.Connection;
               _UpdatePropSentLog.Connection := qryProp.connection;
               _SentProperties.Connection := qryProp.connection;
               
              // off market props to REA.  Not listed on REA but can still be uploaded after sold with no cost and adds to agent sales histor ranking
               with _OffMarketProperties do
               begin
                 _UpdatePropSentLog.sql.Text := 'EXEC UpdatePropSentLog :id, :office_id, ''rea_offmarket'', :removed, :listing_type ';
                 sql.text :=
                     'select id,p.office_id, SALES_METHOD, PROPERTY_TYPE  from prop p '+
                     'join DIST_AGENCY_ID_TRANSLATION dat on p.office_id = dat.office_id and dat.dist_id = 6 '+
                     'where p.property_states = 2 and sales_method <> ''Rent'' and '+
                     '(p.distributor1 = 40 or p.distributor2 = 40 or p.distributor3 = 40 or p.distributor4 = 40 or p.distributor5 = 40 '+
                     'or p.distributor6 = 40 or p.distributor7 = 40 or p.distributor8 = 40 or p.distributor9 = 40 or p.distributor10 = 40) ';
                 open;
                 while not eof do begin
                    strListingType := REAListingTypeFromSalesMethodAndPropertyType( FieldByName( 'SALES_METHOD' ).AsString, FieldByName( 'PROPERTY_TYPE' ).AsString);
                    _UpdatePropSentLog.Close;
                    _UpdatePropSentLog.ParamByName('id').AsInteger :=  fieldByName('id').AsInteger;
                    _UpdatePropSentLog.ParamByName('office_id').AsInteger :=  fieldByName('office_id').AsInteger;
                    _UpdatePropSentLog.ParamByName('removed').AsInteger :=  0;
                    _UpdatePropSentLog.ParamByName('listing_type').AsString :=  strListingType;
                    _UpdatePropSentLog.Open;
                    if  _UpdatePropSentLog.FieldByName('RESULT_TEXT').AsString = 'NEW' then begin
                      _XML := AddXMLToFile(fieldByName('id').AsInteger, fieldByName('office_id').AsInteger,'', false);
                      ExportFile.Add(_XML);
                    end;    // if
                    next;
                 end; // while
                 close;
               end;
               _UpdatePropSentLog.close;

               ExportFile.Add( EXPORT_FOOTER );
               ExportFileHomeHound.Add( EXPORT_FOOTER );
               ExportMillionPlus.Add(EXPORT_FOOTER);
               ExportHomeSales.Add(EXPORT_FOOTER);
               ExportInspectRealEstate.Add(EXPORT_FOOTER);
               ExportPermitReady.Add(EXPORT_FOOTER);
               ExportRealEstateBookings.Add(EXPORT_FOOTER);

               ExportRateMyAgent.Add(EXPORT_FOOTER);
               ExportActivePipe.Add(EXPORT_FOOTER);
               ExportProEstate.Add(EXPORT_FOOTER);
               ExportExcel.Add(EXPORT_FOOTER);
               ExportOnTheHouse.Add(EXPORT_FOOTER);
               ExportRentBuy.Add(EXPORT_FOOTER);
               ExportFletchers.Add(EXPORT_FOOTER);
               ExportRentFind.Add(EXPORT_FOOTER);
               ExportACProperty.Add(EXPORT_FOOTER);

               strDateTime := FormatDateTime( FILENAME_TIMESTAMP_FORMAT, Now );
               strFilename := Format('multilink_%s.XML',[strDateTime] );
               ExportFile.SaveToFile( IniDir + strFilename );


               if ExportACPropertyCount > 0 then begin
                   FilenameACProperty:=  ExportDir +Format('MTL_ACPROPERTY_%s.XML',[strDateTime] );
                   ExportACProperty.SaveToFile(FilenameACProperty );
               end;

               if ExportRentFindCount > 0 then begin
                   FilenameRentFind:=  ExportDir +Format('MTL_RENT_FIND_%s.XML',[strDateTime] );
                   ExportRentFind.SaveToFile(FilenameRentFind );
               end;

               if ExportHomeSalesCount > 0 then begin
                   FilenameHomeSales:=  ExportDir +Format('MTL_HOME_SALES_%s.XML',[strDateTime] );
                   ExportHomeSales.SaveToFile(FilenameHomeSales );
               end;


               if ExportPermitReadyCount > 0 then begin
                   FileNamePermitReady:=  ExportDir +Format('MTL_PERMITREADY_REA_%s.XML',[strDateTime] );
                   ExportPermitReady.SaveToFile(FileNamePermitReady );
               end;

               if ExportInspectRealEstateCount > 0 then begin
                   FileNameInspectRealEstate:=  ExportDir +Format('MTL_INSPECT_REA_%s.XML',[strDateTime] );
                   ExportInspectRealEstate.SaveToFile(FileNameInspectRealEstate );
               end;

               if ExportRealEstateBookingsCount > 0 then begin
                   _REBFilename := Format('REB_INSPECT_REA_%s.XML',[strDateTime] );
                   FileNameRealEstateBookings:=  ExportDir + _REBFilename;
                   ExportRealEstateBookings.SaveToFile(FileNameRealEstateBookings );
                   ExportRealEstateBookings.SaveToFile('C:\inetpub\wwwroot\Download\RealEstateBookings\'+ _REBFilename);
               end;


               // off market props to Nickthorn who hosts the NJ website.
               (*
               with _OffMarketProperties do
               try
                  close;
                  _UpdatePropSentLog.close;
                  _UpdatePropSentLog.sql.Text := 'EXEC UpdatePropSentLog :id, :office_id, ''nickthorn'', :removed, :listing_type ';
                  sql.text := 'select * from prop where property_states = 0 and isnull(off_market,0) <> 0';
                  open;
                  while not eof do begin
                    strListingType := REAListingTypeFromSalesMethodAndPropertyType( FieldByName( 'SALES_METHOD' ).AsString, FieldByName( 'PROPERTY_TYPE' ).AsString);
                    if OKforNickThorn(fieldByName('office_id').AsInteger, strListingType) then begin
                      _UpdatePropSentLog.Close;
                      _UpdatePropSentLog.ParamByName('id').AsInteger :=  fieldByName('id').AsInteger;
                      _UpdatePropSentLog.ParamByName('office_id').AsInteger :=  fieldByName('office_id').AsInteger;
                      _UpdatePropSentLog.ParamByName('removed').AsInteger :=  0;
                      _UpdatePropSentLog.ParamByName('listing_type').AsString :=  strListingType;
                      _UpdatePropSentLog.Open;
                      if  _UpdatePropSentLog.FieldByName('RESULT_TEXT').AsString <> 'NO_CHANGE' then begin
                        // function AddXMLToFile( InterNetID: integer; const Id, OfficeId: Integer; _UNIQUE_REA_ID: string; AddToFiles: boolean): string;
                        _XML := AddXMLToFile(fieldByName('id').AsInteger, fieldByName('office_id').AsInteger,'', false);
                        ExportNickThorn.Add(_XML);
                        inc(ExportNickThornCount);
                      end;
                    end;
                    next;
                  end;

                  _UpdatePropSentLog.Close;
                  _SentProperties.SQL.Text := 'select * from PropSentLog where isNull(removed,0) = 0 and destination = ''nickthorn''';
                  _SentProperties.Open;
                  while not _SentProperties.Eof do begin
                    strListingType:=  _SentProperties.fieldByName('LISTING_TYPE').AsString;
                    _iJim :=  _SentProperties.FieldByName('id').AsInteger;
                    if not _OffMarketProperties.Locate( 'ID;OFFICE_ID', VarArrayOf([_iJim, _SentProperties.FieldByName('OFFICE_ID').AsInteger]), [] ) then begin
                      _UpdatePropSentLog.Close;
                      _UpdatePropSentLog.ParamByName('id').AsInteger := _iJim;
                      _UpdatePropSentLog.ParamByName('office_id').AsInteger := _SentProperties.FieldByName('OFFICE_ID').AsInteger ;
                      _UpdatePropSentLog.ParamByName('removed').AsInteger :=  1;
                      _UpdatePropSentLog.ParamByName('listing_type').AsString :=  strListingType;
                      _UpdatePropSentLog.Open;
                      // function AddWithdrawnXMLToFile( InterNetID: integer; const Id, OfficeId: Integer;const strListingType: String; _UNIQUE_REA_ID: string; AddToFiles: boolean) : string;
                      _XML := AddWithdrawnXMLToFile(_iJim, _SentProperties.FieldByName('OFFICE_ID').AsInteger,strListingType,'', false);
                      _XML:= StringReplace(_XML,'status="withdrawn"','status="off_market_withdrawn"', [rfReplaceAll, rfIgnoreCase]);
                      ExportNickThorn.Add(_XML);
                      inc(ExportNickThornCount);
                    end;
                    _SentProperties.next;
                  end;
                  _SentProperties.Close;
                  close;
               finally
                  _UpdatePropSentLog.Free;
                  _SentProperties.Free;
                  free;
               end;
            *)

               if ExportNickThornCount > 0 then begin
                 ExportNickThorn.Add(EXPORT_FOOTER);
                 FileNameNickThorn:=  ExportDir +Format('NICKTHORN_REA_%s.XML',[strDateTime] );
                 ExportNickThorn.SaveToFile(FileNameNickThorn );
               end;


               if ExportActivePipeCount > 0 then begin
                   FileNameActivePipe:=  ExportDir +Format('MTL_ActivePipe_%s.XML',[strDateTime] );
                   ExportActivePipe.SaveToFile(FileNameActivePipe );
               end;


               if ExportProEstateCount > 0 then begin
                   FileNameProEstate:=  ExportDir +Format('MTL_ProEstate_%s.XML',[strDateTime] );
                    ExportProEstate.SaveToFile(FileNameProEstate );
               end;
               if ExportExcelCount > 0 then begin
                   FileNameExcel:=  ExportDir +Format('MTL_Excel_%s.XML',[strDateTime] );
                    ExportExcel.SaveToFile(FileNameExcel );
               end;



               if ExportRateMyAgentCount > 0 then begin
                   FileNameRateMyAgent:=  ExportDir +Format('MTL_RateMyAgent_%s.XML',[strDateTime] );
                   ExportRateMyAgent.SaveToFile(FileNameRateMyAgent );
               end;
               if ExportOnTheHouseCount > 0 then begin
                   FileNameOnTheHouse:=  ExportDir +Format('MTL_OnTheHouse_%s.XML',[strDateTime] );
                   ExportOnTheHouse.SaveToFile(FileNameOnTheHouse );
               end;
               if ExportFletchersCount > 0 then begin
                   FileNameFletchers:=  ExportDir +Format('MTL_Fletchers_%s.XML',[strDateTime] );
                   ExportFletchers.SaveToFile(FileNameFletchers);
               end;
               if ExportRentBuyCount > 0 then begin
                   FileNameRentBuy:=  ExportDir +Format('MTL_rentbuy_%s.XML',[strDateTime] );
                   ExportRentBuy.SaveToFile(FileNameRentBuy);
               end;

               if ExportHomeHoundCount > 0 then begin
                   FilenameHomeHound:=  ExportDir +Format('MTL_%s.XML',[strDateTime] );
                   ExportFileHomeHound.SaveToFile(FilenameHomeHound );
               end;
               if MillionPlusCount > 0 then begin
                   FilenameMillionPlus:=  ExportDir +Format('MTL_MP_%s.XML',[strDateTime] );
                   ExportMillionPlus.SaveToFile(FilenameMillionPlus );
               end;
          end;

          Memo1.Lines.Add( 'end CreateExportFiles procedure' );
          Memo1.Lines.SaveToFile( 'c:\rca_xml_log.txt' );
     end;
end;

procedure CheckPropSold( const Id, OfficeId: Integer;
   var outSold, outValid: Boolean );
var
   nCount, nNumBedrooms: Integer;
   strSalesMethod, strPropertyType, strNumBedrooms: String;
begin
     with frmMain.qryPropSold do
     begin
          Close;
          SQL.Text := sqlCheckPropSold;
          ParamByName( 'ID' ).AsInteger := Id;
          ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
          Open;
          nCount := FieldByName( 'ID_COUNT' ).AsInteger;
          Close;
          if( nCount > 0 ) then
              outSold := True
          else
              outSold := False;

          outValid := False;
          if( outSold = True ) then
          begin
               Close;
               SQL.Text := sqlCheckPropSold_Valid;
               ParamByName( 'ID' ).AsInteger := Id;
               ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
               Open;

               if( FieldByName( 'LAST_SOLD' ).IsNull ) then
                   exit;

               try
                     if( FieldByName( 'SOLD_PRICE' ).AsFloat <= 0 ) then
                         exit;
               except
                     exit;
               end;

               strSalesMethod := FieldByName( 'SALES_METHOD' ).AsString;
               strPropertyType := FieldByName( 'PROPERTY_TYPE' ).AsString;
               try
                     if( ( strSalesMethod <> METHOD_RENT ) and
                         ( strPropertyType <> MLS_PROP_TYPE_UNIT ) and
                         ( FieldByName( 'LAND_AREA_QUANTITY' ).AsFloat <= 0 ) ) then
                         exit;
               except
                     exit;
               end;

               if( ( strPropertyType = MLS_PROP_TYPE_HOUSE ) or
                   ( strPropertyType = MLS_PROP_TYPE_UNIT ) ) then
               begin
                    if( FieldByName( 'NUMBER_OF_BEDROOMS' ).IsNull = False ) then
                    begin
                         nNumBedrooms := FieldByName( 'NUMBER_OF_BEDROOMS' ).AsInteger;
                    end
                    else
                    begin
                         strNumBedrooms := Trim( FieldByName( 'NUM_BEDROOMS' ).AsString );
                         nNumBedrooms := StrToIntDef( strNumBedRooms, 0 );
                    end;

                    if( nNumBedrooms <= 0 ) then
                        exit;
               end;

               Close;
               outValid := True;
          end;
     end;
end;

function GetTranslatedAgentId( const nOfficeId: Integer ): String;
begin
     with frmMain.qryTranslatedAgentId do
     begin
          Close;
          SQL.Text := sqlTranslatedAgentId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;
          ParamByName( 'DIST_ID' ).AsInteger := DIST_ID;
          Open;
          if ( RecordCount > 0 ) then
              Result := FieldByName( 'TRANSLATED_ID' ).AsString
          else
              Result := '';
          Close;
     end;
end;

function AddWithdrawnXMLToFile( const Id, OfficeId: Integer;
   const strListingType: String; _UNIQUE_REA_ID: string; AddToFiles: boolean): string;
var
   S, strDateTime, strStatus, strPropertyId, strRcaAgentId: String;
   _hasBeenSentToRentDotCom: boolean;
   _TRANSLATED_ID_RENTDOTCOM: string;
begin
    Result := '';
     with frmMain, frmMain.qryPropDetail do
     begin
          if  (lowercase(strListingType) <> 'rental') and  (OfficeId = NOEL_J0NES_BALWYN) then
            exit;
          if  (lowercase(strListingType) <> 'rental') and  (OfficeId = FLETCHERS_GLEN_IRIS) then
            exit;
          strRcaAgentId := GetTranslatedAgentId( OfficeId );
           if   OfficeId = 94 then
              if sameText(strListingType,MLS_PROP_TYPE_BUSINESS) then
                 strRcaAgentId:= 'isznvn';
          strDateTime := FormatDateTime( 'yyyy-mm-dd-hh:nn:ss', Now );
          strStatus := STATUS_WITHDRAWN;
          _UNIQUE_REA_ID:= trim(_UNIQUE_REA_ID);
          if (_UNIQUE_REA_ID <> '') then
             strPropertyId := Format( '%s', [_UNIQUE_REA_ID] )
          else
             strPropertyId := Format( '%d-%d', [OfficeId, Id] );
          S := Format( EXPORT_WITHDRAWN_LINE, [
             strListingType,
             strDateTime,
             strStatus,
             strRcaAgentId,
             strPropertyId,
             strListingType
             ] );
          Result := s;
          if not AddToFiles then
            exit;
          if strRcaAgentId <> DUMMY_REA_CODE_NOT_TO_BE_SENT then
             ExportFile.Add( S );
          if OKforMillionPlus(OfficeId) then begin
             ExportMillionPlus.Add(s);
             inc(MillionPlusCount);
          end;
          if OKforActivePipe(OfficeId) then begin
             ExportActivePipe.Add(s);
             inc(ExportActivePipeCount);
          end;
          if OKforProEstate(OfficeId) then begin
             ExportProEstate.Add(s);
             inc(ExportProEstateCount);
          end;
          if OKforNickThorn(OfficeId, strListingType) then begin
              ExportNickThorn.Add(s);
             inc(ExportNickThornCount);
          end;
          if OKforExcel(OfficeId) then begin
             S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               IntToStr(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
             ExportExcel.Add(s);
             inc(ExportExcelCount);
          end;
          if OkforOnTheHouse(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForOnTheHouse(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportOnTheHouse.Add(s);
            inc(ExportOnTheHouseCount);
          end;

          if OkforFletchers(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForFletchers(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportFletchers.Add(s);
            inc(ExportFletchersCount);
          end;

          if OkforRentBuy(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForRentBuy(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportRentBuy.Add(s);
            inc(ExportRentBuyCount);
          end;

          if OKforHomeHound(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               IntToStr(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportFileHomeHound.Add(s);
            inc(ExportHomeHoundCount);
          end;

          if OKforHomeSales(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForHomeSales(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportHomeSales.Add(s);
            inc(ExportHomeSalesCount);
          end;

          if OKforPermitReady(OfficeId, strListingType) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               strRcaAgentId,
               strPropertyId,strListingType
               ] );
            ExportPermitReady.Add(s);
            inc(ExportPermitReadyCount);
          end;

          if OKforInspectRealEstate(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForInspectRealEstate(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportInspectRealEstate.Add(s);
            inc(ExportInspectRealEstateCount);
          end;

          if OKforRealEstateBookings(OfficeId, strListingType) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForRealEstateBookings(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportRealEstateBookings.Add(s);
            inc(ExportRealEstateBookingsCount);
          end;



          if OkforRateMyAgent(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForRateMyAgent(OfficeId),
               strPropertyId,strListingType
               ] );
            ExportRateMyAgent.Add(s);
            inc(ExportRateMyAgentCount);
          end;


          if OKforRentFind(OfficeId) and (pos('rent',lowercase(strListingType)) = 1) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDForRentFind(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportRentFind.Add(s);
            inc(ExportRentFindCount);
          end;

          if OKforACproperty(OfficeId) then begin
            S := Format( EXPORT_WITHDRAWN_LINE, [
               strListingType,strDateTime,strStatus,
               AgentIDACProperty(OfficeId), //this is replacing the Agent ID
               strPropertyId,strListingType
               ] );
            ExportACproperty.Add(s);
            inc(ExportACpropertyCount);
          end;

          //check OK for RentDotCom have to check DistExport2
          _hasBeenSentToRentDotCom:= False;
          with qryWorker do begin
            close;
            SQL.Text:= 'select TRANSLATED_ID FROM DIST_AGENCY_ID_TRANSLATION where OFFICE_ID = :OFFICE_ID AND DIST_ID = :DIST_ID ';
            ParamByName('OFFICE_ID').AsInteger:= OfficeId;
            ParamByName('DIST_ID').AsInteger:= DIST_ID_RENTDOTCOM;
            open;
            _TRANSLATED_ID_RENTDOTCOM:= '';
            if not (EOF and BOF) then begin
               _TRANSLATED_ID_RENTDOTCOM:= fields[0].AsString;
            end;
            close;
            if _TRANSLATED_ID_RENTDOTCOM <> '' then begin
               S := Format( EXPORT_WITHDRAWN_LINE, [
                           strListingType,
                           strDateTime,
                           strStatus,
                           _TRANSLATED_ID_RENTDOTCOM,
                           strPropertyId,
                           strListingType
                           ] );
               RentDotComListOfLists.AddItem(OfficeId,S);
            end;
          end;
     end;
end;

function officeIsEnabledForBusinessUpload(_office_id: integer): boolean;
begin
   Result:= True;
   exit;
   //let them all try
   if  _office_id = JY_PROPERTY then
     Result:= True;
   if  _office_id = 94 then
     Result:= True;
   if  _office_id = 1 then
     Result:= True;
end;


function XmlStrLocal( S: String ): String;
var
   s1, s2: String;
   i, SLen: integer;
   bUlamut: Boolean;
begin
     s1:= '';
     S := RemoveStr( S, '"', False );
     S:= StringReplace(S,'<strong>','|1|', [rfReplaceAll, rfIgnoreCase]);
     S:= StringReplace(S,'</strong>','|2|', [rfReplaceAll, rfIgnoreCase]);
     SLen := Length( S );
     if( SLen > 0 ) then
        for i := 1 to SLen do
        begin
             s2:= '';
             bUlamut := CharUlamut( S[i] );
             if( bUlamut = True ) then
                 s2 := XmlCharEscape( S[i] )
             else
             begin
                  case( s[i] ) of
                      '&':      s2 := '&'; //'&amp;';
                      '<':      s2 := '<'; //'&lt;';
                      '>':      s2 := '>';//'&gt;';
                      Chr(13):       s2 := Chr(13);//'<br>';
                      Chr(0)..Chr(12):    s2 := ' ';  //#13 and #10 are going to spaces. instead of <br>
                      Chr(14)..Chr(31):    s2 := ' ';  //#13 and #10 are going to spaces. instead of <br>
                      Chr(127)..Chr(255):  s2 := XmlCharEscape( S[i] ); //s2 := ' ';
                  else
                      s2 := S[i];
                  end;
             end;
             s1 := s1 + s2;
        end;
     s1:= StringReplace(s1,'|1|','<strong>', [rfReplaceAll, rfIgnoreCase]);
     s1:= StringReplace(s1,'|2|','</strong>', [rfReplaceAll, rfIgnoreCase]); 
     Result := s1;
end;


function DistributingToHomeHound: boolean;
begin
   Result:= False;
   with frmMain.qryPropDetail do begin
      if  FieldByName( 'DISTRIBUTOR1' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR2' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR3' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR4' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR5' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR6' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR7' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR8' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR9' ).AsInteger = 26 then
        Result:= true;
      if  FieldByName( 'DISTRIBUTOR10' ).AsInteger = 26 then
        Result:= true;
   end;
end;

function AsciiToHTML(s: string): string;
var i, _ord: integer;
begin
   result:= '';
   for i:= 1 to length(s) do begin
     _ord:= ord(s[i]);
     case   _ord of
       1..47: begin
                if  _ord = 32 then
                   result:= result+s[i]
                else
                  result:= result+format('&#%d;',[_ord]);
              end;
       91..96: result:= result+format('&#%d;',[_ord]);
       123..255: result:= result+format('&#%d;',[_ord])
     else
       result:= result+s[i];
     end
   end;
end;

function AddXMLToFile( const Id, OfficeId: Integer;_UNIQUE_REA_ID: string; AddToFiles: boolean): string;
const
     AVAILABLE_LISTINGS_AGENTS = 6;
     MAX_LISTINGS_AGENTS = 2;

     ADDRESS_NUMBER_MAX_LEN = 20;
     ADVERTISING_TITLE_MAX_LEN = 120;

     MAX_LENGTH_PRICE_DESCRIPTION = 40;
var
   i, PhotoCount, nPropertyStates, nPrice, nRentWeek, nCommercialRent,
      nUserId, nNumAgents, nNumTours, nNumInpections, nPricePerYear, n,
      FloorPlanCount, nPos, nBond, nUlamutCount, nNumBedrooms, nNumBathrooms, _NUMBER_OF_TOILETS,
      nOpenSpaces, nNumGarages, nCarPorts, nAirConditioning: integer;
      _BUS_TAKINGS, _BUS_ANNUAL_RETURN, _BUS_CURRENT_RENT, _BUS_ANNUAL_NET_PROFIT: integer;
   PhotoField: TBlobField;
   fPrice, fLandArea, fBuildingArea: Double;
   dtDateAvailable, dtAuctionTime: TDateTime;
   S, strPropertyId, strAddress, PhotoName, strPhotoFile, strDescription,
      _PROPERTY_FEATURES,
      strSalesMethod, strUnitNumber,
      strStreetNumber, strStreetName, strStreetType, strMapNumber, strMapRef,strUNDEROFFER,
      strCombinedMapRef, strAuctionDate, str_AuctionTime,
      strAuctionTime, strPropType, strLandArea, str_LandArea,
      strBuildingArea, str_BuildingArea, strRcaAgentId,
      strDateTime, strStatus, strAuthority, strListingType, strCommercialListingType,
      strAgentsLines, strDateAvailable, str_DateAvailable, strRentPrice, strSalePrice,
      strPriceView, strAddressNumber, strAddressStreet, strSuburb, strPostcode,
      strHeadline, strResidentialFeatures, _allowances,
      strGarages, strAirConditioning, strHeating, strHotWaterService,
      strBuildingDetails, str_AuctionDate, strObjects,
      strImageUrl, strLine, strImageId, str_PropType, strCommercialRent,
      strContactFieldName, strPriceDescription,
      strAddressDescription, strFieldName, strPlanFilename, strVirtualTours, _videoLink, _StatementOfInformation,
      _OffMarket, 
      strVirtualTourUrl, strVirtualTourType, strInspectionTimes,
      strInspectionStart, strInspectionEnd, strAuthorityFormat, strSoldDate,
      strSoldDetails, strState, strBathrooms, 
      strAddressDescription_Test, strAddressDisplay,
      strNumBedrooms, strNumBathrooms, strNumGarages,
      strBusinessSubCategory, strCategory, strImages,
      strPlans, strSeveralBusinessElements: String;
      _EXPORT_BUS_LEASE_END: string;
      UserDetails: TUserDetails;
      bResult: Boolean;
      PropType_Array: Array[0..MAX_PROPERTY_TYPES-1] of string;
      strPrice_Prefix : String;
      _TotalCars : Integer;
      _extraAddressInfo: string;
      _pos, _DO_NOT_DISCLOSE, intSoldPrice: integer;
      _TRANSLATED_ID_RENTDOTCOM, _PropType_Array0: string;
      _GotPropTypes, _ThisIsAStudio: boolean;
      _tmpAddress: string;
begin
     Result := '';
     _ThisIsAStudio:= False;
     strSeveralBusinessElements:= '';
     with frmMain, frmMain.qryPropDetail do
     begin
          SQL.Text := Format( sqlPropDetail, [Id, OfficeId, DIST_ID] );
          //clipBoard.AsText :=   SQL.Text;
          Memo1.Lines.Add( 'opening ' + IntToStr(OfficeId) + '_' +
             IntToStr( Id ) );
          Memo1.Lines.SaveToFile( 'c:\rca_xml_log.txt' );
          Open;
         // clipBoard.AsText :=  frmMain.qryPropDetail.sql.text;
         // showMessage(FieldByName('ADDRESS').AsSTring);
          Memo1.Lines.Add( 'opened ' + IntToStr( OfficeId ) + '_' +
             IntToStr( Id ) );
          Memo1.Lines.SaveToFile( 'c:\rca_xml_log.txt' );

          strPropType := FieldByName( 'PROPERTY_TYPE' ).AsString;
          strSalesMethod := FieldByName( 'SALES_METHOD' ).AsString;
          if   (lowercase(strSalesMethod) <> 'rent') and  (OfficeId = NOEL_J0NES_BALWYN) then
            exit;
          if   (lowercase(strSalesMethod) <> 'rent') and  (OfficeId = FLETCHERS_GLEN_IRIS) then
            exit;
          GetPropTypes( Id, OfficeId, PropType_Array, _GotPropTypes );
          //if id = 2043 then
          //  showMessage('260');
          if( _GotPropTypes = False ) then
          begin
               if( ( strSalesMethod = METHOD_RENT ) and
                   ( strPropType <> MLS_PROP_TYPE_COMMERCIAL ) ) then
                   PropType_Array[0] := ''
               else
                   if( strPropType = MLS_PROP_TYPE_LAND ) then
                       PropType_Array[0] := LISTING_TYPE_LAND
                   else
                       if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then
                           PropType_Array[0] := LISTING_TYPE_COMMERCIAL
                       else
                           // residential <Category name="..." />
                           PropType_Array[0] := '';

               if( strPropType = MLS_PROP_TYPE_LAND ) then
                   PropType_Array[1] := EXPORT_LAND_DEFAULT_CATEGORY
               else
                   if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then
                       PropType_Array[1] := EXPORT_COMMERCIAL_DEFAULT_CATEGORY
                   else
                   begin
                        if( strPropType = MLS_PROP_TYPE_HOUSE ) then
                            PropType_Array[0] := RCA_PROP_TYPE_HOUSE
                        else
                            if( strPropType = MLS_PROP_TYPE_UNIT ) then
                                PropType_Array[0] := RCA_PROP_TYPE_UNIT
                            else
                                if( strPropType = MLS_PROP_TYPE_APARTMENT ) then
                                    PropType_Array[0] := RCA_PROP_TYPE_APARTEMENT
                                else
                                    if( strPropType = MLS_PROP_TYPE_WAREHOUSE_SHELL ) then
                                        PropType_Array[0] := RCA_PROP_TYPE_APARTEMENT
                                    else
                                        if( strPropType = MLS_PROP_TYPE_TOWNHOUSE ) then
                                            PropType_Array[0] := RCA_PROP_TYPE_TOWNHOUSE
                                        else
                                            PropType_Array[0] := RCA_PROP_TYPE_HOUSE;
                   end;
          end;
          strListingType:= '';
          if( strSalesMethod = METHOD_RENT ) then
              strListingType := LISTING_TYPE_RENTAL
          else
              strListingType := LISTING_TYPE_RESIDENTIAL;
          if strPropType = MLS_PROP_TYPE_LAND then  begin
              strListingType:= LISTING_TYPE_LAND;
          end;
          if strPropType = MLS_PROP_TYPE_COMMERCIAL then
              strListingType:= LISTING_TYPE_COMMERCIAL;
          if strPropType = MLS_PROP_TYPE_BUSINESS then
              strListingType:= LISTING_TYPE_BUSINESS;                          //Rural  Land Commercial  Business
          _PropType_Array0:= Trim(PropType_Array[0]);
          _PropType_Array0:= Uppercase(_PropType_Array0);
          if  _GotPropTypes then
               if (_PropType_Array0 = 'RURAL')  or  (_PropType_Array0 = 'LAND')
                 or (_PropType_Array0 = 'COMMERCIAL')  or (_PropType_Array0 = 'BUSINESS') then
                   if Trim(PropType_Array[0]) <> '' then
                      strListingType:=  PropType_Array[0];

          //end;
          if( PropType_Array[2] = '' ) then
              strBusinessSubCategory := ''
          else
              strBusinessSubCategory := Format( EXPORT_BUSINESS_SUBCATEGORY,[PropType_Array[2]] );

          if( PropType_Array[0] = LISTING_TYPE_BUSINESS ) then
          begin
               strCategory := Format( EXPORT_BUSINESS_CATEGORY, [
                  PropType_Array[1]
                  ] );
          end
          else
          begin                 //landCategory name
                  if  trim(PropType_Array[1]) <> '' then
                    strCategory := Format( '<category name="%s" />', [PropType_Array[1]])
                  else
                    strCategory := Format( '<category name="%s" />', [PropType_Array[0]]);
                  if (PropType_Array[1] = 'Studio') or (PropType_Array[0] = 'Studio') then
                    _ThisIsAStudio:= true;
                  if( strPropType = MLS_PROP_TYPE_LAND ) then
                     strCategory := Format( '<landCategory name="%s" />', [PropType_Array[1]]);
                  if lowercase(strListingType) = 'rural' then
                     strCategory := Format( '<ruralCategory name="%s" />', [PropType_Array[1]]);
                  if strListingType = LISTING_TYPE_COMMERCIAL then
                     strCategory := Format( '<commercialCategory name="%s" />', [PropType_Array[1]]);
          end;
          strRcaAgentId := FieldByName( 'TRANSLATED_ID' ).AsString;
          if sameText(strPropType,MLS_PROP_TYPE_BUSINESS) then begin
              if not officeIsEnabledForBusinessUpload(OfficeId) then
                exit;
              if   OfficeId = 94 then
                 strRcaAgentId:= 'isznvn';  //isznvn is the <agentID>XNJGLF</agentID> for South Yarra business
              strListingType:=    LISTING_TYPE_BUSINESS;
              PropType_Array[0]:= LISTING_TYPE_BUSINESS;
              PropType_Array[1]:= '';
              PropType_Array[2]:= '';
              strCategory:=
                format(
                    '<businessCategory id="1">'+ CRLF +
                    '<name>%s</name>'+ CRLF +
                    '<businessSubCategory>'+ CRLF +
                    '<name>%s</name>'+ CRLF +
                    '</businessSubCategory>'+ CRLF +
                    '</businessCategory>'+ CRLF,
                [FieldByName( 'BUS_CATEGORY1' ).AsString,FieldByName( 'BUS_SUBCATEGORY1' ).AsString]);
              if  trim(FieldByName( 'BUS_CATEGORY2' ).AsString) <> '' then begin
                strCategory:= strCategory+
                  format(
                      '<businessCategory id="2">'+ CRLF +
                      '<name>%s</name>'+ CRLF +
                      '<businessSubCategory>'+ CRLF +
                      '<name>%s</name>'+ CRLF +
                      '</businessSubCategory>'+ CRLF +
                      '</businessCategory>'+ CRLF,
                  [FieldByName( 'BUS_CATEGORY2' ).AsString,FieldByName( 'BUS_SUBCATEGORY2' ).AsString]);
              end;
              if  trim(FieldByName( 'BUS_CATEGORY3' ).AsString) <> '' then begin
                strCategory:= strCategory+
                  format(
                      '<businessCategory id="3">'+ CRLF +
                      '<name>%s</name>'+ CRLF +
                      '<businessSubCategory>'+ CRLF +
                      '<name>%s</name>'+ CRLF +
                      '</businessSubCategory>'+ CRLF +
                      '</businessCategory>'+ CRLF,
                  [FieldByName( 'BUS_CATEGORY3' ).AsString,FieldByName( 'BUS_SUBCATEGORY3' ).AsString]);
              end;
              _EXPORT_BUS_LEASE_END:= '';
              if  FieldByName( 'BUS_LEASE_END' ).AsDateTime > EncodeDate(2000,1,1) then
                _EXPORT_BUS_LEASE_END:= FormatDateTime('yyyy-mm-dd',FieldByName( 'BUS_LEASE_END' ).AsDateTime);
              _BUS_TAKINGS:= StrToIntDef(FieldByName( 'BUS_TAKINGS' ).asString,0);
              _BUS_ANNUAL_RETURN:= FieldByName( 'BUS_ANNUAL_RETURN' ).AsInteger;
              _BUS_ANNUAL_NET_PROFIT:= FieldByName( 'BUS_ANNUAL_NET_PROFIT' ).AsInteger;
              _BUS_CURRENT_RENT:= FieldByName( 'BUS_CURRENT_RENT' ).AsInteger;
              strSeveralBusinessElements:=
                 format('<tax>%S</tax>'+ CRLF ,[FieldByName( 'BUS_GST' ).AsString])+
                 format('<takings>%d</takings>'+ CRLF ,[_BUS_TAKINGS])+
                 format('<return>%d</return>'+ CRLF ,[_BUS_ANNUAL_RETURN])+  //currency needs to be zero
                 format('<netProfit>%d</netProfit>'+ CRLF,[_BUS_ANNUAL_NET_PROFIT])+  //currency needs to be zero
                 format('<businessLease period="month">%d</businessLease>'+ CRLF,[_BUS_CURRENT_RENT])+  //currency needs to be zero
                 format(EXPORT_BUS_LEASE_END, [_EXPORT_BUS_LEASE_END])+     //2003-12-16
                 format(EXPORT_BUS_FURTHER_OPTIONS,[FieldByName( 'BUS_FURTHER_OPTIONS' ).AsString])+
                 format(EXPORT_BUS_SALE_TERMS,[FieldByName( 'BUS_SALE_TERMS' ).AsString]);

          end;


          strDateTime := FormatDateTime( 'yyyy-mm-dd-hh:nn:ss', Now );

          nPropertyStates := FieldByName( 'PROPERTY_STATES' ).AsInteger;
          if( nPropertyStates = PROPERTY_STATES_SOLD ) then
          begin
               if( strSalesMethod = METHOD_RENT ) then
                   strStatus := STATUS_LEASED
               else
                   strStatus := STATUS_SOLD;
          end
          else
              strStatus := STATUS_CURRENT;

          _UNIQUE_REA_ID:= trim(_UNIQUE_REA_ID);
          if (_UNIQUE_REA_ID <> '') then
             strPropertyId := Format( '%s', [_UNIQUE_REA_ID] )
          else
             strPropertyId := Format( '%d-%d', [OfficeId, Id] );

          if( ( PropType_Array[0] = LISTING_TYPE_COMMERCIAL ) or
              ( strPropType = MLS_PROP_TYPE_COMMERCIAL ) ) then
          begin
               strAuthorityFormat := EXPORT_COMMERCIAL_AUTHORITY;
               if ( strSalesMethod = METHOD_RENT ) then
                   strCommercialListingType := EXPORT_COMMERCIAL_LISTING_TYPE_LEASE
               else
                   if ( strSalesMethod = METHOD_BOTH ) then
                      strCommercialListingType := EXPORT_COMMERCIAL_LISTING_TYPE_BOTH
                   else
                      strCommercialListingType := EXPORT_COMMERCIAL_LISTING_TYPE_SALE;
          end
          else
          begin
               strAuthorityFormat := EXPORT_AUTHORITY;
               strCommercialListingType := '';
          end;

          if( strSalesMethod = METHOD_RENT ) then
              strAuthority := ''
          else begin
              if( strSalesMethod = METHOD_AUCTION ) then
                  strAuthority := Format( strAuthorityFormat,
                     [EXPORT_AUTHORITY_AUCTION] )
              else
                  if( strSalesMethod = METHOD_EXCLUSIVE ) then
                      strAuthority := Format( strAuthorityFormat,[EXPORT_AUTHORITY_EXCLUSIVE] )
                  else
                      strAuthority := Format( strAuthorityFormat,[EXPORT_AUTHORITY_SALE] );
              if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then
                     strAuthority := Format( strAuthorityFormat,[COMMERCIAL_LISTING_TYPE_SALE] )
          end;

          fPrice := FieldByName( 'WEB_PRICE' ).AsFloat;
          if Trunc(fPrice) <= 0 then
              fPrice := FieldByName( 'PRICE' ).AsFloat;
          nPrice := Trunc( fPrice );

          strSalePrice := '';
          strSoldDetails := '';
          strDateAvailable := '';
          strRentPrice := '';

          if  (strSalesMethod = METHOD_BOTH) then begin
              if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then begin
                  nPricePerYear := FieldByName( 'PRICE_PER_YEAR' ).AsInteger;
                  nCommercialRent := nPricePerYear;
                  strCommercialRent := Format( EXPORT_COMMERCIAL_RENT_PRICE,[nCommercialRent] );
              end
          end;

          if (strSalesMethod = METHOD_RENT)  then begin
               if( FieldByName( 'EXPIRY_DATE' ).IsNull = False ) then begin
                    dtDateAvailable := FieldByName( 'EXPIRY_DATE' ).AsDateTime;
                    str_DateAvailable := FormatDateTime( DATE_FORMAT,dtDateAvailable );
                    strDateAvailable := Format( EXPORT_DATE_AVAILABLE,[str_DateAvailable] );
               end
               else begin
                    dtDateAvailable := Date;
                    str_DateAvailable := FormatDateTime( DATE_FORMAT,dtDateAvailable );
                    strDateAvailable := Format( EXPORT_DATE_AVAILABLE,[str_DateAvailable] );
               end;

               if Trim(LowerCase(FieldByName('RENT_PERIOD').AsString)) ='pa' then
                  nRentWeek := Trunc( fPrice/52 )
               else
                  if Trim(LowerCase(FieldByName('RENT_PERIOD').AsString)) ='pm' then
                     nRentWeek := Trunc( fPrice*12/52 )
                  else
                     nRentWeek := Trunc( fPrice );
               if FieldByName('BOND').AsInteger <= 0 then
                  nBond := Trunc( nRentWeek / 7 * 365 / 12 )
               else
                  nBond := FieldByName('BOND').AsInteger;
               if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then begin
                    strRentPrice := '';
                    nPricePerYear := FieldByName( 'PRICE_PER_YEAR' ).AsInteger;
                    if( nPricePerYear > 0 ) then
                        nCommercialRent := nPricePerYear
                    else
                        nCommercialRent := Trunc( nRentWeek / 7 * 365 );
                    strCommercialRent := Format( EXPORT_COMMERCIAL_RENT_PRICE,[nCommercialRent] );
               end
               else begin
                    strCommercialRent := '';
                    strRentPrice := Format( EXPORT_RENT_PRICE, [nRentWeek,
                       nBond] );
               end;
               if Trim(FieldByName( 'PRICE_DESCRIPTION' ).AsString ) <> '' then begin
                  strPriceView := Xmlstr(FieldByName( 'PRICE_DESCRIPTION' ).AsString);
                  strSalePrice := Format( EXPORT_SALE_PRICE, [nPrice,
                      strPriceView] );
               end
               else begin
                 strSalePrice:= EXPORT_NO_SUBSTITUTE_PRICE;
               end;
          end   //end if (strSalesMethod = METHOD_RENT) or (strSalesMethod = METHOD_BOTH) then begin
          else  begin
               strPriceDescription := Trim(FieldByName( 'PRICE_DESCRIPTION' ).AsString );
               if( Length( strPriceDescription ) >  MAX_LENGTH_PRICE_DESCRIPTION ) then
                   strPriceDescription := StrUpTo( strPriceDescription,MAX_LENGTH_PRICE_DESCRIPTION );
               if( strPriceDescription = '' ) then
                   strPriceView := Format( '%.0m', [fPrice] )
               else
                   strPriceView := XmlStr( strPriceDescription );
               _DO_NOT_DISCLOSE:= FieldByName( 'DO_NOT_DISCLOSE' ).AsInteger;
               if  _DO_NOT_DISCLOSE <> 0 then
                  _DO_NOT_DISCLOSE:= 1;
               if( strStatus = STATUS_SOLD ) then begin
                    intSoldPrice:=  FieldByName('SOLD_PRICE').AsInteger;
                    if   intSoldPrice < 1000 then
                       intSoldPrice:= 1100;
                    strSoldDate := FormatDateTime( DATE_FORMAT,FieldByName( 'LAST_SOLD' ).AsDateTime );
                    if _DO_NOT_DISCLOSE = 1 then
                      strSoldDetails := Format( EXPORT_SOLD_DETAILS_DISPLAY_NO,[strSoldDate, intSoldPrice] )
                    else
                       strSoldDetails := Format( EXPORT_SOLD_DETAILS_DISPLAY_YES,[strSoldDate, intSoldPrice] )
               end;
               strSalePrice := Format( EXPORT_SALE_PRICE, [nPrice, strPriceView] );
          end;  //end ELSE >>>> if (strSalesMethod = METHOD_RENT) or (strSalesMethod = METHOD_BOTH) then begin

          strAddressDescription := Trim(
             FieldByName( 'ADDRESS_DESCRIPTION' ).AsString );

          //Ignore Address_Description ... Display orignal address
          (*if( strAddressDescription = '' ) then begin
              strAddressDisplay := ADDRESS_DISPLAY_YES
              strAddress := FieldByName( 'ADDRESS' ).AsString;
          else
              strAddressDisplay := ADDRESS_DISPLAY_NO;
          *)
          if Trim( strAddressDescription) = ''  then
             strAddressDisplay := ADDRESS_DISPLAY_YES
          else
             strAddressDisplay := ADDRESS_DISPLAY_NO;

          strAddress := FieldByName( 'ADDRESS' ).AsString ;

          _extraAddressInfo:= '';
          if  OfficeId = ELITE_REALESTATE then begin
              if strAddressDescription <> ''  then begin
                  strAddress:= strAddressDescription;
                  _pos:= pos('(',  strAddress);
                  if  _pos > 0 then begin
                     _extraAddressInfo:= copy(strAddress,_pos,255);
                     system.delete(strAddress,_pos,255);
                  end;
              end;
             strAddressDisplay := ADDRESS_DISPLAY_YES
          end;
          if  OfficeId = 2044  then begin    //Enrich Property Group
              if strAddressDescription <> ''  then begin
                  _tmpAddress:= strAddressDescription;
                  if Parse_Address( _tmpAddress, strUnitNumber, strStreetNumber,
                      strStreetName, strStreetType ) then begin
                    strAddress:= strAddressDescription;
                    strAddressDisplay := ADDRESS_DISPLAY_YES
                  end;
              end;
          end;
          Parse_Address( strAddress, strUnitNumber, strStreetNumber,
             strStreetName, strStreetType );

          if Trim(strStreetNumber) = '' then //RealEstate.com require a street number in the address anad that is why the "Valency Road" property was not displayed.
          begin                              //Spoke to Kirsten and he said there is a XML field to hide address and this is what people use if the do not want to show the address.
             strAddressDisplay := ADDRESS_DISPLAY_NO;
             strStreetNumber := '99';
          end;

          if( strUnitNumber = '' ) then
              strAddressNumber := strStreetNumber
          else
              strAddressNumber := strUnitNumber + '/' + strStreetNumber;


          strAddressNumber := XmlStr( strAddressNumber );
          strAddressStreet := RemoveCharNonAlpha_ExceptSpaceAndApostrophie( strStreetName ) +
             ' ' + RemoveCharNonAlpha( strStreetType );

          if( Length( strAddressNumber ) > ADDRESS_NUMBER_MAX_LEN ) then
          begin
               strAddressStreet := strAddressNumber + ' ' + strAddressStreet;
               strAddressNumber := '';
          end;

          strAddressStreet := XmlStr( strAddressStreet );

          if  OfficeId = ELITE_REALESTATE then begin
            strAddressStreet:= strAddressStreet+_extraAddressInfo;
          end;

          strSuburb :=  XmlStr( trim(FieldByName( 'SUBURB' ).AsString ));
          strPostcode := XmlStr( trim(FieldByName( 'POSTCODE' ).AsString) );

          strState := GetStateFromPostcode( strPostcode );

          strCombinedMapRef := Trim( FieldByName( 'MAP_REF' ).AsString );
          Parse_MapRef( strCombinedMapRef, strMapNumber, strMapRef );

          strUNDEROFFER:= 'no';
          if not FieldByName( 'UNDEROFFER' ).IsNull then
             if FieldByName('UNDEROFFER').AsInteger = 1 then
                  strUNDEROFFER:= 'yes';
          if( Length( FieldByName( 'ADVERTISING_TITLE' ).AsString ) > 1 ) then
              strHeadline := Trim( FieldByName( 'ADVERTISING_TITLE' ).AsString )
          else
              strHeadline := FieldByName( 'MUNICIPALITY' ).AsString;

          if( Length( strHeadline ) > ADVERTISING_TITLE_MAX_LEN ) then
              strHeadline := StrUpTo( strHeadline, ADVERTISING_TITLE_MAX_LEN );

          strHeadline := XmlStr( strHeadline );

          _PROPERTY_FEATURES:= '';
          _PROPERTY_FEATURES:= Trim( FieldByName( 'PROPERTY_FEATURES' ).AsString );
          _PROPERTY_FEATURES:= StringReplace(_PROPERTY_FEATURES,'openSpaces|Open*Spaces|1','openSpaces|Open*Spaces|0', [rfReplaceAll, rfIgnoreCase]);
          _PROPERTY_FEATURES:= StringReplace(_PROPERTY_FEATURES,'splitsystemAircon','splitSystemAirCon', [rfReplaceAll]);
          if _PROPERTY_FEATURES = '' then
             RealEstateDotComFeatureList.resetData
          else
             RealEstateDotComFeatureList.CommaText:= _PROPERTY_FEATURES;
          _PROPERTY_FEATURES:=  RealEstateDotComFeatureList.AsXML;


          strDescription := Trim( FieldByName( 'PRECIS_DESCRIPTION' ).AsString );
          if( strCombinedMapRef <> '' ) then
              strDescription := Format( '%s Melway Ref %s.',
                 [strDescription, strCombinedMapRef] );
          strDescription:= XmlStrLocal(strDescription);
          //strDescription:= AsciiToHTML(strDescription);

          strDescription:= format('<![CDATA[%s]]>',[strDescription]);
          _NUMBER_OF_TOILETS:= FieldByName( 'NUMBER_OF_TOILETS' ).AsInteger;
          if( ( strPropType <> MLS_PROP_TYPE_LAND ) and
              ( strPropType <> MLS_PROP_TYPE_COMMERCIAL ) ) then
          begin
               if( FieldByName( 'NUMBER_OF_BEDROOMS' ).IsNull = False ) then
               begin
                    nNumBedrooms := FieldByName( 'NUMBER_OF_BEDROOMS' ).AsInteger;
               end
               else
               begin
                    strNumBedrooms := Trim( FieldByName( 'NUM_BEDROOMS' ).AsString );
                    nNumBedrooms := StrToIntDef( strNumBedRooms, 0 );
               end;

               if( FieldByName( 'NUMBER_OF_BATHROOMS' ).IsNull = False ) then
               begin
                    nNumBathrooms := FieldByName( 'NUMBER_OF_BATHROOMS' ).AsInteger;
               end
               else
               begin
                    strNumBathrooms := Trim( FieldByName( 'BATHROOM1' ).AsString );
                    nNumBathrooms := StrToIntDef( strNumBathrooms, 0 );
               end;

               _TotalCars := FieldByName( 'NUMBER_OF_GARAGES' ).AsInteger;
               nNumGarages   := FieldByName( 'NUMBER_OF_CAR_SPACES' ).AsInteger;
               nCarPorts  := FieldByName( 'NUMBER_OF_CAR_PORTS' ).AsInteger;
               nOpenSpaces := _TotalCars - (nNumGarages+nCarPorts);
               if nOpenSpaces < 0 then
                  nOpenSpaces := 0;

               //nCarPorts := FieldByname( 'NUMBER_OF_CAR_PORTS' ).AsInteger;

               strAirConditioning := Trim( FieldByName( 'AIRCOND' ).AsString );
               nAirConditioning := StrToIntDef( strAirConditioning, 0 );
               if( nAirConditioning > 0 ) then
                   strAirConditioning := IntToStr( nAirConditioning )
               else
                   strAirConditioning := '';

               strHeating := XmlStr( Trim( FieldByName( 'HEATING' ).AsString ) );
               if( Pos( HEATING_GAS, strHeating ) > 0 ) then
                   strHeating := HEATING_GAS
               else
                   if( Pos( HEATING_ELECTRIC, strHeating ) > 0 ) then
                       strHeating := HEATING_ELECTRIC
                   else
                       if( Pos( HEATING_GDH, strHeating ) > 0 ) then
                           strHeating := HEATING_GDH
                       else
                           if( Pos( HEATING_SOLID, strHeating ) > 0 ) then
                               strHeating := HEATING_SOLID
                           else
                               if( Pos( HEATING_OTHER, strHeating ) > 0 ) then
                                   strHeating := HEATING_OTHER
                               else
                                   strHeating := '';

               strHotWaterService := XmlStr( Trim( FieldByName( 'HWS' ).AsString ) );
               if( Pos( HWS_GAS, strHotWaterService ) > 0 ) then
                   strHotWaterService := HWS_GAS
               else
                   if( Pos( HWS_ELECTRIC, strHotWaterService ) > 0 ) then
                       strHotWaterService := HWS_ELECTRIC
                   else
                       if( Pos( HWS_SOLAR, strHotWaterService ) > 0 ) then
                           strHotWaterService := HWS_SOLAR
                       else
                           strHotWaterService := '';
               if _ThisIsAStudio then
                   strResidentialFeatures := Format(
                      '    <features>'         + CRLF +
                      '      <bedrooms>Studio</bedrooms>'    + CRLF +
                      '      <bathrooms>%d</bathrooms>'  + CRLF +
                      '      <garages>%d</garages>'      + CRLF +
                      '      <carports>%d</carports>'    + CRLF +
                      '      <openSpaces>%d</openSpaces>'    + CRLF +
                      '      <airConditioning>%s</airConditioning>'  + CRLF +
                      '      <heating type="%s" />'                 + CRLF +
                      '      <hotWaterService type="%s" />'         + CRLF,
                      [
                        nNumBathrooms,
                        nNumGarages,
                        nCarPorts,
                        nOpenSpaces,
                        strAirConditioning,
                        strHeating,
                        strHotWaterService
                      ] )
               else
                   strResidentialFeatures := Format(
                      '    <features>'         + CRLF +
                      '      <bedrooms>%d</bedrooms>'    + CRLF +
                      '      <bathrooms>%d</bathrooms>'  + CRLF +
                      '      <garages>%d</garages>'      + CRLF +
                      '      <carports>%d</carports>'    + CRLF +
                      '      <openSpaces>%d</openSpaces>'    + CRLF +
                      '      <airConditioning>%s</airConditioning>'  + CRLF +
                      '      <heating type="%s" />'                 + CRLF +
                      '      <hotWaterService type="%s" />'         + CRLF,
                      [
                        nNumBedrooms,
                        nNumBathrooms,
                        nNumGarages,
                        nCarPorts,
                        nOpenSpaces,
                        strAirConditioning,
                        strHeating,
                        strHotWaterService
                      ] );
               if _NUMBER_OF_TOILETS > 0 then begin
                   strResidentialFeatures:=  strResidentialFeatures+
                     '<toilets>'+IntToStr(_NUMBER_OF_TOILETS)+'</toilets>';
                end;       
               strResidentialFeatures:= strResidentialFeatures + _PROPERTY_FEATURES+
                 '     </features>'+CRLF ;
               _allowances:=  RealEstateDotComFeatureList.AlowancesAsXML;
               strResidentialFeatures:=  strResidentialFeatures+
                   '  <allowances>'         + CRLF +
                   _allowances               + CRLF +
                   '  </allowances>'+CRLF ;

          end
          else
              strResidentialFeatures := '';

          try
                //str_LandArea := Trim( FieldByName( 'LAND_AREA' ).AsString );
                str_LandArea := Trim( FieldByName( 'LAND_AREA_QUANTITY' ).AsString );
                if( str_LandArea <> '' ) then
                begin
                     fLandArea := StrToFloat( str_LandArea );
                     strLandArea := Format( '%.2f', [fLandArea] );
                end
                else
                     strLandArea := '';
          except
                strLandArea := '';
          end;

          if( strPropType <> MLS_PROP_TYPE_LAND ) then
          begin
               try
                     str_BuildingArea := Trim(FieldByName( 'FLOOR_AREA' ).AsString );// Trim(FieldByName( 'BUILDING_AREA' ).AsString );
                     if( str_BuildingArea <> '' ) then
                     begin
                          fBuildingArea := StrToFloat( str_BuildingArea );
                          strBuildingArea := Format( '%.0f', [fBuildingArea] );
                     end
                     else
                         strBuildingArea := '';
               except
                     strBuildingArea := '';
               end;

               strBuildingDetails := Format( EXPORT_BUILDING_DETAILS,
                  [strBuildingArea] );
          end
          else
              strBuildingDetails := '';


          if( strSalesMethod = METHOD_AUCTION ) then
          begin
                if( FieldByName( 'AUCTION_DATE' ).IsNull ) then
                    strAuctionDate := ''
                else
                begin
                     try
                           if( FieldByName( 'AUCTION_TIME' ).IsNull ) then
                           begin
                                str_AuctionDate := FormatDateTime( DATE_FORMAT,
                                   FieldByName( 'AUCTION_DATE' ).AsDateTime );
                                strAuctionDate := Format( EXPORT_AUCTION_DATE,
                                   [str_AuctionDate] );
                           end
                           else
                           begin
                                str_AuctionTime :=
                                   FieldByName( 'AUCTION_TIME' ).AsString;
                                dtAuctionTime := StrToTime( str_AuctionTime );
                                strAuctionTime := FormatDateTime( TIME_FORMAT,
                                   dtAuctionTime );
                                str_AuctionDate := FormatDateTime( DATE_FORMAT,
                                   FieldByName( 'AUCTION_DATE' ).AsDateTime );
                                str_AuctionDate := Format( '%sT%s', [//Format( '%s-%s', [
                                   str_AuctionDate,  strAuctionTime] );
                                strAuctionDate := Format( EXPORT_AUCTION_DATE,
                                   [str_AuctionDate] );
                           end;
                     except
                           strAuctionDate := '';
                     end;
                end;
          end
          else
              strAuctionDate := '';

          with UserDetails do
          begin
               strAgentsLines := '';
               nNumAgents := 0;
               for i := 1 to AVAILABLE_LISTINGS_AGENTS do
               begin
                    strContactFieldName := Format( 'CONTACT_USER_ID%d', [i] );
                    nUserId := FieldByName( strContactFieldName ).AsInteger;
                    if( nUserId > 0 ) then
                    begin
                         GetUser( OfficeId, nUserId, UserDetails, bResult );
                         if( bResult = True ) then
                         begin
                              strLine := Format( EXPORT_LISTING_AGENT,
                                 [i,strAgentName, strAgentPhoneBH, strAgentMobile,
                                    strAgentEmail] );
                              strAgentsLines := strAgentsLines + strLine;
                              Inc( nNumAgents );
                              if( nNumAgents >= MAX_LISTINGS_AGENTS ) then
                                  break;
                         end;
                    end;
               end;
               if  nNumAgents = 1 then begin     // need to write empty to ensure contact 2 is removed if needed.
                  strAgentsLines := strAgentsLines +CRLF+
                      '<listingAgent id="2"> '+CRLF+
                      '<name></name> '+CRLF+
                      '<telephone></telephone> '+CRLF+
                      '<email></email> '+CRLF+
                      '</listingAgent> '+CRLF;
               end;

               if( strAgentsLines = '' ) then
               begin
                    nUserId := FieldByName( 'USER_ID' ).AsInteger;
                    if( nUserId > 0 ) then
                    begin
                         GetUser( OfficeId, nUserId, UserDetails, bResult );
                         if( bResult = True ) then
                         begin
                              strLine := Format( EXPORT_LISTING_AGENT,
                                 [1,strAgentName, strAgentPhoneBH, strAgentMobile,
                                    strAgentEmail] );
                              strAgentsLines := strAgentsLines + strLine;
                         end;
                    end;
               end;
          end;

          qryPropOFI.Close;
          qryPropOFI.SQL.Text := SQL_PROP_OFI;
          qryPropOFI.ParamByName( 'ID' ).AsInteger := Id;
          qryPropOFI.ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
          qryPropOFI.Open;
          qryPropOFI.FetchAll;

          if( qryPropOFI.RecordCount > 0 ) then
          begin
               strInspectionTimes := '';

               while( not ( qryPropOFI.EOF ) ) do
               begin
                    if( ( qryPropOFI.FieldByName( 'OFI_START' ).IsNull = False ) and
                        ( qryPropOFI.FieldByName( 'OFI_START' ).AsDateTime >= Now ) ) then
                    begin
                         strInspectionStart := FormatDateTime( 'dd-mmm-yyyy h:nnAM/PM',
                            qryPropOFI.FieldByName( 'OFI_START' ).AsDateTime );

                         if( qryPropOFI.FieldByName( 'OFI_END' ).IsNull = False ) then
                             strInspectionEnd := FormatDateTime( '" to "h:nnAM/PM',
                                qryPropOFI.FieldByName( 'OFI_END' ).AsDateTime )
                         else
                             strInspectionEnd := '';

                         strLine := Format( EXPORT_INSPECTION_LINE,
                            [strInspectionStart, strInspectionEnd] );
                         strInspectionTimes := strInspectionTimes + strLine;
                    end;

                    qryPropOFI.Next;
               end;
          end;

          strImages := Process_Images( Id, OfficeId );

          strPlans := Process_Plans( Id, OfficeId );

          if( ( strImages <> '' ) or ( strPlans <> '' ) ) then
              strObjects := Format( EXPORT_OBJECTS, [strImages,
                 strPlans] );
          _videoLink:=  get_VIDEO_ON_REA( Id, OfficeId );
          _StatementOfInformation := get_StatementOfInformation( Id, OfficeId );
          _OffMarket := '';
          // REA has a offmarket property status.
          if FieldByName('off_market').asInteger <> 0 then
             _OffMarket :=  CRLF +'<off_market>1</off_market>' + CRLF
          else
            _OffMarket :=  CRLF +'<off_market>0</off_market>'+ CRLF ;
          //_StatementOfInformation := get_StatementOfInformation( 184, 2071 ); // testing
          _videoLink := Format( EXPORT_VIDEOLINK_LINK, [_videoLink] );
          strVirtualTours := Process_Virtual_Tours( Id, OfficeId );
          S := Format( EXPORT_LINE, [
             strListingType, // should be rental or residential the category is taken care of seperately
             strDateTime,
             strStatus,
             strRcaAgentId,
             strPropertyId,
             strCommercialListingType,
             strAuthority,
             strAgentsLines,
             strDateAvailable,
             strRentPrice,
             strCommercialRent,
             strSalePrice,
             strAddressDisplay,
             strAddressNumber,
             strAddressStreet,
             strSuburb,
             strState,
             strPostcode,
             strMapNumber,
             strMapRef,
             strUNDEROFFER,
             strSeveralBusinessElements,
             strCategory,
             strBusinessSubCategory,
             strHeadline,
             strDescription,
             strResidentialFeatures,
             strSoldDetails,
             strLandArea,
             strBuildingDetails,
             strInspectionTimes,
             strAuctionDate,
             strVirtualTours,
             _videoLink,
             _StatementOfInformation,
             strObjects,
             _OffMarket,
             strListingType]);
          Result := s;
          if not AddToFiles then
            exit;
          if strRcaAgentId <> DUMMY_REA_CODE_NOT_TO_BE_SENT then
             ExportFile.Add( S );
          if OKforMillionPlus(OfficeId) then begin
             ExportMillionPlus.Add(s);
             inc(MillionPlusCount);
          end;
          if OKforActivePipe(OfficeId) then begin
             ExportActivePipe.Add(s);
             inc(ExportActivePipeCount);
          end;
          if OKforProEstate(OfficeId) then begin
             ExportProEstate.Add(s);
             inc(ExportProEstateCount);
          end;
          if OKforNickThorn(OfficeId, strListingType) then begin
             ExportNickThorn.Add(s);
             inc(ExportNickThornCount);
          end;


          if OKforExcel(OfficeId) then begin
             S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 IntToStr(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );

             ExportExcel.Add(s);
             inc(ExportExcelCount);
          end;
          if OKforOnTheHouse(OfficeId) then begin
              S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForOnTheHouse(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
             ExportOnTheHouse.Add(s);
             inc(ExportOnTheHouseCount);
          end;
          if OKforFletchers(OfficeId) then begin
              S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForFletchers(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
             ExportFletchers.Add(s);
             inc(ExportFletchersCount);
          end;

          if OKforRentBuy(OfficeId) then begin
              S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForRentBuy(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
             ExportRentBuy.Add(s);
             inc(ExportRentBuyCount);
          end;
          if OKforRentDotCom(OfficeId,Id, _TRANSLATED_ID_RENTDOTCOM) then begin
            strDescription:= StringReplace(strDescription,'<br />',#13#10,[rfReplaceAll, rfIgnoreCase]);   //0D 0A
            S := Format( EXPORT_LINE, [
             strListingType,strDateTime,strStatus,
             _TRANSLATED_ID_RENTDOTCOM,  //AgentID
             strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,strDateAvailable,strRentPrice,
             strCommercialRent,strSalePrice,strAddressDisplay,strAddressNumber,strAddressStreet,strSuburb,strState,
             strPostcode,strMapNumber,strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
             strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,strBuildingDetails,strInspectionTimes,
             strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
             ] );
            RentDotComListOfLists.AddItem(OfficeId,S);
          end;
          if DistributingToHomeHound AND OKforHomeHound(OfficeId) then begin
              S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 IntToStr(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportFileHomeHound.Add( S );
              inc(ExportHomeHoundCount);
          end;
          if OKforHomeSales(OfficeId) then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForHomeSales(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportHomeSales.Add( S );
              inc(ExportHomeSalesCount);
          end;


          if OKforPermitReady(OfficeId, strListingType) then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 strRcaAgentId,
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportPermitReady.Add( S );
              inc(ExportPermitReadyCount);
          end;

          if OKforInspectRealEstate(OfficeId) then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForInspectRealEstate(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportInspectRealEstate.Add( S );
              inc(ExportInspectRealEstateCount);
          end;

          if OKforrealEstateBookings(OfficeId, strListingType) then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForrealEstateBookings(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportrealEstateBookings.Add( S );
              inc(ExportRealEstateBookingsCount);
          end;



          if OKforRateMyAgent(OfficeId) then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForRateMyAgent(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportRateMyAgent.Add( S );
              inc(ExportRateMyAgentCount);
          end;
          if OKforACproperty(OfficeId) then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDACproperty(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportACproperty.Add( S );
              inc(ExportACpropertyCount);
          end;

          if OKforRentFind(OfficeId) and (pos('rent',lowercase(strListingType)) = 1)  then begin
            S := Format( EXPORT_LINE, [
                 strListingType,strDateTime,strStatus,
                 AgentIDForRentFind(OfficeId), //this is replacing the Agent ID
                 strPropertyId,strCommercialListingType,strAuthority,strAgentsLines,
                 strDateAvailable,strRentPrice,strCommercialRent,strSalePrice,strAddressDisplay,
                 strAddressNumber,strAddressStreet,strSuburb,strState,strPostcode,strMapNumber,
                 strMapRef,strUNDEROFFER,strSeveralBusinessElements,strCategory,strBusinessSubCategory,
                 strHeadline,strDescription,strResidentialFeatures,strSoldDetails,strLandArea,
                 strBuildingDetails,strInspectionTimes,strAuctionDate,strVirtualTours,_videoLink,_StatementOfInformation,strObjects,'',strListingType
                 ] );
              ExportRentFind.Add( S );
              inc(ExportRentFindCount);
          end;
     end;
end;

function get_StatementOfInformation( const nId, nOfficeId: Integer ): String;
(*
<media>
   <attachment usage=”statementOfInformation” contentType=”application/pdf” id=”da39a3ee5e6b4b0d3255bfef95601890afd80709? url=”http://www.example.com/statementofinformation.pdf” >
   </attachment>
</media>
_linkURL:= IntToStr(length(IntToSTr(propLinkSetup.AgentId)))
        +  IntToSTr(propLinkSetup.AgentId)
        +  IntToSTr(frmData_Module.mtbProperty_Details.FieldByName('ID').AsInteger*2)
        +  IntToSTr(propLinkSetup.AgentId*2)
        +  IntToSTr(frmData_Module.mtbProperty_Details.FieldByName('ID').AsInteger)
        +  IntToSTr(length(IntToStr(frmData_Module.mtbProperty_Details.FieldByName('ID').AsInteger)));
       _linkURL := 'http://www.multilink.com.au//scripts/statementofinformation.dll/getlink?lid='+_linkURL;
*)
var attachement_id, attachment_url: string;
begin
  result :=
    '<media> '+#13+
    '</media> '+#13;
  with frmMain.qryWorker do
  begin
    close;
    SQL.Text := 'select  doc_id, office_id, id, user_id, title, file_size, filename, computername, last_changed, doc_type '
                +'from prop_doc_special where id = :id and office_Id =  :office_Id and doc_type = ''STATEMENT_OF_INFORMATION''';
    ParamByName('id').AsInteger :=  nId;
    ParamByName('office_Id').AsInteger :=  nOfficeId;
    open;
    if not EOF then begin
      attachement_id := fieldbyName('id').AsString+'-'+fieldbyName('office_id').AsString+'-'+fieldbyName('last_changed').AsString;
      attachment_url:= IntToStr(length(IntToSTr(nOfficeId)))
        +  IntToSTr(nOfficeId)
        +  IntToSTr(nId*2)
        +  IntToSTr(nOfficeId*2)
        +  IntToSTr(nId)
        +  IntToSTr(length(IntToStr(nId)));
       attachment_url := 'http://www.multilink.com.au//scripts/statementofinformation.dll/getlink?lid='+attachment_url;
       result :=
          '<media> '+#13+
          '  <attachment usage="statementOfInformation" contentType="application/pdf" id="'+attachement_id+'" url="'+attachment_url+'" > '+#13+
          '  </attachment> '+#13+
          '</media> '+#13;
    end;
    close;
  end;
end;

function get_VIDEO_ON_REA( const nId, nOfficeId: Integer ): String;
var
   _videos:String;
begin
     with frmMain.qryPropWebLinks do
     begin
          Close;
          SQL.Text :=
                'SELECT  ' +
                '   LINK_URL, ' +
                '   LINK_TYPE ' +
                'FROM PROP_WEB_LINKS ' +
                'WHERE  ID = :ID  AND  OFFICE_ID = :OFFICE_ID  ' +
                'AND LINK_TYPE = ''VIDEO ON REA'' '+
                'ORDER BY LINK_ID ' ;
          ParamByName( 'ID' ).AsInteger := nId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;
          Open;
          FetchAll;
          _videos := '';
          if not (EOF and BOF) then begin
             _videos := FieldByName( 'LINK_URL' ).AsString;
             _videos := XmlStr( _videos );
          end;
          close;
          Result := _videos;
     end;
end;


function Process_Virtual_Tours( const nId, nOfficeId: Integer ): String;
var
   strTours, strLinkUrl, strLine: String;
   i, j: Integer;
begin
     with frmMain.qryPropWebLinks do
     begin
          Close;
          SQL.Text :=
                'SELECT  ' +
                '   LINK_URL, ' +
                '   LINK_TYPE ' +
                'FROM PROP_WEB_LINKS ' +
                'WHERE  ID = :ID  AND  OFFICE_ID = :OFFICE_ID  ' +
                'AND LINK_TYPE <> ''VIDEO ON REA'' '+
                'ORDER BY LINK_ID ' ;

          ParamByName( 'ID' ).AsInteger := nId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;

          Open;
          FetchAll;

          i := 0;
          strTours := '';

          while( EOF = False ) do
          begin
               if( i >= MAX_NUM_VIRTUAL_TOURS ) then
                   break;

               strLinkUrl := FieldByName( 'LINK_URL' ).AsString;
               strLinkUrl := XmlStr( strLinkUrl );
               strLine := Format( EXPORT_EXTERNAL_LINK,
                  [strLinkUrl] );

               strTours := strTours + strLine;

               Inc( i );

               Next;
          end;

          for j := i to MAX_NUM_VIRTUAL_TOURS - 1 do
          begin
               strLinkUrl := '';
               strLine := Format( EXPORT_EXTERNAL_LINK,
                  [strLinkUrl] );

               strTours := strTours + strLine;
          end;

          Close;

          Result := strTours;
     end;
end;

function Process_Plans( const nId, nOfficeId: Integer ): String;
var
   nImageId, nImageOrder, i, j: Integer;
   strPlans, strOriginalFilename, strFilename, strImageUrl, strDateTime,
      strLine: String;
   bResult: Boolean;
begin
     with frmMain.qryPropImage do
     begin
          Close;
          SQL.Text :=
                'SELECT   ' +
                '   IMAGE_ID,  ' +
                '   IMAGE_ORDER, ' +
                '   ORIGINAL_FILENAME ' +
                'FROM PROP_IMAGE   ' +
                'WHERE ID = :ID AND  OFFICE_ID = :OFFICE_ID  AND  CATEGORY = :CATEGORY  ' +
                'ORDER BY IMAGE_ORDER                                                ' ;


          ParamByName( 'ID' ).AsInteger := nId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;
          ParamByName( 'CATEGORY' ).AsString := CATEGORY_FLOORPLAN;

          Open;
          FetchAll;

          i := 0;
          strPlans := '';

          while( EOF = False ) do
          begin
               if( i >= MAX_NUM_PLANS ) then
                   break;

               nImageId := FieldByName( 'IMAGE_ID' ).AsInteger;
               nImageOrder := FieldByName( 'IMAGE_ORDER' ).AsInteger;
               strOriginalFilename := FieldByName( 'ORIGINAL_FILENAME' ).AsString;
               strOriginalFilename := RemoveCharNonAlphaNum_ExceptThis(
                  strOriginalFilename, '.' );

               Process_Plan( nImageId, nId, nOfficeId, nImageOrder,
                  strOriginalFilename, strFilename, bResult );

               if( bResult = True ) then
               begin
                    strImageUrl := Format( IMAGES_PUBLIC_URL, [strFilename] );
                    strDateTime := FormatDateTime( TIMESTAMP_FORMAT, Now );
                    strLine := Format( EXPORT_FLOORPLANS_LINE,
                       [i + 1, strDateTime, strImageUrl] );

                    strPlans := strPlans + strLine;

                    Inc( i );
               end;

               Next;
          end;

          for j := i to MAX_NUM_PLANS - 1 do
          begin
               strImageUrl := '';
               strDateTime := FormatDateTime( TIMESTAMP_FORMAT, Now );
               strLine := Format( EXPORT_FLOORPLANS_LINE,
                  [j + 1, strDateTime, strImageUrl] );

               strPlans := strPlans + strLine;
          end;

          Close;

          Result := strPlans;
     end;
end;

procedure Process_Plan( const nImageId, nId, nOfficeId, nImageOrder: Integer;
   const strOriginalFilename: String; var outFilename: String;
   var outResult: Boolean );
var
   bResult: Boolean;
   fldPhotoField: TBlobField;
   nFileType: Integer;
   strFilename: String;
   nImage_File_Id : Integer;
begin
     with frmMain.qryPropImageFile do
     begin
          outResult := False;

          Close;
          SQL.Text :=
              'SELECT ' +
              '   IMAGE_FILE_ID,  ' +
              '   IMAGE_FILE    ' +
              'FROM             ' +
              '   PROP_IMAGE_FILE ' +
              'WHERE IMAGE_ID = :IMAGE_ID AND ID = :ID AND OFFICE_ID  = :OFFICE_ID  ' ;
          ParamByName( 'IMAGE_ID' ).AsInteger := nImageId;
          ParamByName( 'ID' ).AsInteger := nId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;

          Open;
          FetchAll;

          if( RecordCount <= 0 ) then
          begin
               exit;
          end;

          GetFileTypeByExtension( strOriginalFilename, nFileType );

          fldPhotoField  := FieldByName( 'IMAGE_FILE' ) as TBlobField;
          nImage_File_Id := FieldByName( 'IMAGE_FILE_ID' ).AsInteger;
          if( Length( fldPhotoField.AsString ) > MIN_PHOTO_SIZE ) then
          begin
               if( nFileType = FILE_TYPE_JPEG ) then
               begin
                    bResult := SavePlan( nId, nOfficeId, nImageOrder,nImage_File_Id,
                       fldPhotoField, strFilename );

                    if( bResult = True ) then
                    begin
                         outResult := True;
                         outFilename := strFilename;
                    end;
               end;
          end;

          Close;
     end;
end;

function Process_Images( const nId, nOfficeId: Integer ): String;
var
   nImageId, nImageOrder, i, j, nAlpha: Integer;
   strImages, strFilename, strImageUrl, strLine, strImageId, strDateTime: String;
   bResult: Boolean;
begin
     with frmMain.qryPropImage do
     begin
          Close;
          SQL.Text := SQL_PROP_IMAGE;

          ParamByName( 'ID' ).AsInteger := nId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;
          ParamByName( 'CATEGORY' ).AsString := CATEGORY_PHOTOGRAPH;

          Open;
          FetchAll;

          i := 0;
          strImages := '';

          while( EOF = False ) do
          begin
               if( i >= MAX_NUM_PHOTOS ) then
                   break;

               nImageId := FieldByName( 'IMAGE_ID' ).AsInteger;
               nImageOrder := FieldByName( 'IMAGE_ORDER' ).AsInteger;

               Process_Image( nImageId, nId, nOfficeId, nImageOrder,
                  strFilename, bResult );

               if( bResult = True ) then
               begin
                    strImageId := Get_Rca_Image_Id( i );

                    strImageUrl := Format( IMAGES_PUBLIC_URL, [strFilename] );
                    strDateTime := FormatDateTime( TIMESTAMP_FORMAT, Now );

                    strLine := Format( EXPORT_IMAGES_LINE,
                       [strImageId, strDateTime, strImageUrl] );

                    strImages := strImages + strLine;

                    Inc( i );
               end;

               Next;
          end;

          for j := i to MAX_NUM_PHOTOS - 1 do
          begin
               strImageId := Get_Rca_Image_Id( j );


               {if( j = 0 ) then
                   strImageUrl := IMAGE_NOT_AVAILABLE
               else
                   strImageUrl := '';}

               strImageUrl := '';
                   
               strDateTime := FormatDateTime( TIMESTAMP_FORMAT, Now );

               strLine := Format( EXPORT_IMAGES_LINE,
                  [strImageId, strDateTime, strImageUrl] );

               strImages := strImages + strLine;
          end;

          Close;

          Result := strImages;
     end;
end;

procedure Process_Image( const nImageId, nId, nOfficeId, nImageOrder: Integer;
   var outFilename: String; var outResult: Boolean );
var
   bResult: Boolean;
   strFilename: String;
   fldPhotoField: TBlobField;
   nImage_File_Id : Integer;
begin
     with frmMain.qryPropImageFile do
     begin
          outResult := False;

          Close;
          SQL.Text := SQL_PROP_IMAGE_FILE;

          ParamByName( 'IMAGE_ID' ).AsInteger := nImageId;
          ParamByName( 'ID' ).AsInteger := nId;
          ParamByName( 'OFFICE_ID' ).AsInteger := nOfficeId;
          ParamByName( 'RESOLUTION_TYPE' ).AsString := RESOLUTION_WEB;

          Open;
          FetchAll;

          if( RecordCount <= 0 ) then
          begin
               exit;
          end;

          fldPhotoField := FieldByName( 'IMAGE_FILE' ) as TBlobField;
          nImage_File_Id := FieldByName( 'IMAGE_FILE_ID' ).AsInteger;
          if( Length( fldPhotoField.AsString ) > MIN_PHOTO_SIZE ) then
          begin
               bResult := SavePhoto( nId, nOfficeId, nImageOrder,nImage_File_Id,
                  fldPhotoField,strFilename );

               if( bResult = True ) then
               begin
                    outFilename := strFilename;
                    outResult := True;
               end;
          end;

          Close;
     end;
end;

function Get_Rca_Image_Id( const nImageIndex: Integer ): String;
const
     LOWER_CASE_M = 109;
var
   nAlpha: Integer;
begin
     if( nImageIndex = 0 ) then
         nAlpha := LOWER_CASE_M
     else
     begin
          nAlpha := ALPHA_BASE + nImageIndex - 1;

          if( nAlpha >= LOWER_CASE_M ) then
              nAlpha := nAlpha + 1;
     end;

     Result := Char( nAlpha );
end;

procedure GetPropTypes( const Id, OfficeId: Integer; var outPropType_Array:
   Array of string; var outResult: Boolean );
var
   i: integer;
begin
     with frmMain.qryPropDistCategory do
     begin
          Close;
          SQL.Text := SQL_PROP_DIST_CATEGORY;
          ParamByName( 'ID' ).AsInteger := Id;
          ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
          ParamByName( 'CATEGORY_NAME_DIST_ID' ).AsInteger := DIST_ID;
          Open;
          FetchAll;
          First;

          outResult := False;
          i := 0;

          while( EOF = False ) do
          begin
               outPropType_Array[i] := XmlStr(
                  FieldByName( 'CATEGORY_NAME_DIST_CODE' ).AsString );
               outResult := True;

               Inc( i );
               if( i > MAX_PROPERTY_TYPES - 1 ) then
                   break;

               Next;
          end;
     end;
end;

procedure GetUser( const nOfficeId, nUserId: Integer;
   var outUserDetails: TUserDetails; var outResult: Boolean );
begin
     with frmMain.qryUsers, outUserDetails do
     begin
          SQL.Text := SQL_USERS;
          ParamByName( 'USER_OFFICE_ID' ).AsInteger := nOfficeId;
          ParamByName( 'USER_ID' ).AsInteger := nUserId;
          Open;
          FetchAll;

          if( RecordCount > 0 ) then
          begin
               strAgentName := XmlStr( FieldByName( 'FULL_NAME' ).AsString );
               strAgentPhoneBH := XmlStr( FieldByName( 'USER_PHONE_BH' ).AsString );
               strAgentMobile := XmlStr( FieldByName( 'USER_MOBILE' ).AsString );
               strAgentEmail := XmlStr( FieldByName( 'USER_EMAIL' ).AsString );

               outResult := True;
          end
          else
              outResult := False;

          Close;
     end;
end;

function SavePhoto( Id, OfficeId, PhotoNum,Image_File_Id: Integer; Photo: TBlobField;
   var outFilename: String ): Boolean;
var
   strFilename: String;
begin
     Result := False;
     try
           outFilename := Format( '%d_%d_%d_%d.jpg', [OfficeId, Id, PhotoNum,Image_File_Id] );
           strFilename := IMAGES_DIR + outFilename;
           ( Photo as TBlobField ).SaveToFile( strFilename );

           Result := True;
     except
           Log( Format( 'Error on photo %d - ImageFileId %d, Property ID %d, Office ID %d',
              [PhotoNum,Image_File_Id, Id, OfficeId] ) );
     end;
end;

function SavePlan( Id, OfficeId, PhotoNum,Image_File_Id: Integer; Photo: TBlobField;
   var outFilename: String ): Boolean;
begin
     Result := False;
     try
           outFilename := Format( '%d_%d_%d_%d_floorplan.gif', [OfficeId, Id, PhotoNum,Image_File_Id] );
           BlobJpeg_SaveAsGIF( Photo, IMAGES_DIR + outFilename );
           Result := True;
     except
           Log( Format( 'Error on floorplan %d - ImageFileId=%d, Property ID %d, Office ID %d',
              [PhotoNum,Image_File_Id, Id, OfficeId] ) );
     end;
end;

procedure ExportTable_InsertUpdate;
var
     Id, OfficeId: integer;
     bExists, bSold, bValid: Boolean;
     LastChanged, Export_LastChanged: TDateTime;
     strPropType, strSalesMethod, strListingType: String;
     _PropLastChanged: TPropLastChanged;
     _InterNetID: INTEGER;
     _UNIQUE_REA_ID: string;
begin
     with frmMain do
     begin
          qryProp.First;
          qryExport.First;
          while( not( qryProp.EOF ) ) do
          begin
               Id := qryProp.FieldByName( 'ID' ).AsInteger;
               OfficeId := qryProp.FieldByName( 'OFFICE_ID' ).AsInteger;
               _InterNetID:= 0;
               _UNIQUE_REA_ID:= '';
               LastChanged := qryProp.FieldByName( 'LAST_CHANGED' ).AsDateTime;
               _PropLastChanged:= PropLastChangedList.findItem(Id, OfficeId);
               if _PropLastChanged <> nil then  //it was updated during this job
                  if _PropLastChanged.LastChanged < LastChanged then  begin// it must have been update from site during actual transfer job
                     LastChanged:= _PropLastChanged.LastChanged;   // because the new lastchanged date is greater than then original lastchanged date
                  end;
               bExists := qryExport.Locate( 'ID;OFFICE_ID',
                  VarArrayOf([Id, OfficeId]), [] );

               strPropType := qryProp.FieldByName( 'PROPERTY_TYPE' ).AsString;
               strSalesMethod := qryProp.FieldByName( 'SALES_METHOD' ).AsString;
               if( strSalesMethod = METHOD_RENT ) then
               begin
                    if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then
                        strListingType := LISTING_TYPE_COMMERCIAL
                    else
                        strListingType := LISTING_TYPE_RENTAL;
               end
               else
                   if( strPropType = MLS_PROP_TYPE_LAND ) then
                       strListingType := LISTING_TYPE_LAND
                   else
                       if( strPropType = MLS_PROP_TYPE_COMMERCIAL ) then
                           strListingType := LISTING_TYPE_COMMERCIAL
                       else
                           if sameText(strPropType,MLS_PROP_TYPE_BUSINESS) then
                              strListingType := LISTING_TYPE_BUSINESS
                           else
                              strListingType := LISTING_TYPE_RESIDENTIAL;
               if( bExists = True ) then
               begin
                    Export_LastChanged :=
                       qryExport.FieldByName( 'LAST_CHANGED' ).AsDateTime;
                    if( LastChanged <> Export_LastChanged ) then
                        ExportTable_Update(Id, OfficeId, LastChanged,
                           strListingType );
               end
               else
               begin
                    CheckPropSold( Id, OfficeId, bSold, bValid );
                    // dont create a new ad if it's sold
                    if( bSold = False ) then  BEGIN
                        _UNIQUE_REA_ID:=  qryProp.FieldByName( 'UNIQUE_REA_ID' ).asstring;
                        ExportTable_Insert(Id, OfficeId, LastChanged,
                           strListingType,_UNIQUE_REA_ID );
                    END;
               end;

               qryProp.Next;
          end;
     end;
end;

procedure ExportTable_Delete;
var
   Id, OfficeId: integer;
   bExists, bSold, bValid: Boolean;
begin
     with frmMain do
     begin
          qryProp.First;
          qryExport.First;
          while( not( qryExport.EOF ) ) do
          begin
               Id := qryExport.FieldByName( 'ID' ).AsInteger;
               OfficeId := qryExport.FieldByName( 'OFFICE_ID' ).AsInteger;
               bExists := qryProp.Locate( 'ID;OFFICE_ID',
                  VarArrayOf([Id, OfficeId]), [] );
               if( bExists = False ) then
               begin
                    CheckPropSold( Id, OfficeId, bSold, bValid );
                    ExportTable_DeleteProp( Id, OfficeId );
               end;

               qryExport.Next;
          end;
     end;
end;

procedure ExportTable_DeleteProp( const Id, OfficeId: Integer );
begin
     with frmMain.qryDelete do
     begin
          SQL.Text :=
               'DELETE DIST_EXPORT2                                          ' +
               'WHERE                                                        ' +
               '      ID                   =    :ID                          ' +
               '  AND                                                        ' +
               '      OFFICE_ID            =    :OFFICE_ID                   ' +
               '  AND                                                        ' +
               '      DIST_ID              =    :DIST_ID                     ' ;
          ParamByName( 'ID' ).AsInteger := Id;
          ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
          ParamByName( 'DIST_ID' ).AsInteger := DIST_ID;
          ExecSQL;
     end;
end;

procedure ExportTable_Insert(  const Id, OfficeId: Integer;
   const LastChanged: TDateTime;
   const strListingType: String; _UNIQUE_REA_ID: string );
begin
     with frmMain.qryInsert do
     begin
          SQL.Text :=
               'INSERT INTO DIST_EXPORT2                                     ' +
               '   (                                                         ' +
               '      ID,                                                    ' +
               '      OFFICE_ID,                                             ' +
               '      DIST_ID,                                               ' +
               '      LAST_CHANGED,                                          ' +
               '      LAST_INSERT,                                           ' +
               '      LISTING_TYPE, UNIQUE_REA_ID ' +
               '   )                                                         ' +
               'VALUES                                                       ' +
               '   (                                                         ' +
               '      :ID,                                                   ' +
               '      :OFFICE_ID,                                            ' +
               '      :DIST_ID,                                              ' +
               '      :LAST_CHANGED,                                         ' +
               '      :LAST_INSERT,                                          ' +
               '      :LISTING_TYPE,:UNIQUE_REA_ID ' +
               '   )                                                         ' ;;
          ParamByName( 'ID' ).AsInteger := Id;
          ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
          ParamByName( 'DIST_ID' ).AsInteger := DIST_ID;
          ParamByName( 'LAST_CHANGED' ).AsDateTime := LastChanged;
          ParamByName( 'LAST_INSERT' ).AsDateTime := Now;
          ParamByName( 'LISTING_TYPE' ).AsString := strListingType;
          ParamByName( 'UNIQUE_REA_ID' ).AsString := _UNIQUE_REA_ID;
          ExecSQL;
     end;
end;

procedure ExportTable_Update(  const Id, OfficeId: Integer;
   const LastChanged: TDateTime;
   const strListingType: String );
begin
     with frmMain.qryUpdate do
     begin
          SQL.Text :=
              'UPDATE DIST_EXPORT2 SET                                      ' +
               '      LAST_CHANGED         =    :LAST_CHANGED,               ' +
               '      LISTING_TYPE         =    :LISTING_TYPE                ' +
               'WHERE                                                        ' +
               '      ID                   =    :ID                          ' +
               '  AND                                                        ' +
               '      OFFICE_ID            =    :OFFICE_ID                   ' +
               '  AND                                                        ' +
               '      DIST_ID              =    :DIST_ID                     ' ;
          ParamByName( 'ID' ).AsInteger := Id;
          ParamByName( 'OFFICE_ID' ).AsInteger := OfficeId;
          ParamByName( 'DIST_ID' ).AsInteger := DIST_ID;
          ParamByName( 'LAST_CHANGED' ).AsDateTime := LastChanged;
          ParamByName( 'LISTING_TYPE' ).AsString := strListingType;
          ExecSQL;
     end;
end;

function CreateZipFile: String;
var
     strZipFilename, strName, strExt: String;
begin
     with frmMain.zipText do
     begin
          FilenameParts( strFilename, strName, strExt );
          strZipFilename := strName + '.zip';
          ZipName := WorkDir + strZipFilename;
          RootDir := IniDir;
          FilesList.Add( IniDir + '*.*' );
          Zip;
          Result := ZipName;
     end;
end;

procedure ClearWorkDir;
begin
     DeleteFiles( WorkDir + '*.*' );
     DeleteFiles( IniDir + '*.*' );
     // dont delete images because they retrieve them one by one off our site,
     // and if we do two runs before they process the first one, the first one
     // will fail
     //DeleteFiles( ImagesDir + '*.*' );
end;

function MoveZipFile( strFilename: String ): String;
var
   str_Filename: String;
begin
     FileMove( strFilename, ExportDir );
     str_Filename := ExtractFileName( strFilename );
     Result := ExportDir + str_Filename;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   i      : Integer;
begin
     TestMode:= False;
     debugMode:= False;
     RentDotComListOfLists:= TRentDotComListOfLists.Create;
     RealEstateDotComFeatureList:= TRealEstateDotComFeatureList.create;
     PropLastChangedList:= TPropLastChangedList.Create;
     Timer1.Enabled:= False;
     for i:= 0 to ParamCount do begin
       if UpperCase(ParamStr(i)) = '-DEBUG' then begin
          debugMode:= tRUE;
          memLog.Lines.Add('Debug Mode: ON')
       end;
       if UpperCase(ParamStr(i)) = '-TEST' then begin
          TestMode:= True;
          MessageDlg('You are in test mode files will not be sent to RealEstate.Components.au',mtInformation,[mbok],0);
       end;
     end;
     Timer1.Enabled:= True;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
   PropLastChangedList.Free;
   ExportFile.Free;
   ExportHomeSales.Free;
   ExportInspectRealEstate.Free;
   ExportPermitReady.free;
   ExportRealEstateBookings.Free;
   ExportNickThorn.Free;
   ExportRateMyAgent.Free;
   ExportActivePipe.Free;
   ExportProEstate.Free;
   ExportExcel.Free;
   ExportOnTheHouse.Free;
   ExportRentBuy.Free;
   ExportFletchers.Free;
   ExportFileHomeHound.Free;
   ExportMillionPlus.Free;
   RentDotComListOfLists.Free;
   RealEstateDotComFeatureList.Free;
   ExportACProperty.Free;
   ExportRentFind.Free;

end;

{ TRentDotComListOfLists }

procedure TRentDotComListOfLists.AddItem(_Office_id: integer; s: string);
const
     _RENT_EXPORT_HEADER =
        '<?xml version="1.0" standalone="no"?>'                                             + CRLF +
        ''                                                                                  + CRLF +
        '<!DOCTYPE propertyList SYSTEM "propertyList.dtd">' + CRLF +
        ''                                                                                  + CRLF +
        '<propertyList date="%s" username="%s" password="%s">'                              + CRLF ;

var i: integer;
    _RentDotComList: TRentDotComList;
    _DateTime, _Header: STRING;
begin
  //s is a raw
  for i:= 0 to count-1 do begin
     _RentDotComList:= getItem(i);
     if  _RentDotComList = Nil then
       continue;
     if _RentDotComList.Office_id =  _Office_id then begin
       _RentDotComList.Add(s);
       exit;
     end;
  end;
  // ran through list and Office_Id not found so need to add
  _RentDotComList:= TRentDotComList.Create;
  _RentDotComList.Office_id:=  _Office_id;
  _DateTime := FormatDateTime( TIMESTAMP_FORMAT, Now );
  _Header := Format( _RENT_EXPORT_HEADER, [_DateTime,MULTILINK_USERNAME, MULTILINK_PASSWORD] );
  _RentDotComList.Add( _Header );
  _RentDotComList.Add(s);
  Add(_RentDotComList);
(*
TRentDotComList = class(TstringList)
     Office_id: integer;
  end;

  *)
end;

function TRentDotComListOfLists.getItem(_idx: integer): TRentDotComList;
begin
   Result:= Nil;
   if _idx < 0 then
     exit;
   if _idx >= Count then
     exit;
   Result:= TRentDotComList(Items[_idx]);
end;

function TfrmMain.OKforRentDotCom(_office_id, _id: integer; var _TRANSLATED_ID: string): boolean;
begin
   _TRANSLATED_ID:= '';
   Result:= False;
   with qryWorker do begin
     close;
     SQL.Text:=
        'select A.TRANSLATED_ID,A.OFFICE_ID,B.ID FROM DIST_AGENCY_ID_TRANSLATION A '+
        'join PROP B ON A.OFFICE_ID = B.OFFICE_ID AND A.DIST_ID = 30 '+
        'WHERE '+
        '( '+
        'B.DISTRIBUTOR1 = 30 '+
        'OR B.DISTRIBUTOR2 = 30 '+
        'OR B.DISTRIBUTOR3 = 30 '+
        'OR B.DISTRIBUTOR4 = 30 '+
        'OR B.DISTRIBUTOR5 = 30 '+
        'OR B.DISTRIBUTOR6 = 30 '+
        'OR B.DISTRIBUTOR7 = 30 '+
        'OR B.DISTRIBUTOR8 = 30 '+
        'OR B.DISTRIBUTOR9 = 30 '+
        'OR B.DISTRIBUTOR10 = 30 '+
        ') '+
        'AND B.ID = :id AND B.OFFICE_ID = :OFFICE_ID and b.SALES_METHOD = ''Rent'' ';
     ParamByname('OFFICE_ID').AsInteger:= _office_id;
     ParamByname('id').AsInteger:= _id;
     open;
     if not (EOF and BOF) then begin
       Result:= True;
       _TRANSLATED_ID:= Fields[0].AsString;
     end;
     close;
   end;
end;

end.


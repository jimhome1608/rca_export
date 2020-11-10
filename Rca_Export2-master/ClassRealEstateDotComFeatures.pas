unit ClassRealEstateDotComFeatures;

interface
uses Classes, SysUtils, hyperStr;

type
  TRealEstateDotComFeatureList = class(TStringList)
     slFields: TStringList;
     function AsXML: string;//eg <alarmSystem>0</alarmSystem>
     function AlowancesAsXML: string;//eg <alarmSystem>0</alarmSystem>
     function HasStudy: boolean;
     function getRecord(_FeatureLabel: string): string;
     function findRecord(_FeatureLabel: string): integer;
     function getRecordByIndex(_index: integer): string;
     function getCaptionByIndex(_index: integer): string;
     function getValueByIndex(_index: integer): string;
     procedure writeBooleanValue(_index: integer; _value: boolean);
     procedure writeEnergyRatingValue(_value: double);
     procedure resetData;
     procedure dumpToFile;
     procedure readFromFile;
     constructor create;
     destructor destroy;
  end;


implementation
const  CRLF = #13 + #10;

procedure TRealEstateDotComFeatureList.resetData;
const BASIC_DATA =
      'remoteGarage|Remote*Garage|0,secureParking|Secure*Parking|0,study|Study|0,'+
      'dishwasher|Dishwasher|0,builtInRobes|Built*in*Robes|0,gym|Gym|0,'+
      'workshop|Work*Shop|0,rumpusRoom|Rumpus*Room|0,floorboards|Floor*Boards|0,'+
      'broadband|Broadband|0,payTV|Pay*TV|0,ductedHeating|Ducted*Heating|0,'+
      'ductedCooling|Ducted*Cooling|0,splitsystemHeating|Split*System*Heating|0,hydronicHeating|Hydronic*Heating|0,'+
      'splitSystemAirCon|Split*System*Air*Condition|0,gasHeating|Gas*Heating|0,reverseCycleAircon|Reverse*Cycle*Air*Conditioning|0,'+
      'evaporativeCooling|Evaporative*Cooling|0,airConditioning|Air*Conditioning|0,alarmSystem|Alarm*System|0,'+
      'vacuumSystem|Vacuum*System|0,intercom|Intercom|0,pool|Pool|0,'+
      'poolInGround|Pool*In*Ground|0,poolAboveGround|Pool*Above*Ground|0,spa|Spa|0,'+
      'tennisCourt|Tennis*Court|0,balcony|Balcony|0,deck|Deck|0,'+
      'courtyard|Court*Yard|0,outdoorEnt|Outdoor*Entertaining|0,shed|Shed|0,'+
      'fullyFenced|Fully*Fenced|0,openFirePlace|Open*Fire*Place|0,'+
      'heating|Heating|0,hotWaterService|Hot*Water*Service|0,insideSpa|Inside*Spa|0,outsideSpa|Outside*Spa|0,'+
      'solarPanels|Solar*Panels|0,solarHotWater|Solar*Hot*Water|0,waterTank|Water*Tank|0,greyWaterSystem|Grey*Water*System|0,'+
      'petFriendly|Pet*Friendly|0,furnished|Furnished|0,smokers|Smoking*Permitted|0,'+
      'zzz1|zzz|0,zzz2|zzz|0,zzz3|zzz|0,zzz4|zzz|0,zzz5|zzz|0,zzz6|zzz|0,zzz7|zzz|0,zzz8|zzz|0,zzz9|zzz|0,'+  //10 spare spots can use if needed
      'zzzenergyRating|zzzenergyRating|0';
begin
  commaText:=  BASIC_DATA;
end;


constructor TRealEstateDotComFeatureList.create;
begin
  inherited create;
  Sorted:= True;
  Duplicates:= dupError	;
  slFields:= TStringList.Create;
end;

destructor TRealEstateDotComFeatureList.destroy;
begin
  slFields.Free;
end;

procedure TRealEstateDotComFeatureList.dumpToFile;
begin
   saveToFile('C:\Multilink\Temp\TBooleanFeatureList.txt');
end;

function TRealEstateDotComFeatureList.findRecord(
  _FeatureLabel: string): integer;
var i: integer;
    s: string;
begin
  Result:= -1;
  _FeatureLabel:= lowercase(_FeatureLabel);
  for i:= 0 to Count-1 do begin
      s:= lowercase(strings[i]);
      if pos(_FeatureLabel,s) = 1 then begin
        result:= i;
        exit;
      end;
  end;
end;

function TRealEstateDotComFeatureList.getCaptionByIndex(_index: integer): string;
var s: string;
begin
   s:=  getRecordByIndex(_index);
   ReplaceSC(s,'|',',',True);
   slFields.CommaText:= s;
   s:= slFields[1];
   ReplaceSC(s,'*',' ',True);
   Result:= s;
end;

function TRealEstateDotComFeatureList.getRecord(_FeatureLabel: string): string;
var i: integer;
    s: string;
begin
  Result:= '';
  _FeatureLabel:= lowercase(_FeatureLabel);
  for i:= 0 to Count-1 do begin
      s:= lowercase(strings[i]);
      if pos(_FeatureLabel,s) = 1 then begin
        result:= s;
        exit;
      end;
  end;
end;

function TRealEstateDotComFeatureList.getRecordByIndex(_index: integer): string;
begin
   Result:= '';
   if  _index < 0 then
     exit;
   if _index >= count then
     exit;
   Result:= strings[_index];
end;

function TRealEstateDotComFeatureList.getValueByIndex(_index: integer): string;
var s: string;
begin
   s:=  getRecordByIndex(_index);
   ReplaceSC(s,'|',',',True);
   slFields.CommaText:= s;
   s:= slFields[2];
   Result:= s;
end;

procedure TRealEstateDotComFeatureList.readFromFile;
begin
  LoadFromFile('C:\Multilink\Temp\TBooleanFeatureList.txt');
end;


procedure TRealEstateDotComFeatureList.writeBooleanValue(_index: integer; _value: boolean);
var s: string;
begin
  s:=  getRecordByIndex(_index);  //remoteGarage|Remote*Garage|0
  if _value then
    s[length(s)]:= '1'
  else
    s[length(s)]:= '0';
  strings[_index]:= s;
  dumpToFile;
end;

procedure TRealEstateDotComFeatureList.writeEnergyRatingValue(_value: double);
var s: string;
    i: integer;
begin
  if _value < 0 then
    _value:= 0;
  if _value > 10 then
    _value:= 10;
  if frac(_value) <> 0 then
     if frac(_value) <> 0.5 then
       _value:= round(_value);
  i:=  findRecord('zzzenergyRating');
  s:=  'zzzenergyRating|zzzenergyRating|'+Format('%0.1f',[_value]);
  strings[i]:= s;
  dumpToFile;
end;



function TRealEstateDotComFeatureList.AsXML: string;
//eg <alarmSystem>0</alarmSystem>
//'evaporativeCooling|Evaporative*Cooling|0,airConditioning|Air*Conditioning|0,alarmSystem|Alarm*System|0,'+
// are under allownaces not features -> furnished     petFriendly   smokers
var i: integer;
    s: string;
    _element, _energyRating: string;
begin
    Result:= '';
    for i:= 0 to count-1 do begin
      s:= strings[i];
      if pos('zzz',s) <> 0 then
        continue;
      if pos('furnished',s) <> 0 then   //are under allownaces not features
        continue;
      if pos('petFriendly',s) <> 0 then   //are under allownaces not features
        continue;
      if pos('smokers',s) <> 0 then   //are under allownaces not features
        continue;
      ReplaceSC(s,'|',',',True);
      slFields.CommaText:= s;
      _element:= Format('<%s>%s</%s>',[slFields[0],slFields[2],slFields[0]]);
      Result:=  Result+ _element+CRLF;
    end;
    i:=  findRecord('zzzenergyRating');
   _energyRating:= getValueByIndex(i);
   _element:=   Format('<energyRating>%s</energyRating>',[_energyRating]);                        //<energyRating>4.5</energyRating>
   Result:=  Result+ _element+CRLF;
end;

function TRealEstateDotComFeatureList.AlowancesAsXML: string;
//eg <alarmSystem>0</alarmSystem>
//'evaporativeCooling|Evaporative*Cooling|0,airConditioning|Air*Conditioning|0,alarmSystem|Alarm*System|0,'+
// are under allownaces not features -> furnished     petFriendly   smokers
var i: integer;
    s: string;
    _element, _energyRating: string;
    _isAnAllowance: boolean;
begin
    Result:= '';
    for i:= 0 to count-1 do begin
      _isAnAllowance:= False;
      s:= strings[i];
      if pos('zzz',s) <> 0 then
        continue;
      if pos('furnished',s) <> 0 then   //are under allownaces not features
        _isAnAllowance:= True;
      if pos('petFriendly',s) <> 0 then   //are under allownaces not features
        _isAnAllowance:= True;
      if pos('smokers',s) <> 0 then   //are under allownaces not features
        _isAnAllowance:= True;
      if not _isAnAllowance then
        continue;
      ReplaceSC(s,'|',',',True);
      slFields.CommaText:= s;
      _element:= Format('<%s>%s</%s>',[slFields[0],slFields[2],slFields[0]]);
      Result:=  Result+ _element+CRLF;
    end;
end;

function TRealEstateDotComFeatureList.HasStudy: boolean;
var i: integer;
    s: string;
    _element, _energyRating: string;
    _hasStudy: boolean;
begin
    _hasStudy:= false;
    Result:= False;
    for i:= 0 to count-1 do begin
      s:= strings[i];
      if pos('zzz',s) <> 0 then
        continue;
      if pos('study',s) <> 0 then begin
        _hasStudy:= True;
        Result:= True;
      end;
    end;
end;

end.

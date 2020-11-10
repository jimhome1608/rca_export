unit classPropLastChanged;

interface
uses Classes, Contnrs;

type
   TPropLastChanged = class
     ID, OFFICE_ID: integer;
     LastChanged: TDateTime;
   end;

   TPropLastChangedList = class(TObjectList)
      function addItem(_id, _office_id: integer; _LastChanged: TDateTime): integer;
      function getItem(_index: integer):  TPropLastChanged;
      function findItem(_id, _office_id: integer):  TPropLastChanged;
   end;

var PropLastChangedList: TPropLastChangedList;

implementation

{ TPropLastChangedList }

function TPropLastChangedList.addItem(_id, _office_id: integer;
  _LastChanged: TDateTime): integer;
var _PropLastChanged: TPropLastChanged;
begin
  _PropLastChanged:= findItem(_id, _office_id);
  if  _PropLastChanged <> Nil then begin
     _PropLastChanged.LastChanged:=  _LastChanged;
     exit;
  end;
  _PropLastChanged:= TPropLastChanged.Create;
  _PropLastChanged.ID:= _id;
  _PropLastChanged.OFFICE_ID:= _office_id;
  _PropLastChanged.LastChanged:= _LastChanged;
  add(_PropLastChanged);
end;

function TPropLastChangedList.findItem(_id,
  _office_id: integer): TPropLastChanged;
var i: integer;
    _PropLastChanged: TPropLastChanged;
begin
    Result:= Nil;
    for i:= 0 to count-1 do begin
       _PropLastChanged:=  getItem(i);
       if  _PropLastChanged = Nil then
         continue;
       if _PropLastChanged.ID <> _id then
         continue;
       if _PropLastChanged.OFFICE_ID <> _office_id then
         continue;
       result:= _PropLastChanged;
       exit;
    end;
    
end;

function TPropLastChangedList.getItem(_index: integer): TPropLastChanged;
begin
   Result:= Nil;
   if  _index < 0 then
     exit;
   if _index >= count then
     exit;
   Result:= TPropLastChanged(items[_index]);
end;

end.

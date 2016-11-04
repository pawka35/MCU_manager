unit Unit1;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  IdComponent, RegularExpressions,
  Vcl.CheckLst, Vcl.ExtCtrls ,Vcl.Ribbon, Vcl.OleCtrls,
  Vcl.ComCtrls, Vcl.Menus, unit2,zlib,tlntsend, StrUtils, SHDocVw,
  IdBaseComponent, IdTCPConnection, IdTCPClient, IdHTTP, superobject,vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.Grids,  Vcl.ImgList,
  IdRawClient, IdIcmpClient, IdRawBase, Vcl.XPMan,
  Vcl.ShellAnimations, Vcl.Buttons, System.Win.ScktComp,IdStack,DateUtils,WinSock,
  IdIPWatch, IdIPAddrMon, ShellApi, System.ImageList;

type
Tknopka=record
  button:TBitBtn;
  click:boolean;
end;

type
Tvisual_conference=record
  id_conf:integer;
  ip:string;
  proto:string;
  number:string;
  conn_state:integer;
  online:integer;
  autodial:integer;
  imya:Tlabel;
  image:Timage;
  button1:Tknopka;
  button2:Tknopka;
  button3:Tknopka;
  button4:Tknopka;
end;

  type
Tserver_data=record
ip:string[255];
http_port:integer;
http_login:string[255];
http_password:string[255];
telnet_port:integer;
telnet_login:string[255];
telnet_password:string[255];
end;

{type
Tconf_account_data=record
  ID:integer;
  name:string;
  online:integer;
  full_name:string;
  autodial:integer;
end;
 }
type
Taccount_data=record
proto:string;
ID:string;
IP:string;
Name:string;
reg_state:integer;
conn_info:integer;
imya:Tlabel;
checkbox:TCheckbox;
image_status: Timage;
button_ping: Tbitbtn;
end;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    MCU1: TMenuItem;
    Timer2: TTimer;
    ImageList1: TImageList;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    XPManifest1: TXPManifest;
    Image1: TImage;
    Timer3: TTimer;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    Button3: TButton;
    Timer4: TTimer;
    DateTimePicker1: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    Panel2: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Button7: TButton;
    Timer5: TTimer;
    Button6: TButton;
    Label8: TLabel;
    Timer6: TTimer;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button2: TButton;
    Button5: TButton;
    IdIPAddrMon1: TIdIPAddrMon;
    ProgressBar1: TProgressBar;
    Button8: TButton;
    Label12: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure check_online();
    procedure FormCreate(Sender: TObject);
    procedure telnet_connect;
    function telnet_zapros(zapros:string):string;
    procedure server_data_read;
    procedure create_inifile();
    procedure DecompressFile(const Source, Dest : String);
    procedure address_book2();
  procedure show_address_book();
    procedure IdIcmpClient1Reply(ASender: TComponent;
    const AReplyStatus: TReplyStatus);
    procedure Ping(IP: String);
    procedure Button2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    function json_standart(str:string):string;
    procedure MCU1Click(Sender: TObject);
    procedure online_conf();
    procedure Timer1Timer(Sender: TObject);
    procedure press1(Sender: TObject);
    procedure press2(Sender: TObject);
     procedure press3(Sender: TObject);
    function create_members_list(j:integer):Tvisual_conference;
     procedure take_control_conf();
      procedure check_connections;
    procedure Timer3Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
     procedure press4(Sender: TObject);
    function StreamToString(Stream : TStream) : String;
    function check_free_position():integer;
    procedure Button3Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure pingbutton_click(Sender: TObject);
    procedure second_call();
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure monitor_to_json();
    procedure Image2Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure VideoDownloadBegin(ASender: TObject; AWorkMode: TWorkMode;AWorkCountMax: Int64);
    procedure VideoDownloadWork(ASender: TObject; AWorkMode: TWorkMode;AWorkCount: Int64);
    procedure ComboBox1Change(Sender: TObject);
    procedure Ic(n:Integer;Icon:TIcon);
    Procedure ControlWindow(Var Msg:TMessage); message WM_SYSCOMMAND;
     Procedure IconMouse(var Msg:TMessage); message WM_USER+1;
     procedure OnMinimizeProc(Sender:TObject);
     procedure updater();
     procedure BetaUpdate(Sender: TObject);
     procedure status_show() ;
    procedure PageControl1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
     Procedure Delay(mSec:Cardinal);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  server_data: Tserver_data;
  Form1: TForm1;
  rooms:array of string;
  room,zapusk:integer;
  terminals:array of array of string;
   telnet_answer: TStringList;
   TN:TTelnetSend;
CRLF,waitfor:string;
accounts: array of Taccount_data;
//address_book_array: array of TCheckBox;
//room_members: array of TConf_account_data;
visual: array of Tvisual_conference;
beta_version:widestring;

const ManagerVersion:String ='release.0.9.3' ;


implementation

{$R *.dfm}

uses Unit3;
 // пока не используем
procedure conf_en();
var
i,j:integer;
begin
j:=0;
  end;


Procedure TForm1.ControlWindow(Var Msg:TMessage);
Begin
 IF Msg.WParam=SC_MINIMIZE then
  Begin
   Ic(1,Application.Icon);  // Добавляем значок в трей
   ShowWindow(Handle,SW_HIDE);  // Скрываем программу
   ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
 End else inherited;
End;


//procedure TForm1.show_address_book(accounts: array of Taccount_data);
procedure TForm1.show_address_book();
var
checkbox:TCheckBox;
i:integer;
imya:TLabel;
 arstr:System.TArray<String>;
  j: Integer;
begin
  Form1.IdIPAddrMon1.Active:=true; //выясняем свой ip и выделяем себя в списке терминалов
  arstr:=Form1.IdIPAddrMon1.IPAddresses.ToStringArray;
   Form1.IdIPAddrMon1.Active:=false;

  for i := 0  to length(accounts)-1 do
    begin
checkbox:=  TCheckBox.Create(Form1.ScrollBox1);
checkbox.Parent:=Form1.ScrollBox1;
checkbox.Hint:='Номер абонента: '+accounts[i].ID;
checkbox.ShowHint:=true;
checkbox.Top:=i*15;
accounts[i].checkbox:=checkbox;
imya:=Tlabel.Create(Form1.ScrollBox1);
imya.Parent:= Form1.ScrollBox1;
imya.Top:=i*15;

imya.Left:=accounts[i].checkbox.Left+15;
imya.Caption:=accounts[i].Name;
accounts[i].imya:=imya;

  for j := 0 to length(arstr)-1 do
begin
  if accounts[i].IP=arstr[j] then begin
  accounts[i].imya.Font.Color:=clGreen;
  accounts[i].checkbox.Checked:=true;end;
end;
    end;
    status_show();
    check_online();
   if Form1.Timer2.Enabled=false then Form1.Timer2.Enabled:=true;
end;

//формируем список участников конференции
function TForm1.create_members_list(j:integer):TVisual_conference;
var
member:TVisual_conference;
knopka,knopka2,knopka3,knopka4:Tknopka;
 button,button2,button3, button4:TBitBtn;
 Image2:Timage;
nadpis:Tlabel;
  begin
nadpis:=TLabel.Create(Form1.ScrollBox2);
nadpis.Parent:=Form1.ScrollBox2;
nadpis.Top:=j*25;
nadpis.Left:=3;
nadpis.Font.style := font.style + [fsbold];
  button:=TBitBtn.Create(Form1.ScrollBox2);    // кнопка вызова/отключения участника
  button.Parent:=Form1.ScrollBox2;
  button.ShowHint:=true;
  button.Height:=23;
  button.Tag:=j;
  button.Width:=23;
 button.Left:=nadpis.Left+120;
 button.Top:=nadpis.Top;
  button.Spacing:=0;
  button.Layout:=blGlyphTop;
  button.Enabled:=false;
  button.Glyph.Assign(nil);
    Form1.ImageList1.GetBitmap(3,button.Glyph);
    button.OnClick:=Form1.press1;
    knopka.button:=button;
    knopka.click:=false;
button2:=TBitBtn.Create(Form1.ScrollBox2);  // кнопка выключения звука от участника
button2.Parent:=Form1.ScrollBox2;
button2.ShowHint:=true;
button2.Enabled:=true;
button2.Tag:=j;
button2.Height:=23;
button2.Width:=23;
button2.Left:=button.Left+25;
button2.Top:=nadpis.Top;
button2.Layout:=blGlyphTop;
button2.OnClick:=Form1.press2;
button2.Enabled:=false;
button2.Glyph.Assign(nil);
  Form1.ImageList1.GetBitmap(5,button2.Glyph);
  button2.Hint:='Отключить звук от участника';
  knopka2.button:=button2;
  knopka2.click:=false;
    button3:=TBitBtn.Create(Form1.ScrollBox2);   // кнопка выключения видео от участника
button3.Parent:=Form1.ScrollBox2;
button3.Tag:=j;
button3.ShowHint:=true;
button3.Height:=23;
button3.Width:=23;
button3.Left:=button2.Left+25;
button3.Top:=nadpis.Top;
button3.Layout:=blGlyphTop;
button3.OnClick:=Form1.press3;
button3.Glyph.Assign(nil);
button3.Enabled:=false;
    Form1.ImageList1.GetBitmap(7,button3.Glyph);
    button3.Hint:='Отключить видео от участника';
    knopka3.button:=button3;
    knopka3.click:=false;
image2:=Timage.Create(Form1.ScrollBox2);
image2.Parent:=Form1.ScrollBox2;
image2.Height:=20;
image2.Width:=20;
image2.Top:=nadpis.Top+5;
image2.Left:=Form1.ScrollBox2.Width-45;
image2.Proportional:=true ;
  button4:=TBitBtn.Create(Form1.ScrollBox2);   // кнопка
  button4.Parent:=Form1.ScrollBox2;
  button4.Tag:=j;
  button4.ShowHint:=true;
  button4.Height:=23;
  button4.Width:=23;
  button4.Left:=button3.Left+25;
  button4.Top:=nadpis.Top;
  button4.Layout:=blGlyphTop;
  button4.OnClick:=Form1.press4;
  button4.Glyph.Assign(nil);
  button4.Enabled:=true;
    Form1.ImageList1.GetBitmap(8,button4.Glyph);
    button4.Hint:='Пропинговать ПК участника';
    knopka4.button:=button4;
    knopka4.click:=false;
member.imya:=nadpis;
member.button1:=knopka;
member.button2:=knopka2;
member.button3:=knopka3;
member.button4:=knopka4;
member.image:=image2;

  result:=member;
end;


procedure TForm1.second_call();
var
i:integer;
//str:string;
begin
  for I := 0 to length(accounts)-1 do
  begin
   if accounts[i].checkbox.Checked and accounts[i].checkbox.Enabled=true then
      begin
       setlength(visual,length(visual)+1);
          visual[length(visual)-1]:=Form1.create_members_list(length(visual)-1);
          visual[length(visual)-1].imya.Caption:={address_book_array[i].Name}accounts[i].Name;
          visual[length(visual)-1].ip:=accounts[i].IP;
          accounts[i].checkbox.Enabled:=false;
     Form1.telnet_zapros('room '+inttostr(room)+' invite '+accounts[i].proto+':'+accounts[i].ID+'@'+accounts[i].IP);
         visual[length(visual)-1].autodial:=1;
      end;
  end;
   Form1.Timer1.Enabled:=true;
end;

 //первый вызов, запускаем таймер 1, таймер 3(вывод картинки комнаты)
procedure first_call();
var
  i,j:integer;
  begin
  j:=0;
room:=Random(100)+1;
Form1.telnet_zapros('room '+inttostr(room)+' create');
  for I := 0 to length(accounts)-1 do
    begin
      if accounts[i].checkbox.Checked then //формируме кнопки для тех, кто в конференции
begin
      accounts[i].checkbox.Enabled:=false;
  setlength(visual,j+1);
  visual[j]:=Form1.create_members_list(j); //формируем массив из тех, кого приглашаем
  visual[j].imya.Caption:=accounts[i].Name;
  visual[j].ip:=accounts[i].IP;
  visual[j].proto:=accounts[i].proto;
  visual[j].number:=accounts[i].ID;
  visual[j].autodial:=1;
  j:=j+1;
      // Form1.telnet_zapros('room '+inttostr(room)+' invite '+accounts[i].IP);   //приглашаем учасников в комнату
      Form1.telnet_zapros('room '+inttostr(room)+' invite '+accounts[i].proto+':'+accounts[i].ID+'@'+accounts[i].IP);   //
 Form1.Timer4.Enabled:=true;
  end;
  end;
    Form1.Label1.Caption:=inttostr(room);
  Form1.RadioGroup1.Enabled:=false;
 Form1.Button1.Caption:='Добавить участников';
 Form1.Timer1.Enabled:=true;
  end;

//нажатие вкл\откл участника
procedure TForm1.press1(Sender: TObject);//
var
button:TBitBtn;
i:integer;
begin
  button:=TBitBtn(Sender);
  i:=button.Tag;

if visual[i].autodial=1 then exit;

  if visual[i].online=1 then  //если абонент онлайн, то отключаем его
    begin
      form1.telnet_zapros('room '+inttostr(room)+' drop '+inttostr(visual[i].id_conf));
      visual[i].button1.button.Glyph.Assign(nil);
      Form1.ImageList1.GetBitmap(2,visual[i].button1.button.Glyph);
      visual[i].autodial:=0;
//      visual[i].online:=0;
    end;

   if visual[i].online=0 then
    begin
      form1.telnet_zapros('room '+inttostr(room)+' invite '+visual[i].proto+':'+visual[i].number+'@' +visual[i].ip);
      visual[i].button1.button.Glyph.Assign(nil);
      Form1.ImageList1.GetBitmap(3,visual[i].button1.button.Glyph);
      visual[i].autodial:=1;
    end;


end;
  //нажатие вкл\выкл звук от учасника
procedure TForm1.press2(Sender: TObject);
var
button:TBitBtn;
i:integer;
PostData:TStringList;
begin
if Sender is TBitBtn then
   begin
    button:=TBitBtn(Sender);
    i:=button.Tag;
  if visual[i].button2.click=false then
begin
PostData:=TStringList.Create;
PostData.Clear;
PostData.Add('room='+inttostr(room)+'&otfc=1&action=1&v='+trim(inttostr(visual[i].id_conf)+'&o=1'));
Form1.IdHTTP1.Post('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select',PostData);
   visual[i].button2.button.Glyph.Assign(nil);
    Form1.ImageList1.GetBitmap(4,visual[i].button2.button.Glyph);
    visual[i].button2.button.Hint:='Включить звук от участника';
    visual[i].button2.click:=true;
PostData.Free;
end else
begin
PostData:=TStringList.Create;
PostData.Clear;
PostData.Add('room='+inttostr(room)+'&otfc=1&action=0&v='+trim(inttostr(visual[i].id_conf)+'&o=1'));
Form1.IdHTTP1.Post('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select',PostData);
  visual[i].button2.button.Glyph.Assign(nil);
    Form1.ImageList1.GetBitmap(5,visual[i].button2.button.Glyph);
     visual[i].button2.button.Hint:='Отключить звук от участника';
    visual[i].button2.click:=false;
PostData.Free;
end;
   end;

end;
//нажатие вкл\выкл картинки от участника
procedure TForm1.press3(Sender: TObject);
var

button:TBitBtn;
PostData:TStringList;
i:integer;

begin
if Sender is TBitBtn then
   begin
    button:=TBitBtn(Sender);
    i:=button.Tag;

Form1.take_control_conf();

  if visual[i].button3.click=false then
begin
PostData:=TStringList.Create;
PostData.Clear;
PostData.Add('room='+inttostr(room)+'&otfc=1&action=3&v='+trim(inttostr(visual[i].id_conf))+'&o=1');  //убираем клиента из видеомиксера
Form1.IdHTTP1.Post('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select',PostData);
   visual[i].button3.button.Glyph.Assign(nil);
    Form1.ImageList1.GetBitmap(6,visual[i].button3.button.Glyph);
     visual[i].button3.button.Hint:='Включить видео от участника';
    visual[i].button3.click:=true;
PostData.Free;
end else
begin
PostData:=TStringList.Create;
PostData.Clear;
PostData.Add('room='+inttostr(room)+'&otfc=1&action=13&v='+trim(inttostr(visual[i].id_conf)+'&o=0&o1=1&o2='+inttostr(Form1.check_free_position)));
Form1.IdHTTP1.Post('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select',PostData);
  visual[i].button3.button.Glyph.Assign(nil);
    Form1.ImageList1.GetBitmap(7,visual[i].button3.button.Glyph);
     visual[i].button3.button.Hint:='Отключить видео от участника';
    visual[i].button3.click:=false;
PostData.Free;
end;
   end;
end;

procedure TForm1.press4(Sender: TObject);
var
button:TBitBtn;
i:integer;

begin
if Sender is TBitBtn then
   begin
    button:=TBitBtn(Sender);
    i:=button.Tag;

   Form1.Ping(visual[i].ip);
   end;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
var
 myDate : TDateTime;
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;
begin
case Form1.RadioGroup1.ItemIndex of
0:  begin
  Form1.Panel2.Visible:=false;
  Form1.Button1.Enabled:=true;
  Form1.Button6.Enabled:=true;
  Form1.Timer6.Enabled:=false;
end;

1:  begin
  Form1.Panel2.Visible:=true;
  Form1.Button1.Enabled:=false;
  myDate:=now;
   Form1.DateTimePicker1.MinDate:=now-1;
   DecodeDateTime(myDate, myYear, myMonth, myDay,
                 myHour, myMin, mySec, myMilli);
   Form1.DateTimePicker1.Date:=now;
  Form1.ComboBox3.ItemIndex:=myHour;
  Form1.ComboBox4.ItemIndex:=myMin;
  Form1.Button7.Enabled:=false;
   Form1.Label8.Caption:=timetostr(now);
   Form1.Label11.Caption:=datetostr(now);
   Form1.Timer6.Enabled:=true;
end;
end;
end;

//берем управление комнетой конференции
procedure TForm1.take_control_conf();
var
PostData:TStringList;
begin
 PostData:=TStringList.Create;
PostData.Clear;
  PostData.Add('room='+inttostr(room)+'&otfc=1&action=69&v=0');
Form1.IdHTTP1.Post('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select',PostData); //берем контроль над комнатой
PostData.Free;
end;

   //кнопка в первой панели, вызываем first_call
procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;
begin
for i := 0 to length(accounts)-1 do
  begin
     if accounts[i].checkbox.Checked then j:=j+1;
  end;
if j<1 then
begin
 showmessage('Выберите хотя бы двух участников.');
 exit;
end;

  if Form1.Button1.Caption<>'Добавить участников'
  then first_call()
    else
  second_call();
Form1.PageControl1.ActivePageIndex:=1;
 Form1.PageControl1.Pages[1].Highlighted:=true;

 Form1.Timer2.Enabled:=false; // останавливаем обновление на первой вкладке (статусы)
  end;

function TForm1.StreamToString(Stream : TStream) : String;
var ms : TMemoryStream;
begin
  Result := '';
  ms := TMemoryStream.Create;
  try
    ms.LoadFromStream(Stream);
    SetString(Result,PChar(ms.memory),ms.Size);
  finally
    ms.free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
myDate :TDateTime;
begin
  if Form1.Button2.Caption='Записать конференцию' then begin
  Form1.IdHTTP1.Get('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select?action=startRecorder&room='+inttostr(room));
  Form1.Button2.Caption:='Остановить запись';
  Form1.Button5.Enabled:=true;
  Form1.Button5.Visible:=false;
  Form1.Button8.Enabled:=true;
  Form1.Button8.Visible:=false;
  end else
  begin
Form1.IdHTTP1.Get('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select?action=stopRecorder&room='+inttostr(room));
Form1.Button8.Visible:=true;
Form1.Button2.Caption:='Записать конференцию';
Form1.Button5.Visible:=true;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if Form1.Button3.Caption='>>' then
  begin
Form1.Button3.Caption:='<<';
Form1.Width:=836;
 Form1.Timer3.Enabled:=true;
  end else
  begin
  Form1.Button3.Caption:='>>';
Form1.Panel1.Visible:=false;
Form1.Width:=502;
Form1.Timer3.Enabled:=false;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
i:integer;
begin
Form1.telnet_zapros('room '+inttostr(room)+' delete');
Form1.Timer1.Enabled:=false;
Form1.Timer3.Enabled:=false;
Form1.Timer4.Enabled:=false;
Form1.Label1.Caption:='конференция не активна';
room:=0;
setlength(visual,0);
Form1.Button1.Caption:='Вызвать участников';

for i := 0 to length(accounts)-1 do
begin
  if accounts[i].checkbox.Checked then
    begin
      accounts[i].checkbox.Enabled:=true;
        if accounts[i].imya.Font.Color<>clGreen then
           accounts[i].checkbox.Checked:=false;
    end;
end;

begin
  for i:= ScrollBox2.ControlCount - 1 downto 0 do
    ScrollBox2.Controls[i].Free;
end;
Form1.Timer2.Enabled:=true;
Form1.PageControl1.ActivePageIndex:=0;
Form1.PageControl1.Pages[0].Highlighted:=true;
end;

function TForm1.check_free_position():integer;
 var
 LoadStream:TMemoryStream;
 PostData:TStringList;
 str,tmpstr:widestring;
 i,j:integer;
 r,u:TRegEx;
Match,MatchU:TMatch;
flag:boolean;
positions:array of integer;
begin
 LoadStream:=TMemoryStream.Create;
 Form1.IdHTTP1.Get('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/monitor.txt',LoadStream);
 LoadStream.Position:=0;
 PostData:=TStringList.create;
 PostData.LoadFromStream(LoadStream);
 str:=PostData.Text;
 str:=StringReplace(str,#$D#$A,'',[rfReplaceAll, rfIgnoreCase]);
 PostData.Free;
 LoadStream.Free;
j:=0;
flag:=false;
 //далее парсим monitor.txt
r.Create('Title: '+inttostr(room)+'(.*?)\]Title',[roIgnoreCase,roSingleLine]);
Match:=r.Match(str);
  if Match.Value='' then
    begin
      r.Create('Title: '+inttostr(room)+'(.*?)$',[roIgnoreCase,roSingleLine]);
        Match:=r.Match(str);
    end else
        begin
        end;
//выделяем сколько клеток в текущей раскладке
u.Create('Layout capacity:(.*?) Frame');
  MatchU:=u.Match(Match.Value);
str:=StringReplace(MatchU.Value,'Layout capacity:','', [rfReplaceAll, rfIgnoreCase]);
str:=trim(StringReplace(str,'Frame','', [rfReplaceAll, rfIgnoreCase]));
  u.Create('Position(.*?)\]');
    MatchU:=u.Match(Match.Value);
while MatchU.Success do  begin
tmpstr:=MatchU.Value;
tmpstr:=trim(StringReplace(tmpstr,'Position','', [rfReplaceAll, rfIgnoreCase]));
tmpstr:=trim(StringReplace(tmpstr,']','', [rfReplaceAll, rfIgnoreCase]));
setlength(positions,j+1);
  positions[j]:=strtoint(tmpstr);
j:=j+1;
  MatchU:=MatchU.NextMatch;
          end;
for i := 0 to strtoint(str)-1 do       begin
flag:=false;
  begin
   for j := 0 to length(positions)-1 do
      if positions[j]=i
        then flag:=true;
  if flag=false then  begin result:=i;break
  end;
  end;
  end;
end;

function ShowMembers: string;
var str:string;
begin
  str:=Form1.telnet_zapros('room '+inttostr(room)+' show members');
  Application.ProcessMessages;
  str:=Form1.json_standart(str);
if str='' then ShowMembers;
result:=str;
end;

//смотрим кто онлайн в конференции и обновляем графику
procedure TForm1.online_conf();
var i,j:integer;
JsObject1: ISuperObject;
JsonArray: TSuperArray;
str:string;

begin
j:=0;
str:=ShowMembers();
JsObject1:=SO(str); // парсим ответ от сервера
 try
JsonArray:= JsObject1.AsArray;
for i:= 0 to JsonArray.Length-1 do
  begin
  if JsonArray[i].S['name']<>'' then begin //если не служебный участник
   if j>length(visual)-1 then begin //если обнаружили участника, которого не вызывали сами
    if JSonArray[i].S['name']='[h323:@:1720]' then  break;
      if JSonArray[i].I['online']=0 then  break;

setlength(visual,length(visual)+1);
  visual[j]:=Form1.create_members_list(j);
  visual[j].imya.Font.Color:=clred;
    if Pos('h323',JsonArray[i].S['name'])<>0 then
      visual[j].imya.Caption:=trim(utf8toansi(copy(JsonArray[i].S['name'],1,Pos('h323',JsonArray[i].S['name'])-2)))
    else
      visual[j].imya.Caption:=trim(utf8toansi(copy(JsonArray[i].S['name'],1,Pos('sip',JsonArray[i].S['name'])-2)));
        showmessage('К конференции подключился не приглашенный участник!'+#10#13+'При необходимости отключите его вручную'+#13#10+'(в списке отмечен красным текстом)');
   end;
visual[j].id_conf:=JsonArray[i].i['id'];
 visual[j].online:=JsonArray[i].i['online'];
//  visual[j].autodial:=JsonArray[i].i['autoDial'];
  inc(j); end;
 end;
for I := 0 to length(visual)-1 do
  begin
//visual[i].image.ShowHint:=true;   //показывать подсказки

if visual[i].online=1 then      //если сервер отвечает, что онлайн
        begin
     visual[i].image.Picture.Bitmap.Assign(nil);
  Form1.ImageList1.GetBitmap(0,visual[i].image.Picture.Bitmap);//зеленый кружок
  visual[i].image.ShowHint:=true;
  visual[i].image.Hint:='Абонент в конференции.';
  visual[i].autodial:=0;
    visual[i].button1.button.Glyph.Assign(nil);
    Form1.ImageList1.GetBitmap(3,visual[i].button1.button.Glyph);   //  зеленый телефон
    visual[i].image.ShowHint:=true;
     visual[i].button1.button.Hint:='Отключить участника';
visual[i].button2.button.Enabled:=true;
visual[i].button3.button.Enabled:=true;
visual[i].button1.button.Enabled:=true;
visual[i].button4.button.Enabled:=false;
      end
        else
          begin
      visual[i].button1.button.Glyph.Assign(nil);
         visual[i].image.Picture.Bitmap.Assign(nil);
          Form1.ImageList1.GetBitmap(1,visual[i].image.Picture.Bitmap); //красный кружок
          visual[i].image.ShowHint:=true;
           visual[i].image.Hint:='Абонент не подключен к конференции.';
if visual[i].autodial=1 then
      begin
               Form1.ImageList1.GetBitmap(10,visual[i].button1.button.Glyph);
                 visual[i].button1.button.Hint:='Сервер пытается вызвать абонента';
      end else begin
                Form1.ImageList1.GetBitmap(2,visual[i].button1.button.Glyph);   //красный телефон
                visual[i].button1.button.Hint:='Вызвать абонента';
      end;
   // visual[i].button1.click:=true;
visual[i].button2.button.Enabled:=false;
visual[i].button3.button.Enabled:=false;
visual[i].button1.button.Enabled:=true;
visual[i].button4.button.Enabled:=true;
          end;
          end;
JsonArray:=nil;
 except
  online_conf();
 end;
end;


procedure TForm1.VideoDownloadBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
 Form1.ProgressBar1.Max:=AWorkCountMax;
end;


procedure TForm1.VideoDownloadWork(ASender: TObject; AWorkMode: TWorkMode;AWorkCount: Int64);
begin
  Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+AWorkCount;
end;

procedure GetVideoRecord(str:string);
var
Http  : TidHttp;
Stream:TMemoryStream;
url,r:WideString;
i,j:integer;
begin
try

Form1.IdHTTP1.OnWorkBegin:=Form1.VideoDownloadBegin;
Form1.IdHTTP1.OnWork:=Form1.VideoDownloadWork;
Stream:=TMemoryStream.Create;
url:='http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port)+'/Records?'+str;
for i:=1 to length(url) do
begin
if url[i]='.' then
begin
j:=i;
end;
end;
r:=copy(url,j+1,length(url));
Form1.IdHTTP1.Get(url,Stream);

Stream.SaveToFile('conferense_'+FormatDateTime('yyyy-MM-dd-hh_mm_ss',now)+'_Room№_'+inttostr(room)+'.'+r);
Stream.Free;
except
on e:Exception do
Stream.Free;
end;
Form1.IdHTTP1.CleanupInstance;
end;



procedure TForm1.Button5Click(Sender: TObject);
var
str:string;
r:TRegEx;
Match:TMatch;
 begin
Form1.ProgressBar1.Visible:=true;
 str:=(Form1.IdHTTP1.Get('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Records'));
  r.Create('getfile='+inttostr(room)+'__'+FormatDateTime('yyyy-MMdd-hhmm',now)+'(.*?)mkv');
Match:=r.Match(str);
str:=Match.Value;
GetVideoRecord(str);
showmessage('Файл сохранен!');
Form1.ProgressBar1.Visible:=false;
end;

procedure TForm1.Button6Click(Sender: TObject);
var i,j:integer;
begin
j:=0;
for i := 0 to length(accounts)-1 do
  begin
     if accounts[i].checkbox.Checked then j:=j+1;
  end;
if j<1 then
begin
 showmessage('Выберите хотя бы двух участников!');
 exit;
end;
Form1.Timer5.Enabled:=true;
Form1.RadioGroup1.Enabled:=false;
Form1.ScrollBox1.Enabled:=false;
 Form1.Button6.Enabled:=false;
 Form1.Button7.Enabled:=true;

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
Form1.RadioGroup1.Enabled:=true;
Form1.ScrollBox1.Enabled:=true;
Form1.Button6.Enabled:=true;
Form1.Timer5.Enabled:=false;
Form1.Button7.Enabled:=false;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
str:string;
r:TRegEx;
Match:TMatch;
url:widestring;
 begin
 str:=(Form1.IdHTTP1.Get('http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port)+'/Records'));
  r.Create('getfile='+inttostr(room)+'__'+FormatDateTime('yyyy-MMdd-hhmm',now)+'(.*?)mkv');
Match:=r.Match(str);
str:=Match.Value;
str:=AnsiReplaceStr(str,'getfile=','');
url:='http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port)+'/Records?deleteRecordConfirmed='+str;
Form1.IdHTTP1.Get(url);
showmessage('Запись удалена!');
 Form1.Button5.Enabled:=false;
 Form1.Button8.Enabled:=false;
end;


procedure TForm1.PageControl1Change(Sender: TObject);          //если активна вторая вкладка, то перестаем обновлять состояние на первой
begin
if Form1.PageControl1.ActivePageIndex=0 then
begin
//check_online();
Form1.Timer2.Enabled:=True;
Form1.Timer1.Enabled:=False;

end;
if Form1.PageControl1.ActivePageIndex=1 then
begin
Form1.Timer2.Enabled:=False;
if length(visual)>0 then
  Form1.Timer1.Enabled:=true;
end;

end;

procedure TForm1.Ping(IP: String);              //процедура пинга узла
const BUFSIZE = 2000;
var SecAttr    : TSecurityAttributes;
   hReadPipe,
   hWritePipe : THandle;
   StartupInfo: TStartUpInfo;
   ProcessInfo: TProcessInformation;
   Buffer     : Pansichar;
   WaitReason,
   BytesRead  : DWord;
begin
with SecAttr do
begin
  nlength              := SizeOf(TSecurityAttributes);
  binherithandle       := true;
  lpsecuritydescriptor := nil;
end;
if Createpipe (hReadPipe, hWritePipe, @SecAttr, 0) then
begin
  Buffer  := AllocMem(BUFSIZE + 1);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.hStdOutput  := hWritePipe;
  StartupInfo.hStdInput   := hReadPipe;
  StartupInfo.dwFlags     := STARTF_USESTDHANDLES +
                             STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
  if CreateProcess(nil,
     PChar('ping.exe -n 4 '+IP),
     @SecAttr,
     @SecAttr,
     true,
     NORMAL_PRIORITY_CLASS,
     nil,
     nil,
     StartupInfo,
     ProcessInfo) then
    begin
      repeat
        WaitReason := WaitForSingleObject( ProcessInfo.hProcess,10);
        Application.ProcessMessages;
      until (WaitReason <> WAIT_TIMEOUT);
      Repeat
        BytesRead := 0;
        ReadFile(hReadPipe, Buffer[0], BUFSIZE, BytesRead, nil);
        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer,Buffer);
        showmessage(string(buffer));
      until (BytesRead < BUFSIZE);
    end;
  FreeMem(Buffer);
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(hReadPipe);
  CloseHandle(hWritePipe);
end;
end;

procedure TForm1.pingbutton_click(Sender: TObject);
var
button:TBitBtn;
i:integer;
PostData:TStringList;
begin
if Sender is TBitBtn then
   begin
    button:=TBitBtn(Sender);
    i:=button.Tag;
  Form1.Ping(accounts[i].IP);
  // Form1.Ping(address_book_array[i]);
   end;
end;

procedure TForm1.status_show() ;
var
pingbutton:Tbitbtn;
image_status:Timage;
i:integer;
begin
  for i := 0 to length(accounts)-1 do
  begin
image_status:=Timage.Create(Form1.ScrollBox1);
image_status.Parent:=Form1.ScrollBox1;
image_status:=Timage.Create(Form1.ScrollBox1);
image_status.Parent:=Form1.ScrollBox1;
image_status.Height:=15;
image_status.Width:=15;
image_status.Top:=accounts[i].checkbox.Top;
image_status.Left:=Form1.ScrollBox1.Width-55;
image_status.Proportional:=true;
image_status.ShowHint:=true;
  pingbutton:=TBitbtn.Create(Form1.ScrollBox1);
  pingbutton.Parent:=Form1.ScrollBox1;
  pingbutton.Left:=image_status.Left+20;
  pingbutton.Top:=image_status.Top;
  pingbutton.Height:=15;
  pingbutton.Width:=15;
  pingbutton.Tag:=i;
  pingbutton.ShowHint:=true;
  pingbutton.Hint:='Пропинговать ПК абонента';
  pingbutton.OnClick:=Form1.pingbutton_click;
  pingbutton.Glyph.Assign(nil);
  Form1.ImageList1.GetBitmap(8,pingbutton.Glyph);
accounts[i].image_status:=image_status;
accounts[i].button_ping:=pingbutton;
  end;
end;

  //подключаемся по телнет к серверу
procedure TForm1.telnet_connect;
begin
CRLF:=#13;
waitfor:='#';
TN:=TTelnetSend.Create;
TN.TargetHost:=server_data.ip;
TN.TargetPort:=inttostr(server_data.telnet_port);
TN.Timeout:=500;
TN.TermType:='dumb';
TN.Login;
TN.WaitFor('Login:');
TN.Send(server_data.telnet_login+CRLF);
TN.WaitFor('Password:');
TN.Send(server_data.telnet_password+CRLF);
TN.WaitFor(waitfor);
TN.Timeout:=500;
end;
  // отправляем запрос и передаем ответ к серверу по телнет
function TForm1.telnet_zapros(zapros:string):string;
begin
TN.SessionLog:='';
Application.ProcessMessages;
TN.Send(zapros+CRLF);
TN.WaitFor(waitfor);
result:=TN.SessionLog;
end;
    // выполняем процедуру online_conf
procedure TForm1.Timer1Timer(Sender: TObject);
begin
Form1.online_conf;
end;
     //процедуры check_online and status_check
procedure TForm1.Timer2Timer(Sender: TObject);
begin
Form1.check_online();

end;
     //выводим картинку из конференции
procedure TForm1.Timer3Timer(Sender: TObject);

var
  Buf: TMemoryStream;
  Img: TJPEGImage;
  URL: String;


  begin
Form1.Panel1.Visible:=true;
  URL := 'http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Jpeg?room='+inttostr(room)+'&w=388&h=218&mixer=0';
  try
   Buf := TMemoryStream.Create;
   IdHTTP1.Get (URL, Buf);
   Img := TJPEGImage.Create;
   // указываем буффер, который нужно загрузить, это картинка, а не строка и размер картинки нужно указать как длину буффера!!!
   Buf.Write(Pointer(Buf)^, SizeOf(Buf));
   // первый аргумент для того, мы не знаем что мы грузить будем вообще, текст, буквы, цифры или вот как тут картинки
   // второй аргумент - это указываем размер буффера
   Buf.Position := 0;
   Img.LoadFromStream(Buf);
   Image1.AutoSize := True;
   Image1.Picture.Assign(Img);
except
begin
Form1.Timer3.Enabled:=false;
Form1.Timer2.Enabled:=false;
Form1.Timer1.Enabled:=false;
Form1.Timer4.Enabled:=false;
    showmessage('Отключился последний участник! \n Завершаем конференцию.');
    Application.Terminate;
    end;
end;
  //finally
    Buf.Free;
    Img.Free;
  //end;
end;
procedure TForm1.Timer4Timer(Sender: TObject);
var i:integer;
begin
for i := 0 to length(visual)-1 do
    begin
 if (visual[i].button1.click=false) and {(visual[i].online=0)} (visual[i].autodial=1) and (visual[i].ip<>'') then
 Form1.telnet_zapros('room '+inttostr(room)+' invite '+visual[i].proto+':'+visual[i].number+'@'+accounts[i].IP);
//Form1.telnet_zapros('room '+inttostr(room)+' dial '+inttostr(visual[i].id_conf));

  end;
end;

procedure TForm1.Timer5Timer(Sender: TObject);
var
 myDate : TDateTime;
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;
begin

  myDate:=now;
   DecodeDateTime(myDate, myYear, myMonth, myDay,myHour, myMin, mySec, myMilli);

if (myHour=Form1.ComboBox3.ItemIndex) and (myMin=Form1.ComboBox4.ItemIndex) and (Datetostr(Form1.DateTimePicker1.Date)=Datetostr(now)) then
begin

  Form1.Timer5.Enabled:=false;
  Ic(2,Application.Icon);  // Удаляем значок из трея
                    ShowWindow(Application.Handle,SW_SHOW); // Восстанавливаем кнопку программы
                    ShowWindow(Handle,SW_SHOW); // Восстанавливаем окно программы
   first_call();
   Form1.Button1.Enabled:=true;
   Form1.ScrollBox1.Enabled:=true;
   Form1.PageControl1.ActivePageIndex:=1;
 Form1.PageControl1.Pages[1].Highlighted:=true;
end;

end;

procedure TForm1.Timer6Timer(Sender: TObject);
begin
form1.Label8.Caption:=TimetoStr(now);
end;


procedure TForm1.address_book2();     //составляем адресную книгу из зарегестрированных аккаунтов
var str:string;
i,j,k,m:integer;
JsonArray:TSuperArray;
X:ISuperObject;

begin
updater();
str:=Form1.telnet_zapros('show registrar accounts');
str:=Form1.json_standart(str);
m:=0;
X:=SO(str);
JsonArray:=X.AsArray;
  for i := 0 to JsonArray.Length-1 do
    begin
     j:= JsonArray.O[I].I['is_abook'];
    if j=0 then continue;
  setlength(accounts,m+1);
str:= JsonArray.O[I].S['memberNameID'];
     if AnsiPos('h323',str)<>0 then
      begin
        str:=StringReplace(str,'h323:','',[rfReplaceAll]);
         accounts[m].ID:=str;
         accounts[m].proto:='h323';
       end;
       if AnsiPos('sip',str)<>0 then
      begin
        str:=StringReplace(str,'sip:','',[rfReplaceAll]);
         accounts[m].ID:=str;
         accounts[m].proto:='sip';
       end;
          str:=JsonArray.O[i].S['memberName'];
    j:=AnsiPos(accounts[m].proto+':',str);
          accounts[m].Name:=utf8toansi(copy(str,0,j-2));
    j:=AnsiPos('@',str);
    k:=LastDelimiter(':',str);
  accounts[m].IP:=copy(str,j+1,k-j-1);
  accounts[m].reg_state:= -1;
  accounts[m].conn_info:= JsonArray.O[I].I['conn_state'];
    inc(m);
    end;
  show_address_book();
end;

 //приводим ответ по телнету к стандарту json
function TForm1.json_standart(str:string):string;
begin
str:=AnsiReplaceStr(str,'['#$D#$A' ['#$D#$A''  ,'[{'); //приводим к json виду
str:=AnsiReplaceStr(str,'],'#$D#$A' ['  ,'},{');
str:=AnsiReplaceStr(str,']'#$D#$A']'  ,'}]');
str:=AnsiReplaceStr(str,'#','');
str:=Trim(str);
result:=str;
end;

    //меню главное
procedure TForm1.MCU1Click(Sender: TObject);
begin
//Form1.Close;
Form1.Hide;
Form1.Timer2.Enabled:=false;
   Form1.create_inifile();
end;


     //парсим ответ show registrar accounts
procedure TForm1.check_online();  // составляем адресную книгу
var
JsObject1: ISuperObject;
JsonArray: TSuperArray;
i,j:integer;
str:string;
   r:TRegEx;
Match:TMatch;
begin
Form1.telnet_connect;
str:= Form1.telnet_zapros('show registrar accounts');
str:=Form1.json_standart(str);
//str:=Form1.json_standart(Form1.telnet_zapros('show registrar accounts'));
  JsObject1:=SO(str); // парсим ответ от сервера
JsonArray:= JsObject1.AsArray;
for i:= 0 to JsonArray.Length-1 do
  begin
    if JsonArray[i].I['is_abook']=0 then   continue;   //если аккаунт не в записной книжке, то лесом
    str:=UTF8ToAnsi(JsonArray[i].S['memberName']);
     r.Create('(.*?)\[');
    Match:=r.Match(str);
    str:=trim(StringReplace(Match.Value,'[','', [rfReplaceAll, rfIgnoreCase]));
      for j := 0 to length(accounts)-1 do
        begin
          if trim(accounts[j].Name)=str then break;
        end;

accounts[j].conn_info:= JsonArray[i].i['conn_state'];
  r.Create('@(.*?):');
 // str:= JsonArray[i].S['memberName'];
Match:=r.Match(JsonArray[i].S['memberName']);
str:=Match.Value;
str:=trim(StringReplace(Match.Value,'@','', [rfReplaceAll, rfIgnoreCase]));
str:=trim(StringReplace(str,':','', [rfReplaceAll, rfIgnoreCase]));
accounts[j].IP:=str;
accounts[j].reg_state:=JsonArray[i].i['reg_state'];

  if (accounts[j].reg_state=2) then
      begin
        accounts[j].image_status.Picture.Bitmap.Assign(nil);
               if (accounts[j].conn_info=2) then
              begin
               accounts[j].image_status.Picture.Bitmap.Assign(nil);
               Form1.ImageList1.GetBitmap(9,accounts[j].image_status.Picture.Bitmap);
               accounts[j].image_status.Hint:='Абонент участвует в активной конференции';
               accounts[j].image_status.Tag:=9;
               accounts[j].button_ping.Enabled:=false;
             //   break;
            end else
              begin
        Form1.ImageList1.GetBitmap(0,accounts[j].image_status.Picture.Bitmap);
        accounts[j].image_status.Hint:='Абонент доступен для вызова';
        accounts[j].image_status.Tag:=0;
        accounts[j].button_ping.Enabled:=false;
              end;
        end else
        begin
        accounts[j].image_status.Picture.Bitmap.Assign(nil);
          Form1.ImageList1.GetBitmap(1,accounts[j].image_status.Picture.Bitmap);
          accounts[j].image_status.Hint:='У абонента выключена программа конференцсвязи';
         accounts[j].image_status.Tag:=1;
          accounts[j].button_ping.Enabled:=true;
        end;
  end;
end;



procedure TForm1.ComboBox1Change(Sender: TObject);
var
html,str:string;
PostData:TStringList;
begin
Form1.take_control_conf;
PostData:=TStringList.Create;
PostData.Clear;


case Form1.ComboBox1.ItemIndex of
0:  str:='1centrAnd12';
1:  str:='1and5';
2:  str:='1and7';
3:  str:='1and9';
4:  str:='1and11';
5:  str:='1and12';
6:  str:='2and8';
7:  str:='2and3';
8:  str:='1and20';
9:  str:='auto';

end;
  if (str='auto') then PostData.Add('room='+inttostr(room)+'&otfc=1&action=70&v=1')
   else
      PostData.Add('room='+inttostr(room)+'&otfc=1&action=23&v='+str);
//PostData.Add('room='+inttostr(room)+'&otfc=1&action=73&v='+str);        //изменить раскладку конф-ии
Form1.IdHTTP1.Post('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/Select',PostData);
PostData.Free;

end;

procedure TForm1.check_connections;
begin
   Form1.IdHTTP1.URL.Host:=server_data.ip;
   //Form1.IdHTTP1.Request.Host:=server_data.ip;
  Form1.IdHTTP1.URL.Port:=inttostr(server_data.http_port);
try
Form1.IdHTTP1.Connect;
except
  begin
showmessage('Error!'); 
Form1.Ping(server_data.ip);
Halt;

  end;
end;

end;


procedure TForm1.BetaUpdate(Sender: TObject);
var
buttonSelected:integer;
begin
    buttonSelected := MessageDlg('На сайте есть обновление до бета-версии программы.'#13#10'Обновление до бета-версии не является обязательным.'#13#10'Хотите обновить версию?',mtConfirmation, mbOKCancel, 0);
 if buttonSelected = mrOK     then
  begin
  ShellExecute(Form1.Handle,'open','updater.exe', PWideChar('beta '+beta_version),nil, SW_SHOWNORMAL);
  Application.Terminate;
  end;
end;


procedure TForm1.updater();
var
i:integer;
LoadStream: TMemoryStream;
fileURL,str,beta,release:string;
s1,s2:TStringList;
buttonSelected : Integer;
NewItem:TMenuItem;
SL : TStringlist;
begin
fileURL:='http://'+server_data.ip+'/McuVersion.txt';
   // ShellExecute(Form1.Handle,'open','updater.exe', nil, nil, SW_SHOWNORMAL);
LoadStream := TMemoryStream.Create; // выделение памяти под переменную
Form1.idHTTP1.Get(fileURL, LoadStream); // загрузка в поток данных из сети
LoadStream.Position:=0;
SL := TStringlist.Create;
//создаем список с доступрными версиями в [0]-бета, в [1]- релиз
SL.LoadFromStream(LoadStream);
//LoadStream.SaveToFile('McuVersion.txt'); // сохраняем данные из потока на жестком диске
LoadStream.Free; // освобождаем память

  s1:= TStringList.Create;
  s1.Delimiter:='.';
  s1.DelimitedText:=SL[1];

  str:=s1[1]+'.'+s1[2]+'.'+s1[3];

s2:= TStringList.Create;
s2.Delimiter:='.';
s2.DelimitedText:=ManagerVersion;

   //сравниваем релизные версии на сайте и в программе
if ((strtoint(s1[1])>strtoint(s2[1])) or (strtoint(s1[2])>strtoint(s2[2])) or (strtoint(s1[3])>strtoint(s2[3])))
  then begin
  showmessage('Обязательное обновление!');
  //DeleteFile('McuVersion.txt');
   ShellExecute(Form1.Handle,'open','updater.exe', PWideChar('release '+PWideChar(str)),nil, SW_SHOWNORMAL);
  Application.Terminate;
  //Halt(0);
  end;
 //проверяем наличие бета версий на сайте
s1.DelimitedText:=SL[0];
if ((strtoint(s1[1])>strtoint(s2[1])) or (strtoint(s1[2])>strtoint(s2[2])) or (strtoint(s1[3])>strtoint(s2[3])))
  then begin
      NewItem := TMenuItem.Create(Form1.MainMenu1);
NewItem.Caption := 'Обновить до beta';
Form1.MainMenu1.Items.Insert(Form1.MainMenu1.Items.Count,NewItem);
beta_version:=s1[1]+'.'+s1[2]+'.'+s1[3];
NewItem.OnClick:=BetaUpdate;
//DeleteFile('McuVersion.txt');

end;


s2.Free;
s1.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin

Form1.server_data_read;
//Form1.check_connections;
Form1.IdHTTP1.GET('http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port)); //авторизуемся

  Form1.PageControl1.ActivePageIndex:=0;
  Form1.PageControl1.Pages[0].Highlighted:=true;
Form1.telnet_connect;
address_book2();
Application.onMinimize:=OnMinimizeProc;
Form1.Caption:='McuManager ('+ManagerVersion+')';
end;

procedure TForm1.FormDestroy(Sender: TObject); //когда закрываем программу, удаляем комнату на сервере
begin
Form1.telnet_zapros('room '+inttostr(room)+' delete');
end;

procedure TForm1.IdIcmpClient1Reply(ASender: TComponent;const AReplyStatus: TReplyStatus);
begin
showmessage('YES!');
end;
 procedure TForm1.Image2Click(Sender: TObject);
begin

end;

//считываем параметры подключения к серверу из файла
procedure TForm1.server_data_read;
var
buttonSelected : Integer;
ini_file,tempfile: file of Tserver_data;
begin
  assignfile(ini_file,'mcumanager.mcu');
    if not FileExists('mcumanager.mcu') then
      begin
      Form1.Timer2.Enabled:=false;
      buttonSelected := MessageDlg('Нет файла настроек. Создать?',mtError, mbOKCancel, 0);
          if buttonSelected = mrOK then 
            Form1.create_inifile();
        //  Form1.server_data_read();
          if buttonSelected = mrCancel then begin
        showmessage('Программа будет закрыта.');
        Application.Terminate;
      Halt(0);
          end;
      end;
  Form1.DecompressFile('mcumanager.mcu','mcumanager_temp');
assignfile(tempfile,'mcumanager_temp');
reset(tempfile);
read(tempfile,server_data);
CloseFile(tempfile);
DeleteFile('mcumanager_temp');
end;
 //разархивация файла с явками\паролями


procedure TForm1.DecompressFile(const Source, Dest : String);
var
   SourceFile, DestFile : TFileStream;
   decompr : TDecompressionStream;
   bytecount : Integer;
begin
   SourceFile := TFileStream.Create(Source, fmOpenRead);
   DestFile := TFileStream.Create(Dest,fmCreate);
   try
     //how big was the "original"
     SourceFile.Read(bytecount,SizeOf(bytecount));
     if bytecount > 0 then
     begin
       //create the decompression stream after reading the bytecount
       decompr := TDecompressionStream.Create(SourceFile);
       try
         //decompress
         DestFile.CopyFrom(decompr,bytecount);
       finally
         decompr.Free;
       end;
     end;
   finally
     SourceFile.Free;
     DestFile.Free;
   end;
end;
  // открытия второй формы для создание файла ини
procedure TForm1.create_inifile();
begin
  if (not Assigned(Form2)) then begin  // проверка существования Формы (если нет, то
       Form2:=TForm2.Create(Self);    // создание Формы)
   Form2.ShowModal; // (или Form2.ShowModal)
  end;
end;

procedure TForm1.monitor_to_json();
var
 r:TRegEx;
Match:TMatch;
ot:string;
myfile : TextFile;
begin

Form1.IdHTTP1.Get('http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port));
ot:=Form1.IdHTTP1.Get('http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port)+'/monitor.txt');
AssignFile(myfile,'monitor_json.txt');
Rewrite(myfile);
write(myfile,ot);
closefile(myfile);
ot:=StringReplace(ot,#$D#$A,'',[rfReplaceAll, rfIgnoreCase]);
ot:=StringReplace(ot,#$A,'',[rfReplaceAll, rfIgnoreCase]);
r.Create('Title: 89(.*?)$');
Match:=r.Match(ot);
ot:=Match.Value;

r.Create('\[Member(.*?)\Mixer');
Match:=r.Match(ot);
ot:=Match.Value;
ot:='['+ot;
ot:=StringReplace(ot,'[M','},{M',[rfReplaceAll, rfIgnoreCase]);
ot:=StringReplace(ot,'  ',', ',[rfReplaceAll, rfIgnoreCase]);
ot:=StringReplace(ot,'Member','Member:',[rfReplaceAll, rfIgnoreCase]);
ot:=StringReplace(ot,'},','',[]);
ot:=StringReplace(ot,',{Mixer',']',[]);
ot:=StringReplace(ot,']','',[rfReplaceAll]);
showmessage(ot);
end;

Procedure TForm1.Ic(n:Integer;Icon:TIcon);
Var Nim:TNotifyIconData;
begin
 With Nim do
  Begin
//   cbSize:=SizeOf(Nim);
   Wnd:=Form1.Handle;
   uID:=1;
   uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
   hicon:=Icon.Handle;
   uCallbackMessage:=wm_user+1;
   szTip:='Развернуть MCU manager';
  End;
 Case n OF
  1: Shell_NotifyIcon(Nim_Add,@Nim);
  2: Shell_NotifyIcon(Nim_Delete,@Nim);
  3: Shell_NotifyIcon(Nim_Modify,@Nim);
 End;
end;

procedure TForm1.IconMouse(var Msg:TMessage);
Var p:tpoint;
begin
 GetCursorPos(p); // Запоминаем координаты курсора мыши
 Case Msg.LParam OF  // Проверяем какая кнопка была нажата
  WM_LBUTTONUP,WM_LBUTTONDBLCLK: {Действия, выполняемый по одинарному или двойному щелчку левой кнопки мыши на значке. В нашем случае это просто активация приложения}
                   Begin
                    Ic(2,Application.Icon);  // Удаляем значок из трея
                    ShowWindow(Application.Handle,SW_SHOW); // Восстанавливаем кнопку программы
                    ShowWindow(Handle,SW_SHOW); // Восстанавливаем окно программы
                   End;
  {
   WM_RBUTTONUP: {Действия, выполняемый по одинарному щелчку правой кнопки мыши}
   {Begin
    SetForegroundWindow(Handle);  // Восстанавливаем программу в качестве переднего окна
    PopupMenu1.Popup(p.X,p.Y);  // Заставляем всплыть тот самый TPopUp о котором я говорил чуть раньше
    PostMessage(Handle,WM_NULL,0,0);
   end;}
 End;
end;

Procedure TForm1.OnMinimizeProc(Sender:TObject);
Begin
 PostMessage(Handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
End;


     Procedure TForm1.Delay(mSec:Cardinal);
    Var
      TargetTime:Cardinal;
    Begin
      TargetTime:=GetTickCount+mSec;
      While TargetTime>GetTickCount Do
        begin
            Application.ProcessMessages;
            Sleep(1);
            If Application.Terminated then Exit;
        end;
    End;

end.

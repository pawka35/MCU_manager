unit mcuupdater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ComCtrls,zlib,
  Vcl.ExtCtrls,Wininet;

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

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure server_data_read();
    procedure DecompressFile(const Source, Dest : String);
    procedure downloadUpdate();
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  server_data:Tserver_data;

implementation

{$R *.dfm}

//считываем параметры подключения к серверу из файла
procedure TForm1.server_data_read();
var

buttonSelected : Integer;
ini_file,tempfile: file of Tserver_data;
begin

  assignfile(ini_file,'mcumanager.mcu');
Form1.DecompressFile('mcumanager.mcu','mcumanager_temp');
assignfile(tempfile,'mcumanager_temp');
reset(tempfile);
read(tempfile,server_data);
CloseFile(tempfile);
DeleteFile('mcumanager_temp');
end;
 procedure TForm1.Timer1Timer(Sender: TObject);
begin
Form1.downloadUpdate();
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin

end;

//разархивация файла с явками\паролями

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.downloadUpdate();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Form1.server_data_read();

 Form1.Timer1.Enabled:=true;
 //Form1.downloadUpdate();

end;

procedure TForm1.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
//Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+AWorkCount;
     ProgressBar1.Position := AWorkCount;

end;



procedure TForm1.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
//Form1.ProgressBar1.Max:=AWorkCountMax;
Form1.Label1.Caption:=Form1.Label1.Caption+' до версии '+ (ParamStr(1)+' '+ParamStr(2));
ProgressBar1.Position := 0;
 ProgressBar1.Max := AWorkcountMax;
end;

procedure TForm1.downloadUpdate();
var
  i,j : Integer;
 Stream:TMemoryStream;
 url,r,filename:WideString;
begin
Form1.Timer1.Enabled:=false;
  // Перед выполнением этого кода, используйте опцию меню Run/parameters
  // для установки следующих параметров командной строки: -parm1 -parm2
  // Показ этих параметров - обратите внимание, что 0-ой параметр это
  // выполняемая команда в Windows
//ShowMessage(ParamStr(1));
 //ShowMessage(ParamStr(1)+';;;'+ParamStr(2));

if ParamStr(1)='' then
  begin
    showmessage('Не передано параметров для обновления!'#13#10'Updater вызывается только из основной программы.');
    Application.Terminate;
  end;

try
Stream:=TMemoryStream.Create;
url:='http://'+server_data.ip+'/'+ParamStr(1)+'/'+Paramstr(1)+'_'+Paramstr(2)+'.exe';

for i:=1 to length(url) do
begin
if url[i]='.' then
begin
j:=i;
end;
end;
r:=copy(url,j+1,length(url));
Form1.IdHTTP1.Get(url,Stream);
filename:=  Paramstr(1)+'_'+Paramstr(2)+'.exe';
//Stream.SaveToFile(Paramstr(1)+'_'+Paramstr(2)+'.'+r);
Stream.SaveToFile(filename);
Stream.Free;
except
on e:Exception do
Stream.Free;
end;
//Form1.IdHTTP1.CleanupInstance;
   // переименовываем фалйы (который был - будет bak)
DeleteFile('OpenMCU_Manager.bak');
RenameFile('OpenMCU_Manager.exe','OpenMCU_Manager.bak');
 RenameFile(filename,'OpenMCU_Manager.exe');
//showmessage('Cкачивание обновления прошло успешно!');
  //Form1.Timer2.Enabled:=true;
  showmessage('Обновление успешно!');
Form1.Close;
Application.Terminate();
end;

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
end.

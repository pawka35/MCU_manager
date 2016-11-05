unit conf_copy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
LoadStream:TMemoryStream;
 PostData:TStringList;
 str,tmpstr:widestring;
 i,j:integer;
fil:textfile ;
begin

 LoadStream:=TMemoryStream.Create;
 //Form1.IdHTTP1.Get('http://'+server_data.ip+':'+inttostr(server_data.http_port)+'/monitor.txt',LoadStream);
Form1.IdHTTP1.Get('http://10.166.0.9/members_1.conf',LoadStream);
 LoadStream.Position:=0;
 PostData:=TStringList.create;
PostData.LoadFromStream(LoadStream);
  for i := 0 to 100 do
    begin
      assignfile(fil,'members_'+inttostr(i+1)+'.conf');
      rewrite(fil);
      write(fil,PostData.Text);
      CloseFile(fil);
    end;
 PostData.Free;
 LoadStream.Free;
Showmessage('Job is done!');
end;

end.

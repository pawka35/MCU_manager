unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
uses Unit1;



procedure TForm3.Button1Click(Sender: TObject);
begin
//Form3.WebBrowser1.Navigate('http://'+server_data.http_login+':'+server_data.http_password+'@'+server_data.ip+':'+inttostr(server_data.http_port)+'/Records');
end;

procedure TForm3.FormActivate(Sender: TObject);

begin

Form3.WebBrowser1.Navigate('http://'+'conf:conf@'+server_data.ip+':'+inttostr(server_data.http_port)+'/Records');
end;

end.

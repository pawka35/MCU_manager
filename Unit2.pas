unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, zlib ;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure CompressFile(const Source, Dest : String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.Button1Click(Sender: TObject);
var inifile: file of Unit1.Tserver_data;
begin
  Unit1.server_data.ip:=Form2.Edit3.Text;
  Unit1.server_data.http_port:=strtoint(Form2.MaskEdit2.Text);
  Unit1.server_data.http_login:=Form2.Edit4.Text;
  Unit1.server_data.http_password:=Form2.Edit5.Text;
  Unit1.server_data.telnet_port:=strtoint(Form2.MaskEdit3.Text);
  Unit1.server_data.telnet_login:=Form2.Edit1.Text;
  Unit1.server_data.telnet_password:=Form2.Edit2.Text;
AssignFile(inifile,'mcumanager_temp.mcu');
Rewrite(inifile);
Seek(inifile,0);
Write(inifile,Unit1.server_data);
CloseFile(inifile);
Form2.CompressFile('mcumanager_temp.mcu','mcumanager.mcu');
DeleteFile('mcumanager_temp.mcu');
Form1.Timer2.Enabled:=true;
Form1.Show;
Form2.Close;
//Form2.Free;
end;

procedure TForm2.CompressFile(const Source, Dest : String);
var
   SourceFile, DestFile : TFileStream;
   compr : TCompressionStream;
   bytecount : Integer;
begin
   SourceFile := TFileStream.Create(Source, fmOpenRead);
   DestFile := TFileStream.Create(Dest,fmCreate);
   try
     bytecount := SourceFile.Size;
     //store the original size in bytes
     DestFile.Write(bytecount, SizeOf(bytecount));
     //create the compression stream (after storing the bytecount!)
     compr := TCompressionStream.Create(clMax, DestFile);
     try
       //compress the content of the file
       compr.CopyFrom(SourceFile,bytecount);
     finally
       compr.Free;
     end;
   finally
     SourceFile.Free;
     DestFile.Free;
   end;
end;

end.

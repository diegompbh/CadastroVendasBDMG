unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB, Vcl.StdCtrls, TypInfo, System.Rtti, System.ImageList,
  Vcl.ImgList, IniFiles, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    Conexao: TADOConnection;
    Imagens: TImageList;
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Venda1: TMenuItem;
    Venda2: TMenuItem;
    Cliente1: TMenuItem;
    Cliente2: TMenuItem;
    Produto1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Venda2Click(Sender: TObject);
    procedure Venda1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uProduto, uCadastroCliente, uCadastroFornecedor, uCadastroProduto,
  uCadastroVenda, uRelatorio;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
   ArquivoINI: TIniFile;
   Server, DataBase, User, Password: String;
begin
   ArquivoINI := TIniFile.Create(GetCurrentDir + '\config.ini');

   Server   := ArquivoINI.ReadString('BD', 'Server', EmptyStr);
   DataBase := ArquivoINI.ReadString('BD', 'DataBase', EmptyStr);
   User     := ArquivoINI.ReadString('BD', 'User', EmptyStr);
   Password := ArquivoINI.ReadString('BD', 'Password', EmptyStr);

   Conexao.ConnectionString := 'Provider=SQLNCLI11.1;Persist Security Info=False; '
                             + 'User ID=' + User + ';'
                             + 'Password=' + Password + ';'
                             + 'Initial Catalog=' + DataBase + ';'
                             + 'Data Source=' + Server + ';'
                             + 'Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;'
                             + 'Workstation ID=RYZEN-7;Initial File Name="";Use Encryption for Data=False;Tag with column collation when possible=False;MARS Connection=False;DataTypeCompatibility=0;Trust Server Certificate=False;Server SPN="";Application Intent=READWRITE;';
   ArquivoINI.Free;
   Conexao.Connected := True;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  frmCliente := TfrmCliente.Create(nil);
  frmCliente.ShowModal;
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  frmFornecedor := TfrmFornecedor.Create(nil);
  frmFornecedor.ShowModal;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  frmProduto := TfrmProduto.Create(nil);
  frmProduto.ShowModal;
end;

procedure TfrmPrincipal.Venda1Click(Sender: TObject);
begin
  frmVenda := TfrmVenda.Create(nil);
  frmVenda.ShowModal;
end;

procedure TfrmPrincipal.Venda2Click(Sender: TObject);
begin
  frmRelatorio := TfrmRelatorio.Create(nil);
  frmRelatorio.ShowModal;
end;

end.

unit uRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Data.Win.ADODB,
  Vcl.StdCtrls;

type
  TfrmRelatorio = class(TForm)
    pgcRelatorios: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    dbgClientesAtivos: TDBGrid;
    dbgVendasEfetivadasCliente: TDBGrid;
    dtsClientesAtivos: TDataSource;
    dtsVendasEfetivadasCliente: TDataSource;
    lblCliente: TLabel;
    cmbCliente: TComboBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

uses uPrincipal, uRelatorios, uCliente;

{$R *.dfm}

procedure TfrmRelatorio.FormCreate(Sender: TObject);
var
   Clientes: TList;
   ClienteData: TClienteData;
   Cliente: TCliente;
begin
   pgcRelatorios.ActivePageIndex := 0;

   Cliente := TCliente.Create(frmPrincipal.Conexao, 'Cliente', 'Nome');
   Clientes := Cliente.CarregarClientes;

   for ClienteData in Clientes do
      cmbCliente.AddItem(ClienteData.Nome, ClienteData);
end;

procedure TfrmRelatorio.SpeedButton1Click(Sender: TObject);
var
   Query: TADOQuery;
begin
   Query := TRelatorios.RetornarClientesAtivos(frmPrincipal.Conexao);
   dtsClientesAtivos.DataSet := Query;
end;

procedure TfrmRelatorio.SpeedButton2Click(Sender: TObject);
var
   Query: TADOQuery;
begin
   if cmbCliente.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um cliente!', mtWarning, [mbOk], 0);
      Abort;
   end;

   Query := TRelatorios.RetornasVendasEfetivadasCliente(frmPrincipal.Conexao, TClienteData(cmbCliente.Items.Objects[cmbCliente.ItemIndex]).Codigo);
   dtsVendasEfetivadasCliente.DataSet := Query;

   TDateTimeField(Query.FieldByName('DataHora')).DisplayFormat := 'dd/mm/yyyy HH:nn:ss';
   TFloatField(Query.FieldByName('Preco')).DisplayFormat       := 'R$ #,##0.00';
   TFloatField(Query.FieldByName('Total')).DisplayFormat       := 'R$ #,##0.00';
end;

end.

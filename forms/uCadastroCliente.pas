unit uCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmCliente = class(TfrmPadrao)
    edtCPF: TLabeledEdit;
    edtNascimento: TLabeledEdit;
    cbxAtivo: TCheckBox;
    edtNome: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  protected
    procedure AtivarCampos(Ativo: Boolean); override;
    procedure LimparCampos; override;
    procedure PreencherCampos; override;
    procedure SalvarDados; override;
  end;

var
  frmCliente: TfrmCliente;

implementation

uses uPrincipal, uEntidade, uCliente;

{$R *.dfm}

{ TfrmCliente }

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
   inherited;
   Entidade := TCliente.Create(frmPrincipal.Conexao, 'Cliente', 'Nome');
end;

procedure TfrmCliente.AtivarCampos(Ativo: Boolean);
begin
   inherited;
   edtNome.ReadOnly       := not Ativo;
   edtCPF.ReadOnly        := not Ativo;
   edtNascimento.ReadOnly := not Ativo;
   cbxAtivo.Enabled       := Ativo;
end;

procedure TfrmCliente.LimparCampos;
begin
   inherited;
   edtNome.Clear;
   edtCPF.Clear;
   edtNascimento.Clear;
   cbxAtivo.Checked := False;
end;

procedure TfrmCliente.PreencherCampos;
begin
   inherited;
   if EntidadeData = nil then
      Exit;
   edtNome.Text       := TClienteData(EntidadeData).Nome;
   edtCPF.Text        := TClienteData(EntidadeData).CPF;
   edtNascimento.Text := FormatDateTime('dd/mm/yyyy', TClienteData(EntidadeData).DataNascimento);
   cbxAtivo.Checked   := TClienteData(EntidadeData).Ativo;
end;

procedure TfrmCliente.SalvarDados;
var
   cliente: TClienteData;
begin
   cliente := TClienteData.Create;
   cliente.Codigo         := StrToIntDef(edtCodigo.Text, 0);
   cliente.Nome           := edtNome.Text;
   cliente.CPF            := edtCPF.Text;
   cliente.DataNascimento := StrToDateDef(edtNascimento.Text, 0);
   cliente.Ativo          := cbxAtivo.Checked;

   Entidade.Salvar(TEntidadeData(cliente));
   EntidadeData := cliente;
end;

end.

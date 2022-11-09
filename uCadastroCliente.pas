unit uCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.UITypes, Math;

type
  TfrmCliente = class(TfrmPadrao)
    edtCPF: TLabeledEdit;
    edtNascimento: TLabeledEdit;
    cbxAtivo: TCheckBox;
    edtNome: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    function IsValidCPF(pCPF: string): Boolean;
  protected
    procedure AtivarCampos(Ativo: Boolean); override;
    procedure LimparCampos; override;
    procedure PreencherCampos; override;
    procedure SalvarDados; override;
  public

  end;

var
  frmCliente: TfrmCliente;

implementation

uses uPrincipal, uEntidade, uCliente;

{$R *.dfm}

{ TfrmCliente }

procedure TfrmCliente.btnSalvarClick(Sender: TObject);
begin
   if not IsValidCPF(edtCPF.Text) then
   begin
      MessageDlg('CPF inválido!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if StrToIntDef(edtCodigo.Text, 0) = 0 then
   begin
      if TCliente(Entidade).PesquisarCPF(edtCPF.Text) then
      begin
         MessageDlg('CPF já cadastrado!', mtWarning, [mbOk], 0);
         Abort;
      end;
   end;

   if StrToDateDef(edtNascimento.Text, 0) = 0 then
   if TCliente(Entidade).PesquisarCPF(edtCPF.Text) then
   begin
      MessageDlg('Data de nascimento inválida!', mtWarning, [mbOk], 0);
      Abort;
   end;

   inherited;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
   inherited;
   Entidade := TCliente.Create(frmPrincipal.Conexao, 'Cliente');
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

// Função retirada da internet
function TfrmCliente.IsValidCPF(pCPF: string): Boolean;
var
  v: array [0 .. 1] of Word;
  cpf: array [0 .. 10] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(pCPF) <> 11 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if pCPF = StringOfChar('0', 11) then
    Exit;

  if pCPF = StringOfChar('1', 11) then
    Exit;

  if pCPF = StringOfChar('2', 11) then
    Exit;

  if pCPF = StringOfChar('3', 11) then
    Exit;

  if pCPF = StringOfChar('4', 11) then
    Exit;

  if pCPF = StringOfChar('5', 11) then
    Exit;

  if pCPF = StringOfChar('6', 11) then
    Exit;

  if pCPF = StringOfChar('7', 11) then
    Exit;

  if pCPF = StringOfChar('8', 11) then
    Exit;

  if pCPF = StringOfChar('9', 11) then
    Exit;

  try
    for I := 1 to 11 do
      cpf[I - 1] := StrToInt(pCPF[I]);
    // Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
    v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
    v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);
    // Nota: Calcula o segundo dígito de verificação.
    v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
    v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
    v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
    v[1] := v[1] + 2 * v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    // Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;

end.

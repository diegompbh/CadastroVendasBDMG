unit uCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.UITypes, Math;

type
  TfrmFornecedor = class(TfrmPadrao)
    edtNomeFantasia: TLabeledEdit;
    edtRazaoSocial: TLabeledEdit;
    edtCNPJ: TLabeledEdit;
    cbxAtivo: TCheckBox;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function IsValidCNPJ(pCNPJ: string): Boolean;
  protected
    procedure AtivarCampos(Ativo: Boolean); override;
    procedure LimparCampos; override;
    procedure PreencherCampos; override;
    procedure SalvarDados; override;
  public

  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses uPrincipal, uEntidade, uFornecedor;

{$R *.dfm}

{ TfrmFornecedor }

procedure TfrmFornecedor.btnSalvarClick(Sender: TObject);
begin
   if not IsValidCNPJ(edtCNPJ.Text) then
   begin
      MessageDlg('CNPJ inválido!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if StrToIntDef(edtCodigo.Text, 0) = 0 then
   begin
      if TFornecedor(Entidade).PesquisarCNPJ(edtCNPJ.Text) then
      begin
         MessageDlg('CNPJ já cadastrado!', mtWarning, [mbOk], 0);
         Abort;
      end;
   end;

   inherited;
end;

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
   inherited;
   Entidade := TFornecedor.Create(frmPrincipal.Conexao, 'Fornecedor');
end;

procedure TfrmFornecedor.AtivarCampos(Ativo: Boolean);
begin
   inherited;
   edtNomeFantasia.ReadOnly := not Ativo;
   edtRazaoSocial.ReadOnly  := not Ativo;
   edtCNPJ.ReadOnly         := not Ativo;
   cbxAtivo.Enabled         := Ativo;
end;

procedure TfrmFornecedor.LimparCampos;
begin
   inherited;
   edtNomeFantasia.Clear;
   edtRazaoSocial.Clear;
   edtCNPJ.Clear;
   cbxAtivo.Checked := False;
end;

procedure TfrmFornecedor.PreencherCampos;
begin
   if EntidadeData = nil then
      Exit;
   inherited;
   edtNomeFantasia.Text := TFornecedorData(EntidadeData).NomeFantasia;
   edtRazaoSocial.Text  := TFornecedorData(EntidadeData).RazaoSocial;
   edtCNPJ.Text         := TFornecedorData(EntidadeData).CNPJ;
   cbxAtivo.Checked     := TFornecedorData(EntidadeData).Ativo;
end;

procedure TfrmFornecedor.SalvarDados;
var
   fornecedor: TFornecedorData;
begin
   fornecedor := TFornecedorData.Create;
   fornecedor.Codigo       := StrToIntDef(edtCodigo.Text, 0);
   fornecedor.NomeFantasia := edtNomeFantasia.Text;
   fornecedor.RazaoSocial  := edtRazaoSocial.Text;
   fornecedor.CNPJ         := edtCNPJ.Text;
   fornecedor.Ativo        := cbxAtivo.Checked;

   Entidade.Salvar(TEntidadeData(fornecedor));
   EntidadeData := fornecedor;
end;

// Função retirada da internet
function TfrmFornecedor.IsValidCNPJ(pCNPJ : string) : Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(pCNPJ) <> 14 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if pCNPJ = StringOfChar('0', 14) then
    Exit;

  if pCNPJ = StringOfChar('1', 14) then
    Exit;

  if pCNPJ = StringOfChar('2', 14) then
    Exit;

  if pCNPJ = StringOfChar('3', 14) then
    Exit;

  if pCNPJ = StringOfChar('4', 14) then
    Exit;

  if pCNPJ = StringOfChar('5', 14) then
    Exit;

  if pCNPJ = StringOfChar('6', 14) then
    Exit;

  if pCNPJ = StringOfChar('7', 14) then
    Exit;

  if pCNPJ = StringOfChar('8', 14) then
    Exit;

  if pCNPJ = StringOfChar('9', 14) then
    Exit;

  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(pCNPJ[i]);

    //Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    //Nota: Calcula o segundo dígito de verificação.
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);

    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;
end;

end.

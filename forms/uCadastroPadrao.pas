unit uCadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.UITypes, uEntidade;

type
  TfrmPadrao = class(TForm)
    ToolBar1: TToolBar;
    btnNovo: TToolButton;
    btnEditar: TToolButton;
    btnExcluir: TToolButton;
    btnSalvar: TToolButton;
    btnCancelar: TToolButton;
    btnPesquisar: TToolButton;
    edtCodigo: TLabeledEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  protected
    Entidade: TEntidade;
    EntidadeData: TEntidadeData;
    procedure LimparCampos; virtual;
    procedure AtivarCampos(Ativo: Boolean); virtual;
    procedure PreencherCampos; virtual;
    procedure SalvarDados; virtual; abstract;
  public
    { Public declarations }
  end;

var
  frmPadrao: TfrmPadrao;

implementation

uses uPrincipal;

{$R *.dfm}

{ TfrmPadrao }

procedure TfrmPadrao.AtivarCampos(Ativo: Boolean);
begin
   btnNovo.Enabled      := not Ativo;
   btnEditar.Enabled    := (not Ativo) and (edtCodigo.Text <> EmptyStr);
   btnExcluir.Enabled   := (not Ativo) and (edtCodigo.Text <> EmptyStr);
   btnSalvar.Enabled    := Ativo;
   btnCancelar.Enabled  := Ativo;
   btnPesquisar.Enabled := not Ativo;
end;

procedure TfrmPadrao.btnCancelarClick(Sender: TObject);
begin
   PreencherCampos;
   AtivarCampos(False);
end;

procedure TfrmPadrao.btnEditarClick(Sender: TObject);
begin
   AtivarCampos(True);
end;

procedure TfrmPadrao.btnExcluirClick(Sender: TObject);
begin
   if StrToIntDef(edtCodigo.Text, -1) = -1 then
      Exit;

   if MessageDlg('Confirmar exclusão do registro atual?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
   begin
      try
         Entidade.Excluir(StrToInt(edtCodigo.Text));
      except
         on E: Exception do
            MessageDlg('Erro ao excluir registro.', mtWarning, [mbOk], 0);
      end;
      LimparCampos;
      AtivarCampos(False);
   end;
end;

procedure TfrmPadrao.btnNovoClick(Sender: TObject);
begin
   LimparCampos;
   AtivarCampos(True);
end;

procedure TfrmPadrao.btnPesquisarClick(Sender: TObject);
var
   pesquisa: String;
begin
   InputQuery('Pesquisar', 'Digite o valor a ser pesquisado', pesquisa);

   if Trim(pesquisa) = EmptyStr then
      Exit;   

   if StrToIntDef(pesquisa, -1) = -1 then
      EntidadeData := Entidade.Pesquisar(pesquisa)
   else
      EntidadeData := Entidade.Pesquisar(StrToInt(pesquisa));

   if (EntidadeData = nil) or (EntidadeData.Codigo = 0) then
   begin
      EntidadeData := nil;
      LimparCampos;
      MessageDlg('Registro não encontrado.', mtWarning, [mbOk], 0)
   end
   else
      PreencherCampos;

   AtivarCampos(False);
end;

procedure TfrmPadrao.btnSalvarClick(Sender: TObject);
begin
   try
      SalvarDados;
      PreencherCampos;
      AtivarCampos(False);
   except
      on E: TValidacaoException do
         MessageDlg(E.Message, mtWarning, [mbOk], 0);
      on E: Exception do
         MessageDlg('Erro ao salvar registro.', mtWarning, [mbOk], 0);
   end;
end;

procedure TfrmPadrao.LimparCampos;
begin
   edtCodigo.Clear;
end;

procedure TfrmPadrao.PreencherCampos;
begin
   if EntidadeData = nil then
      LimparCampos
   else
      edtCodigo.Text := IntToStr(EntidadeData.Codigo);
end;

end.

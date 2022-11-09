program bdmg;

uses
  Vcl.Forms,
  uCliente in 'classes\uCliente.pas',
  uFornecedor in 'classes\uFornecedor.pas',
  uProduto in 'classes\uProduto.pas',
  uVenda in 'classes\uVenda.pas',
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCadastroPadrao in 'uCadastroPadrao.pas' {frmPadrao},
  uEntidade in 'classes\uEntidade.pas',
  uCadastroCliente in 'uCadastroCliente.pas' {frmCliente},
  uCadastroFornecedor in 'uCadastroFornecedor.pas' {frmFornecedor},
  uCadastroProduto in 'uCadastroProduto.pas' {frmProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

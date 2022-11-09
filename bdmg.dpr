program bdmg;

uses
  Vcl.Forms,
  uCliente in 'classes\uCliente.pas',
  uFornecedor in 'classes\uFornecedor.pas',
  uProduto in 'classes\uProduto.pas',
  uVenda in 'classes\uVenda.pas',
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCadastroPadrao in 'forms\uCadastroPadrao.pas' {frmPadrao},
  uEntidade in 'classes\uEntidade.pas',
  uCadastroCliente in 'forms\uCadastroCliente.pas' {frmCliente},
  uCadastroFornecedor in 'forms\uCadastroFornecedor.pas' {frmFornecedor},
  uCadastroProduto in 'forms\uCadastroProduto.pas' {frmProduto},
  uUtils in 'utils\uUtils.pas',
  uCadastroVenda in 'forms\uCadastroVenda.pas' {frmVenda},
  uVendaProduto in 'classes\uVendaProduto.pas',
  uRelatorios in 'classes\uRelatorios.pas',
  uRelatorio in 'forms\uRelatorio.pas' {frmRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

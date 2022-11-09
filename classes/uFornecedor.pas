unit uFornecedor;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, Classes, uEntidade;

type

   TFornecedorData = class(TEntidadeData)
   public
      NomeFantasia: String;
      RazaoSocial: String;
      CNPJ: String;
      Ativo: Boolean;
   end;

   TFornecedor = class(TEntidade)
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
      procedure ValidarObjeto(Entidade: TEntidadeData); override;
      function CarregarObjeto: TEntidadeData; override;
   public
      function PesquisarCNPJ(CNPJ: String): Boolean;
      function CarregarFornecedores: TList;
   end;

implementation

uses uUtils;

{ TFornecedor }

procedure TFornecedor.Inserir(var Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' insert into Fornecedor                              '
                   + ' values (:NomeFantasia, :RazaoSocial, :CNPJ, :Ativo) '
                   + ' select CodigoFornecedor = SCOPE_IDENTITY()          ';

   try
      try
         Query.Parameters.ParamByName('NomeFantasia').Value := TFornecedorData(Entidade).NomeFantasia;
         Query.Parameters.ParamByName('RazaoSocial').Value  := TFornecedorData(Entidade).RazaoSocial;
         Query.Parameters.ParamByName('CNPJ').Value         := TFornecedorData(Entidade).CNPJ;
         Query.Parameters.ParamByName('Ativo').Value        := TFornecedorData(Entidade).Ativo;
         Query.Open;

         Entidade.Codigo := Query.FieldByName('CodigoFornecedor').AsInteger;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao inserir fornecedor.');
      end;
   finally
      Query.Close;
   end;
end;

procedure TFornecedor.Atualizar(Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' update Fornecedor set                      '
                   + '    NomeFantasia = :NomeFantasia,           '
                   + '    RazaoSocial  = :RazaoSocial,            '
                   + '    CNPJ         = :CNPJ,                   '
                   + '    Ativo        = :Ativo                   '
                   + ' where CodigoFornecedor = :CodigoFornecedor ';

   try
      try
         Query.Parameters.ParamByName('CodigoFornecedor').Value := Entidade.Codigo;
         Query.Parameters.ParamByName('NomeFantasia').Value     := TFornecedorData(Entidade).NomeFantasia;
         Query.Parameters.ParamByName('RazaoSocial').Value      := TFornecedorData(Entidade).RazaoSocial;
         Query.Parameters.ParamByName('CNPJ').Value             := TFornecedorData(Entidade).CNPJ;
         Query.Parameters.ParamByName('Ativo').Value            := TFornecedorData(Entidade).Ativo;
         Query.ExecSQL;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao atualizar fornecedor.');
      end;
   finally
      Query.Close;
   end;
end;

function TFornecedor.CarregarObjeto: TEntidadeData;
begin
   Result := TFornecedorData.Create;

   if Query.IsEmpty then
      Result.Codigo := 0
   else
   begin
      Result.Codigo                        := Query.FieldByName('CodigoFornecedor').AsInteger;
      TFornecedorData(Result).NomeFantasia := Query.FieldByName('NomeFantasia').AsString;
      TFornecedorData(Result).RazaoSocial  := Query.FieldByName('RazaoSocial').AsString;
      TFornecedorData(Result).CNPJ         := Query.FieldByName('CNPJ').AsString;
      TFornecedorData(Result).Ativo        := Query.FieldByName('Ativo').AsBoolean;
   end;
end;

procedure TFornecedor.ValidarObjeto(Entidade: TEntidadeData);
begin
   inherited;
   if Trim(TFornecedorData(Entidade).NomeFantasia) = EmptyStr then
      Raise TValidacaoException.Create('É necessário preencher o Nome Fantasia!');

   if Trim(TFornecedorData(Entidade).RazaoSocial) = EmptyStr then
      Raise TValidacaoException.Create('É necessário preencher a Razão Social!');

   if not IsValidCNPJ(TFornecedorData(Entidade).CNPJ) then
      Raise TValidacaoException.Create('CNPJ inválido!');

   if TFornecedorData(Entidade).Codigo = 0 then
   begin
      if PesquisarCNPJ(TFornecedorData(Entidade).CNPJ) then
         Raise TValidacaoException.Create('CNPJ já cadastrado!');
   end;
end;

function TFornecedor.PesquisarCNPJ(CNPJ: String): Boolean;
begin
   Query.SQL.Text := ' select top 1 1 from Fornecedor where CNPJ = :CNPJ ';

   try
      try
         Query.Parameters.ParamByName('CNPJ').Value := CNPJ;
         Query.Open;

         Result := not Query.IsEmpty;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao pesquisar CNPJ.');
      end;
   finally
      Query.Close;
   end;
end;

function TFornecedor.CarregarFornecedores: TList;
var
   FornecedorData: TFornecedorData;
begin
   Result := TList.Create;

   Query.SQL.Text := ' select CodigoFornecedor, NomeFantasia, RazaoSocial, CNPJ, Ativo '
                   + ' from Fornecedor                                                 '
                   + ' order by NomeFantasia                                           ';

   try
      try
         Query.Open;

         while not Query.Eof do
         begin
            FornecedorData := TFornecedorData.Create;
            FornecedorData.Codigo       := Query.FieldByName('CodigoFornecedor').AsInteger;
            FornecedorData.NomeFantasia := Query.FieldByName('NomeFantasia').AsString;
            FornecedorData.RazaoSocial  := Query.FieldByName('RazaoSocial').AsString;
            FornecedorData.CNPJ         := Query.FieldByName('CNPJ').AsString;
            FornecedorData.Ativo        := Query.FieldByName('Ativo').AsBoolean;

            Result.Add(FornecedorData);

            Query.Next;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar fornecedores.');
      end;
   finally
      Query.Close;
   end;
end;

end.

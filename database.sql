create database bdmg
go

use bdmg

create table Cliente (
	CodigoCliente	int identity(1, 1),
	Nome			varchar(100) not null,
	CPF				varchar(11) not null,
	Ativo			bit not null,
	DataNascimento	datetime not null,
	primary key (CodigoCliente)
)
go

create table Fornecedor (
	CodigoFornecedor	int identity(1, 1),
	NomeFantasia		varchar(100) not null,
	RazaoSocial			varchar(100) not null,
	CNPJ				varchar(14) not null,
	Ativo				bit not null,
	primary key (CodigoFornecedor)
)
go

create table Produto (
	CodigoProduto		int identity(1, 1),
	CodigoFornecedor	int not null,
	Descricao			varchar(100) not null,
	Preco				decimal(15, 2) not null,
	Ativo				bit not null,
	primary key (CodigoProduto),
	foreign key (CodigoFornecedor) references Fornecedor (CodigoFornecedor)
)
go

create table Venda (
	CodigoVenda		int identity(1, 1),
	CodigoCliente	int not null,
	DataHora		datetime default getDate(),
	Status			bit not null,
	primary key (CodigoVenda),
	foreign key (CodigoCliente) references Cliente (CodigoCliente)
)
go

create table VendaProduto (
	CodigoVendaProduto	int identity(1, 1),
	CodigoVenda			int not null,
	CodigoProduto		int not null,
	Quantidade			int,
	primary key (CodigoVendaProduto),
	foreign key (CodigoVenda) references Venda (CodigoVenda),
	foreign key (CodigoProduto) references Produto (CodigoProduto)
)
go
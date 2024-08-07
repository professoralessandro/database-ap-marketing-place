/*
SCRIPT DE CRIACAO E GERACAO DO BANCO DE DADOS DE DESENVOLVIMENTO APDB (ALESSANDRO PROGRAMING). NOME PROVISORIO DO PROJETO
ESTE SCRIPT CONSISTE NA CRIACAO DAS TABELAS
DATA E HORA INICIO: 05/04/2021
CRIADOR: ALESSANDRO DOS SANTOS
VERSAO 1.0
*/
IF DB_ID('APDBDev') IS NOT NULL
BEGIN
	USE MASTER
	DROP DATABASE [APDBDev]
END
CREATE DATABASE [APDBDev]
GO

USE [APDBDev]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Schema SEG
-- -----------------------------------------------------

GO
CREATE SCHEMA [seg]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[StatusAprovacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[StatusAprovacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[StatusAprovacoes] (
		[StatusAprovacaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Descricao] VARCHAR(50) NOT NULL,
		[Valor] VARCHAR(50) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[Grupos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Grupos]') IS NULL
BEGIN
	CREATE TABLE [seg].[Grupos] (
	    [GrupoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	    [Descricao] [varchar](50) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[Usuarios]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Usuarios]') IS NULL
BEGIN
	CREATE TABLE [seg].[Usuarios] (
		[UsuarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[GrupoUsaruiId] UNIQUEIDENTIFIER,
		[Login] [varchar](50) NOT NULL,
		[NmrDocumento] VARCHAR(30) NOT NULL,
		[TipoDocumentoId] INT,
		[Senha] [varchar](max) NOT NULL,
		[Nome] [varchar](100) NOT NULL,
		[DataNascimento] [datetime] NOT NULL,
		[Sexo] [varchar](1) NULL,
		[EstadoCivil] [varchar](2) NULL,
		[Email] [varchar](255) NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[DataUltimaTrocaSenha] [datetime] NOT NULL,
		[DataUltimoLogin] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Usuarios_GrupoUsaruiId] FOREIGN KEY([GrupoUsaruiId])
		REFERENCES [seg].[Grupos] ([GrupoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[Recursos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Recursos]') IS NULL
BEGIN
	CREATE TABLE [seg].[Recursos] (
		[RecursoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Nome] [varchar](50) NOT NULL,
		[Chave] [varchar](100) NOT NULL,
		[ToolTip] [varchar](255) NULL,
		[Route] [varchar](max) NULL, -- ANTIGO URL
		[Menu] [bit] NOT NULL,
		[RecursoIdPai] [int] NULL,
		[Ordem] [int] NULL,
		[Ativo] [bit] NOT NULL,
		[Type] [varchar](100) NULL,
		[Icon] [varchar](100) NULL,
		[Path] [varchar](100) NULL, -- ANTIGO MENU CLASS
		[isSubMenu] [bit] NOT NULL		
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[GruposRecursos]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[GruposRecursos]') IS NULL
BEGIN
	CREATE TABLE [seg].[GruposRecursos] (
  		[GrupoRecursoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[GrupoId] UNIQUEIDENTIFIER,
		[RecursoId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_GruposRecursos_GrupoId] FOREIGN KEY([GrupoId])
		REFERENCES [seg].[Grupos] ([GrupoId]),
		CONSTRAINT [FK_GruposRecursos_RecursoId] FOREIGN KEY([RecursoId])
		REFERENCES [seg].[Recursos] ([RecursoId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [seg].[Workflows]
-- -----------------------------------------------------
IF OBJECT_ID('[seg].[Workflows]') IS NULL
BEGIN
	CREATE TABLE [seg].[Workflows] (
	    [WorkflowId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoWorkflowId] UNIQUEIDENTIFIER,
		[StatusAprovacaoId] UNIQUEIDENTIFIER,
	    [UsuarioResponsavel] INT NOT NULL,
		[Observacao] VARCHAR(MAX) NULL,
		[Descricao] VARCHAR(50) NULL,
		[DataWorkflowVerificacao] DATETIME NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Workflows_StatusAprovacaoId] FOREIGN KEY([StatusAprovacaoId])
		REFERENCES [dbo].[StatusAprovacoes] ([StatusAprovacaoId])
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[FormasPagamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[FormasPagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[FormasPagamentos] (
		[FormaPagamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Descricao] [varchar](50) NOT NULL,
		[PermiteParcelar] [bit] NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- -----------------------------------------------------
-- RELACIONAMENTOS 1 X 1 FIM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table [dbo].[Produtos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Produtos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Produtos] (
		[ProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoProdutoId] INT,
		[Titulo] VARCHAR(50) NOT NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[ResumoDetalhes] VARCHAR(200) NOT NULL,
		[CodigoBarras] VARCHAR(30) NULL,
		[Marca] VARCHAR(30) NULL,
		[Quantidade] INT NOT NULL,
		[IsIlimitado] BIT NOT NULL,
		[QuantidadeCritica] INT NULL,
		[PrecoCusto] DECIMAL(10,2) NOT NULL,
		[PrecoVenda] DECIMAL(10,2) NOT NULL,
		[Score] DECIMAL(3,2) DEFAULT 2.00 NOT NULL,
        [Relevance] DECIMAL(3,2) DEFAULT 2.00 NOT NULL,
		[Peso] INT NULL,
		[Altura] INT NULL,
		[Largura] INT NULL,
		[Comprimento] INT NULL,
		[Bloqueado] [bit] NOT NULL,
		[VendedorId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Produtos_VendedorId] FOREIGN KEY([VendedorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
    )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Caracteristicas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Caracteristicas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Caracteristicas] (
    	[CaracteristicaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoCaracteristicaId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
    	[Descricao] VARCHAR(MAX) NOT NULL,
    	[Ordem] INT NULL,
    	[Publico] BIT NOT NULL,
    	[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Caracteristicas_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Imagens]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Imagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Imagens] (
  		[ImagemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[Titulo] VARCHAR(50) NULL,
		[File] VARCHAR(100) NOT NULL,
    	[Descricao] VARCHAR(MAX) NULL,
		[ImagemPrincipal] BIT NOT NULL,
		[Publico] BIT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[ConfiguracoesParametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ImagensProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ImagensProdutos] (
		[ImagemProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ImagemId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_ImagensProdutos_ImagemId] FOREIGN KEY([ImagemId])
		REFERENCES [dbo].[Imagens] ([ImagemId]),
		CONSTRAINT [FK_ImagensProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[ConfiguracoesParametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ShoppingCart]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ShoppingCart] (
		[ShoppingCartId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioId] UNIQUEIDENTIFIER,
		[ProdutoId] UNIQUEIDENTIFIER,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL
		CONSTRAINT [FK_ShoppingCart_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_ShoppingCart_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Telefones]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Telefones]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Telefones] (
  		[TelefoneId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    	[TipoTelefoneId] UNIQUEIDENTIFIER,
		[Numero] VARCHAR(20) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[IsPrincipal] [bit] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[TelefonesUsuarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[TelefonesUsuarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[TelefonesUsuarios] (
  		[TelefoneUsuarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TelefoneId] UNIQUEIDENTIFIER,
		[UsuarioId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_TelefonesUsuarios_TelefoneId] FOREIGN KEY([TelefoneId])
		REFERENCES [dbo].[Telefones] ([TelefoneId]),
		CONSTRAINT [FK_TelefonesUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Enderecos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Enderecos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Enderecos] (
  		[EnderecoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoEnderecoId] INT,
		[Logradouro] VARCHAR(50) NOT NULL,
		[Numero] VARCHAR(10) NOT NULL,
		[Complemento] VARCHAR(10) NULL,
		[Bairro] VARCHAR(30) NULL,
		[Cidade] VARCHAR(30) NOT NULL,
		[Estado] VARCHAR(2) NOT NULL,
		[CEP] VARCHAR(8) NOT NULL,
		[PontoReferencia] VARCHAR(100) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[IsPrincipal] [bit] NOT NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[EnderecosUsuarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[EnderecosUsuarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[EnderecosUsuarios] (
  		[EnderecoUsuarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[EnderecoId] UNIQUEIDENTIFIER,
		[UsuarioId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_EnderecosUsuarios_EnderecoId] FOREIGN KEY([EnderecoId])
		REFERENCES [dbo].[Enderecos] ([EnderecoId]),
		CONSTRAINT [FK_EnderecosUsuarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Lancamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Lancamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Lancamentos] (
		[LancamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoLancamento] INT NOT NULL,
		[Status] INT NOT NULL,
		[Referencia] VARCHAR(50) NOT NULL,
		[ValorLancamento] DECIMAL(10, 2) NOT NULL,
		[DataBaixa] [datetime] NULL,
		[Observacao] [varchar](max) NULL,
		[UsuarioIdBaixa] UNIQUEIDENTIFIER NULL,
		[LancamentoIdPai] UNIQUEIDENTIFIER NULL,
		[QtdeParcelas] [int] NOT NULL,
		[NmrParcela] [int] NOT NULL,
		[ValorParcela] DECIMAL(10, 2) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Lancamentos_UsuarioInclusaoId] FOREIGN KEY([UsuarioInclusaoId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Garantias]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Garantias]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Garantias] (
  		[GarantiaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoGarantia] INT,
		[Descricao] VARCHAR(50) NOT NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[Periodo] VARCHAR(20)  NULL,
		[Inicio] [datetime] NULL,
		[Fim] [datetime] NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[NotasFiscais]
-- NOTAS FISCAIS SERA IMPLEMENTADO POSTERIORMENTE
-- -----------------------------------------------------
 IF OBJECT_ID('[dbo].[NotasFiscais]') IS NULL
 BEGIN
 	CREATE TABLE [dbo].[NotasFiscais] (
   		[NotaFiscalId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoNotaFiscalId] UNIQUEIDENTIFIER,
		[ChaveAcesso] VARCHAR(50) NULL,
		[UsuarioId] UNIQUEIDENTIFIER,
		[DestinatarioId] UNIQUEIDENTIFIER,
		[DadosAdicionais] VARCHAR(MAX) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_NotasFiscais_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_NotasFiscais_DestinatarioId] FOREIGN KEY([DestinatarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
   	)
 END
 GO
 SET ANSI_NULLS ON
 GO
 SET QUOTED_IDENTIFIER ON
 GO

-- -----------------------------------------------------
-- Table [dbo].[Emails]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Emails]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Emails] (
  		[EmailId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioEnvioId] UNIQUEIDENTIFIER,
		[TipoEmailId] UNIQUEIDENTIFIER,
		[NomeEmail] VARCHAR(100) NULL,
      	[Destinatario] VARCHAR(150) NOT NULL,
      	[Assunto] VARCHAR(100) NULL,
      	[Mensagem] VARCHAR(MAX) NOT NULL,
      	[Html] BIT NOT NULL,
      	[StatusEnvio] INT NOT NULL,
      	[Tentativas] INT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Emails_UsuarioEnvioId] FOREIGN KEY([UsuarioEnvioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Mensagens]
-- UNICO CAMPO BIG INT DO SISTEMA
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Mensagens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Mensagens] (
  		[MensagemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[RemetenteId] UNIQUEIDENTIFIER,
		[MensagemContexto] VARCHAR(MAX) NOT NULL,
		[TipoMensagemId] UNIQUEIDENTIFIER,
		[IsHtml] BIT NOT NULL,
		[DestinatarioId] UNIQUEIDENTIFIER,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Mensagens_RemetenteId] FOREIGN KEY([RemetenteId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Entregas]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Entregas]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Entregas] (
  		[EntregaId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ResponsavelEntregaId] UNIQUEIDENTIFIER,
		[TipoEntrega] INT NOT NULL,
		[DataPrevistaEntrega] DATETIME NULL,
		[DataEfetivaEnrega] DATETIME NULL,
		[Status] INT NOT NULL,
		[NmrDocumento] VARCHAR(50) NULL,
		[TipoDocumento] INT NULL,
		[NomeRecebedor] VARCHAR(100) NULL,
		[IsEntregueTitular] BIT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Entregas_ResponsavelEntregaId] FOREIGN KEY([ResponsavelEntregaId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- TODO: REMOVER DAS MODEL
-- -----------------------------------------------------
-- Table [dbo].[Bloqueios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Bloqueios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Bloqueios] (
  		[BloqueioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoBloqueioId] INT,
		[NomeBloqueio] VARCHAR(100) NOT NULL,
		[Permanente] BIT NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInicio] [datetime] NULL,
		[DataFim] [datetime] NULL,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Detalhes] VARCHAR(MAX) NOT NULL,
		[Ativo] [bit] NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- TODO: ALTERAR NOME NO PROJETO PARA: BloqueiosItens
-- COMMENT: THIS TABLE CAN BLOCK ANY ITEM LIKE USER, PRODUCT, SERVICE, ADRESS ETC...
-- -----------------------------------------------------
-- Table [dbo].[BloqueiosItens]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[BloqueiosItens]') IS NULL
BEGIN
	CREATE TABLE [dbo].[BloqueiosItens] (
  		[BloqueioItemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[BloqueioId] UNIQUEIDENTIFIER NOT NULL,
		[ItemId] UNIQUEIDENTIFIER NOT NULL,
		CONSTRAINT [FK_BloqueiosItens_BloqueioId] FOREIGN KEY([BloqueioId])
		REFERENCES [dbo].[Bloqueios] ([BloqueioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[DadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[DadosBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[DadosBancarios] (
  		[DadoBancarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioId] UNIQUEIDENTIFIER,
		[Banco] VARCHAR(100) NOT NULL,
		[Agencia] VARCHAR(6) NOT NULL,
		[Conta] VARCHAR(20) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_DadosBancarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------------
-- Table [dbo].[DadosBancarios]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[CartoesBancarios]') IS NULL
BEGIN
	CREATE TABLE [dbo].[CartoesBancarios] (
  		[CartaoBancarioId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[UsuarioId] UNIQUEIDENTIFIER,
		[Numero] VARCHAR(16) NOT NULL,
		[NomeNoCartao] VARCHAR(50) NOT NULL,
		[Bandeira] VARCHAR(10) NOT NULL,
		[Validade] VARCHAR(6) NOT NULL,
		[Tipo] VARCHAR(2) NOT NULL,
		[CodSeg] VARCHAR(3) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_CartoesBancarios_UsuarioId] FOREIGN KEY([UsuarioId])
		REFERENCES [seg].[Usuarios] ([UsuarioId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Configuracoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Configuracoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Configuracoes] (
  		[ConfiguracaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoConfiguracaoId] UNIQUEIDENTIFIER,
		[Descricao] VARCHAR(150) NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Parametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Parametros]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Parametros] (
		[ParametroId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[TipoParametroId] UNIQUEIDENTIFIER,
		[TipoDadoId] UNIQUEIDENTIFIER,
	  	[Descricao] [varchar](100) NOT NULL,
	  	[Valor] [varchar](max) NOT NULL,
	  	[Publico] [bit] NOT NULL,
	  	[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] DATETIME NOT NULL,
		[DataUltimaAlteracao] DATETIME NOT NULL,
		[Ativo] BIT NOT NULL
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Pagamentos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Pagamentos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Pagamentos] (
  		[PagamentoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  		[LancamentoId] UNIQUEIDENTIFIER,
		[CodigoPagamento] VARCHAR (30) NULL,
		[ChagoExterno] VARCHAR (50) NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Pagamentos_LancamentoId] FOREIGN KEY([LancamentoId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[ConfiguracoesParametros]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ConfiguracoesParametros]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ConfiguracoesParametros] (
		[ConfiguracaoParametroId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[ParametroId] UNIQUEIDENTIFIER,
		[ConfiguracaoId] UNIQUEIDENTIFIER,
		CONSTRAINT [FK_ConfiguracoesParametros_ParametroId] FOREIGN KEY([ParametroId])
		REFERENCES [dbo].[Parametros] ([ParametroId]),
		CONSTRAINT [FK_ConfiguracoesParametros_ConfiguracaoId] FOREIGN KEY([ConfiguracaoId])
		REFERENCES [dbo].[Configuracoes] ([ConfiguracaoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Compras]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Compras]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Compras] (
  		[CompraId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[CodigoCompra] VARCHAR(30) NULL,
		[CodigoExternoCompra] VARCHAR(50) NULL,
		[LinkExternoPagamento] VARCHAR(244) NULL,
		[Contador] BIGINT IDENTITY(1,1) NOT NULL,
  		[CompradorId] UNIQUEIDENTIFIER NOT NULL,
		[FormaPagamento] INT NOT NULL,
		[Status] INT NOT NULL,
		[EntregaId] UNIQUEIDENTIFIER,
		[LancamentoPaiId] UNIQUEIDENTIFIER NOT NULL,
		[GarantiaId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] BIT NOT NULL,
		CONSTRAINT [FK_Compras_CompradorId] FOREIGN KEY([CompradorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
		CONSTRAINT [FK_Compras_EntregaId] FOREIGN KEY([EntregaId])
		REFERENCES [dbo].[Entregas] ([EntregaId]),
		CONSTRAINT [FK_Compras_LancamentoPaiId] FOREIGN KEY([LancamentoPaiId])
		REFERENCES [dbo].[Lancamentos] ([LancamentoId]),
		CONSTRAINT [FK_Compras_GarantiaId] FOREIGN KEY([GarantiaId])
		REFERENCES [dbo].[Garantias] ([GarantiaId])
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[ComprasProdutos]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[ComprasProdutos]') IS NULL
BEGIN
	CREATE TABLE [dbo].[ComprasProdutos] (
		[CompraProdutoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[CompraId] UNIQUEIDENTIFIER NOT NULL,
		[Quantidade] INT NOT NULL,
		[ProdutoId] UNIQUEIDENTIFIER NOT NULL,
		CONSTRAINT [FK_ComprasProdutos_CompraId] FOREIGN KEY([CompraId])
		REFERENCES [dbo].[Compras] ([CompraId]),
		CONSTRAINT [FK_ComprasProdutos_ProdutoId] FOREIGN KEY([ProdutoId])
		REFERENCES [dbo].[Produtos] ([ProdutoId])
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Table [dbo].[Avaliacoes]
-- -----------------------------------------------------
IF OBJECT_ID('[dbo].[Avaliacoes]') IS NULL
BEGIN
	CREATE TABLE [dbo].[Avaliacoes] (
  		[AvaliacaoId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
		[CompraId] UNIQUEIDENTIFIER,
		[ItemId] UNIQUEIDENTIFIER,
    	[Comentario] VARCHAR(MAX) NOT NULL,
		[Valor] DECIMAL(2, 2) NOT NULL,
		[AvaliadorId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioInclusaoId] UNIQUEIDENTIFIER NOT NULL,
		[UsuarioUltimaAlteracaoId] UNIQUEIDENTIFIER,
		[DataInclusao] [datetime] NOT NULL,
		[DataUltimaAlteracao] [datetime] NULL,
		[Ativo] [bit] NOT NULL,
		CONSTRAINT [FK_Avaliacoes_CompraId] FOREIGN KEY([CompraId])
		REFERENCES [dbo].[Produtos] ([ProdutoId]),
		CONSTRAINT [FK_Avaliacoes_AvaliadorId] FOREIGN KEY([AvaliadorId])
		REFERENCES [seg].[Usuarios] ([UsuarioId]),
  	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- REGION FUNCTION DATABASE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Function [dbo].[FNCReturnIsItemcked]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS INFORMATION ABOUT ANY ITEM LIKE ADRESS, FONE, USER, PRODUCT IF IT HAS BLOCKED BY SISTEM
	CREATE FUNCTION [dbo].[FNCReturnIsItemcked](@ItemId UNIQUEIDENTIFIER) RETURNS INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsBlocked BIT;

    		SELECT @IsBlocked = CASE 
    		    WHEN EXISTS (
    		        SELECT
						[block].[BloqueioId]
						,[block].[NomeBloqueio]
						,[block].[Permanente]
						,[block].[UsuarioInclusaoId]
						,[block].[UsuarioUltimaAlteracaoId]
						,[block].[DataInicio]
						,[block].[DataFim]
						,[block].[DataInclusao]
						,[block].[DataUltimaAlteracao]
						,[block].[Ativo]
					FROM [APDBDev].[dbo].[Bloqueios] [block]
					INNER JOIN [APDBDev].[dbo].[BloqueiosItens] [item] ON [item].[ItemId] = @ItemId
					WHERE Ativo = 1
					AND [block].[Permanente] = 0
					AND GETDATE() BETWEEN [DataInicio] AND [DataFim]
    		    ) THEN 1 
    		    ELSE 0 
    		END;
    		RETURN @IsBlocked;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- REGION FUNCTION DATABASE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- REGION STORED PROCEDURE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Procedure [dbo].[ProdutosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[ProdutosPaginated]
		@Id UNIQUEIDENTIFIER,
		@Titulo VARCHAR(50),
		@TipoProduto INT,
		@Marca VARCHAR(30),
		@CodigoBarras VARCHAR(30),
		@IsBloqueado BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT,
		@UserId UNIQUEIDENTIFIER
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT
				[ProdutoId]			AS	Identifier
				,[TipoProdutoId]	AS 	ProductTypeEnum
				,[Titulo]
				,[Detalhes]
				,[CodigoBarras]
				,[Marca]
				,[Quantidade]
				,[IsIlimitado]
				,[QuantidadeCritica]
				,[PrecoCusto]
				,[PrecoVenda]
				,[Bloqueado]
				,[VendedorId]
				,[UsuarioInclusaoId]
				,[UsuarioUltimaAlteracaoId]
				,[DataInclusao]
				,[DataUltimaAlteracao]
				,[Ativo]
			FROM [APDBDev].[dbo].[Produtos]
			WHERE 		([ProdutoId]	=		  @Id					OR	@Id IS NULL)
			AND 		([Titulo]		LIKE '%' +@Titulo+ '%'			OR	@Titulo IS NULL)
			AND 		([TipoProdutoId] =		  @TipoProduto			OR	@TipoProduto IS NULL)
			AND 		([Marca]		LIKE '%' +@Marca+ '%'			OR	@Marca IS NULL)
			AND 		([CodigoBarras] LIKE '%' +@CodigoBarras+ '%'	OR	@CodigoBarras IS NULL)
			AND			([Bloqueado] = @IsBloqueado OR @IsBloqueado IS NULL)
			AND			([Ativo] = @Ativo OR @Ativo IS NULL)
			AND			(([UsuarioInclusaoId] = @UserId OR [UsuarioUltimaAlteracaoId] = @UserId) OR @UserId IS NULL)
			ORDER BY [Score], [ProdutoId] DESC
			OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT @RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[StoreProductPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 05/17/2024
	-- THIS PROCEDURE RETURNS TABLE PRODUTOS FOR STORE PAGINATED
	CREATE PROCEDURE [dbo].[StoreProductPaginated]
		@Param VARCHAR(MAX),
		@ProductId UNIQUEIDENTIFIER,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier],
				[T].[ProductTypeEnum],
				[T].[MainImage],
				[T].[Titulo],
				[T].[ResumoDetalhes],
				[T].[Detalhes],
				[T].[CodigoBarras],
				[T].[Marca],
				[T].[Quantidade],
				[T].[PrecoVenda],
				[T].[VendedorId]				AS 	[SellerId]
			FROM (
				SELECT
					[Prd].[ProdutoId]			AS	[Identifier]
					,[Prd].[TipoProdutoId]		AS 	[ProductTypeEnum]
					,[Img].[File]				AS 	[MainImage]
					,[dbo].[FNCReturnIsItemcked]([Prd].[ProdutoId]) AS [Blocked]
					,[Prd].[Titulo]
					,[Prd].[ResumoDetalhes]
					,[Prd].[Detalhes]
					,[Prd].[CodigoBarras]
					,[Prd].[Marca]
					,[Prd].[Quantidade]
					,[Prd].[PrecoVenda]
					,[Prd].[VendedorId]
				FROM [APDBDev].[dbo].[Produtos] [Prd]
				LEFT JOIN [APDBDev].[dbo].[ImagensProdutos] [PrdImg] ON [PrdImg].[ProdutoId] = [Prd].[ProdutoId]
				LEFT JOIN [APDBDev].[dbo].[Imagens] [Img] ON [PrdImg].[ImagemId] = [Img].[ImagemId] AND [Img].[ImagemPrincipal] = 1
				WHERE
				([Prd].[ProdutoId]										 =									@ProductId										OR	@ProductId IS NULL)
				AND
				(
							(UPPER([Prd].[Titulo])						LIKE 		UPPER(CONCAT('%',@Param,'%'))						OR	@Param IS NULL)
				OR 			(UPPER([Prd].[Marca])						LIKE 		UPPER(CONCAT('%',@Param,'%'))						OR	@Param IS NULL)
				OR 			(UPPER([Prd].[CodigoBarras]) 				LIKE 		UPPER(CONCAT('%',@Param,'%'))						OR	@Param IS NULL)
				OR			(CONVERT(VARCHAR(50),[Prd].[PrecoVenda])	=			CONVERT(VARCHAR(50),@Param)  						OR	@Param IS NULL)
				)
				AND [Prd].[Ativo] = 1
				AND [Prd].[Bloqueado] = 0
				ORDER BY [Prd].[Relevance] DESC, [Prd].[Score] DESC, [Prd].[DataInclusao] DESC, [Prd].[DataUltimaAlteracao] DESC
				OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT @RowspPage ROWS ONLY) [T]
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[AdressPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 05/17/2024
	-- THIS PROCEDURE RETURNS TABLE ADRESS FOR STORE PAGINATED THAT HAS NOT BLOCKED
	-- TODO: ATRIBUTE @Usuario NOT WORKING, TECNICAL DEBIT
	CREATE PROCEDURE [dbo].[AdressPaginated]
		@Id UNIQUEIDENTIFIER,
		@UserId UNIQUEIDENTIFIER,
		@Usuario VARCHAR(250),
		@TipoEndereco INT,
		@Logradouro VARCHAR(50),
		@IsPrincipal BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier]
      			,[T].[AddressTypeEnum]
				,[T].[UsuarioId]
      			,[T].[Logradouro]
      			,[T].[Numero]
      			,[T].[Complemento]
      			,[T].[Bairro]
      			,[T].[Cidade]
      			,[T].[Estado]
      			,[T].[CEP]
      			,[T].[PontoReferencia]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[IsPrincipal]
      			,[T].[Ativo]
			FROM (
				SELECT
					[end].[EnderecoId]			AS	Identifier
      				,[end].[TipoEnderecoId]		AS 	AddressTypeEnum
					,[dbo].[FNCReturnIsItemcked]([end].[EnderecoId]) AS Blocked
					,[usu].[UsuarioId]
      				,[end].[Logradouro]
      				,[end].[Numero]
      				,[end].[Complemento]
      				,[end].[Bairro]
      				,[end].[Cidade]
      				,[end].[Estado]
      				,[end].[CEP]
      				,[end].[PontoReferencia]
      				,[end].[UsuarioInclusaoId]
      				,[end].[UsuarioUltimaAlteracaoId]
      				,[end].[DataInclusao]
      				,[end].[DataUltimaAlteracao]
      				,[end].[IsPrincipal]
      				,[end].[Ativo]
				FROM [APDBDev].[dbo].[Enderecos] [end]
				LEFT JOIN [APDBDev].[dbo].[EnderecosUsuarios] [endusu]		ON [endusu].[EnderecoId] = [end].[EnderecoId]
				LEFT JOIN [APDBDev].[seg].[Usuarios] [usu] 				ON [usu].[UsuarioId]	 = [endusu].[UsuarioId]
				WHERE
							([end].[EnderecoId]		=		  		@Id					OR	@Id 		IS NULL)
				AND			
				(
								([usu].[UsuarioId]		=		  		@UserId				OR	@UserId 		IS NULL)
					AND			([usu].[Login]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
					AND 		([usu].[NmrDocumento]	LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
					AND 		([usu].[Nome]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
					AND 		([usu].[Email]			LIKE 	'%' +@Usuario+ '%'			OR	@Usuario 		IS NULL)
				)
				AND 		([end].[TipoEnderecoId]	 =		  	@TipoEndereco			OR	@TipoEndereco	IS NULL)
				AND 		([end].[Logradouro]		LIKE 	'%' +@Logradouro+ '%'		OR	@Logradouro 		IS NULL)
				AND 		([end].[IsPrincipal] 	 =		  	@IsPrincipal			OR	@IsPrincipal 	IS NULL)
				AND			([end].[Ativo] 			 = 			@Ativo 					OR	@Ativo 			IS NULL)
				AND			[usu].[Bloqueado] 		 = 			0
				ORDER BY [end].[Logradouro] DESC, [end].[DataInclusao] DESC, [end].[DataUltimaAlteracao] DESC
				OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT @RowspPage ROWS ONLY) [T]
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [seg].[ReturnUsersIsASystemAdmin]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [seg].[ReturnUsersIsASystemAdmin]
		@UserId UNIQUEIDENTIFIER
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsAdmin BIT;

    		SELECT @IsAdmin = CASE 
    		    WHEN EXISTS (
    		        SELECT 1 FROM seg.Usuarios us
					WHERE us.GrupoUsaruiId = (SELECT TOP 1 gp.GrupoId FROM seg.Grupos gp WHERE gp.Descricao = 'Master')
					AND us.UsuarioId = @UserId
    		    ) THEN 1 
    		    ELSE 0 
    		END;

    		SELECT @IsAdmin AS IsSystemAdmin;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnShoppingCartStore]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
	CREATE PROCEDURE [dbo].[ReturnShoppingCartStore]
		@UserId UNIQUEIDENTIFIER,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5

			SELECT
				[ShoppingCartId]			AS		Identifier
      			,[UsuarioId]
      			,[ProdutoId]
 			FROM [APDBDev].[dbo].[ShoppingCart]
			WHERE [UsuarioId] = @UserId 
			ORDER BY	1 DESC
			OFFSET		((@PageNumber - 1) * @RowspPage) ROWS
			FETCH NEXT	@RowspPage ROWS ONLY;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnIsItemBlocked]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2021
	-- THIS PROCEDURE RETURNS INFORMATION ABOUT ANY ITEM LIKE ADRESS, FONE, USER, PRODUCT IF IT HAS BLOCKED BY SISTEM
	CREATE PROCEDURE [dbo].[ReturnIsItemBlocked]
		@ItemId UNIQUEIDENTIFIER
	AS
		BEGIN
			-- ATRIB TESTE PROC
			DECLARE @IsBlocked BIT;

    		SELECT @IsBlocked = CASE 
    		    WHEN EXISTS (
    		        SELECT
						[block].[BloqueioId]
						,[block].[NomeBloqueio]
						,[block].[Permanente]
						,[block].[UsuarioInclusaoId]
						,[block].[UsuarioUltimaAlteracaoId]
						,[block].[DataInicio]
						,[block].[DataFim]
						,[block].[DataInclusao]
						,[block].[DataUltimaAlteracao]
						,[block].[Ativo]
					FROM [APDBDev].[dbo].[Bloqueios] [block]
					INNER JOIN [APDBDev].[dbo].[BloqueiosItens] [item] ON [item].[ItemId] = @ItemId
					WHERE Ativo = 1
					AND [block].[Permanente] = 0
					AND GETDATE() BETWEEN [DataInicio] AND [DataFim]
    		    ) THEN 1 
    		    ELSE 0 
    		END;
    		SELECT @IsBlocked AS IsItemBlocked;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnPurchasePaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2024
	-- THIS PROCEDURE RETURNS TABLE COMPRAS PAGINATED
	CREATE PROCEDURE [dbo].[ReturnPurchasePaginated]
		@CompraId UNIQUEIDENTIFIER,
		@CompradorId UNIQUEIDENTIFIER,
		@CodigoCompra VARCHAR(30),
		@Status BIT,
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier]
  			    ,[T].[CodigoCompra]
  			    ,[T].[CodigoExternoCompra]
				,[T].[LinkExternoPagamento]
  			    ,[T].[Contador]
  			    ,[T].[CompradorId]
  			    ,[T].[PaymentFormType]
  			    ,[T].[StatusPurchase]								
  			    ,[T].[EntregaId]
  			    ,[T].[LancamentoPaiId]
  			    ,[T].[GarantiaId]
  			    ,[T].[UsuarioInclusaoId]
  			    ,[T].[UsuarioUltimaAlteracaoId]
  			    ,[T].[DataInclusao]
  			    ,[T].[DataUltimaAlteracao]
  			    ,[T].[Ativo]
				,[T].[PurchaserId]
			FROM (
				SELECT
	  				[CompraId]										 	AS [Identifier]
					,[dbo].[FNCReturnIsItemcked]([CompraId]) 			AS [Blocked]
  				    ,[CodigoCompra]
  				    ,[CodigoExternoCompra]
					,[LinkExternoPagamento]
					,[CodigoPagamento]
  				    ,[Contador]
  				    ,[CompradorId]
  				    ,[FormaPagamento]									AS [PaymentFormType]
  				    ,[Status]											AS [StatusPurchase]							
  				    ,[EntregaId]
  				    ,[LancamentoPaiId]
  				    ,[GarantiaId]
  				    ,[UsuarioInclusaoId]
  				    ,[UsuarioUltimaAlteracaoId]
  				    ,[DataInclusao]
  				    ,[DataUltimaAlteracao]
  				    ,[Ativo]
					,[CompradorId]										AS [PurchaserId]
  				FROM [APDBDev].[dbo].[Compras]
				WHERE 	([CompraId]			=		  		@CompraId						OR	@CompraId 				IS NULL)
				AND		([CompradorId]		=		  		@CompradorId					OR	@CompradorId 			IS NULL)
				AND		([CodigoCompra]		=		  		@CodigoCompra					OR	@CodigoCompra 			IS NULL)
				AND		([CodigoCompra]		=		  		@CodigoCompra					OR	@CodigoCompra 			IS NULL)
				AND		([Status] 			= 				@Status 						OR	@Status 				IS NULL)
				AND		([Ativo] 			= 				@Ativo 							OR	@Ativo 					IS NULL)
				ORDER BY	1 DESC
				OFFSET		((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT	@RowspPage ROWS ONLY
			) AS T
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnPurchasePendingProcess]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2024
	-- THIS PROCEDURE RETURNS TABLE COMPRAS PAGINATED
	CREATE PROCEDURE [dbo].[ReturnPurchasePendingProcess]
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier]
  			    ,[T].[CodigoCompra]
  			    ,[T].[CodigoExternoCompra]
				,[T].[LinkExternoPagamento]
  			    ,[T].[Contador]
  			    ,[T].[CompradorId]
  			    ,[T].[PaymentFormType]
  			    ,[T].[StatusPurchase]								
  			    ,[T].[EntregaId]
  			    ,[T].[LancamentoPaiId]
  			    ,[T].[GarantiaId]
  			    ,[T].[UsuarioInclusaoId]
  			    ,[T].[UsuarioUltimaAlteracaoId]
  			    ,[T].[DataInclusao]
  			    ,[T].[DataUltimaAlteracao]
  			    ,[T].[Ativo]
			FROM (
				SELECT
	  				[CompraId]										 	AS [Identifier]
					,[dbo].[FNCReturnIsItemcked]([CompraId]) 			AS [Blocked]
  				    ,[CodigoCompra]
  				    ,[CodigoExternoCompra]
					,[LinkExternoPagamento]
  				    ,[Contador]
  				    ,[CompradorId]
  				    ,[FormaPagamento]									AS [PaymentFormType]
  				    ,[Status]											AS [StatusPurchase]							
  				    ,[EntregaId]
  				    ,[LancamentoPaiId]
  				    ,[GarantiaId]
  				    ,[UsuarioInclusaoId]
  				    ,[UsuarioUltimaAlteracaoId]
  				    ,[DataInclusao]
  				    ,[DataUltimaAlteracao]
  				    ,[Ativo]
  				FROM [APDBDev].[dbo].[Compras]
				WHERE
						[Status] 			= 				0
				OR		[Status] 			= 				2
				OR		[Status] 			= 				3
				AND		[Ativo] 			= 				1
			) AS T
			WHERE [T].[Blocked] = 0
			ORDER BY [T].[DataInclusao] DESC;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [dbo].[ReturnShopCartPurchaseByPurchaseId]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 08/05/2024
	-- THIS PROCEDURE RETURNS TABLE COMPRAS PAGINATED
	CREATE PROCEDURE [dbo].[ReturnShopCartPurchaseByPurchaseId]
	@PurchaseId UNIQUEIDENTIFIER
	AS
		BEGIN
			SELECT
				[CompraProdutoId]		AS Identifier
      			,[CompraId]
      			,[Quantidade]
      			,[ProdutoId]
  			FROM [APDBDev].[dbo].[ComprasProdutos]
			WHERE [CompraId] = @PurchaseId
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -- -----------------------------------------------------
-- -- Procedure [log].[LogsPaginated]
-- -- -----------------------------------------------------
-- 
-- 	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
-- 	-- CREATED BY ALESSANDRO 08/05/2021
-- 	-- THIS PROCEDURE RETURNS TABLE TIPOS TELEFONED PAGINATED
-- 	CREATE PROCEDURE [log].[LogsPaginated]
-- 		@Param VARCHAR(MAX),
-- 		@DateAdded DATETIME,
-- 		@PageNumber INT,
-- 		@RowspPage INT
-- 	AS
-- 		BEGIN
-- 			-- ATRIB TESTE PROC
-- 			-- SET @DateAdded = NULL
-- 			-- SET @Param = 'POST'
-- 			-- SET @PageNumber = 1
-- 			-- SET @RowspPage = 5
-- 			SELECT
-- 				[LogId]
-- 				,[Message]
-- 				,[Request]
-- 				,[Method]
-- 				,[Response]
-- 				,[UserAddedId]
-- 				,[DateAdded]
-- 			FROM 		[log].[Logs]
-- 			WHERE 
-- 					(LOWER(CONVERT(VARCHAR(50), [LogId])) = LOWER(CONVERT(VARCHAR(50), @Param))			OR		@Param IS NULL)
-- 			OR 		(LOWER([Message])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
-- 			OR 		(LOWER([Method])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
-- 			OR 		(LOWER([Request])	LIKE	'%'	+LOWER(@Param)+ '%'									OR		@Param IS NULL)
-- 			OR 		(LOWER(CONVERT(VARCHAR(50), [Response])) = LOWER(CONVERT(VARCHAR(50), @Param))		OR		@Param IS NULL)
-- 			OR 		(LOWER(CONVERT(VARCHAR(50), [UserAddedId])) = LOWER(CONVERT(VARCHAR(50), @Param))	OR		@Param IS NULL)
-- 			AND		([DateAdded] >= @DateAdded															OR		@DateAdded IS NULL)
-- 			ORDER BY	1 DESC
-- 			OFFSET		((@PageNumber - 1) * @RowspPage) ROWS
-- 			FETCH NEXT	@RowspPage ROWS ONLY;
-- 		END
-- GO
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

-- -----------------------------------------------------
-- Procedure [seg].[UsuariosPaginated]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 11/06/2024
	-- THIS PROCEDURE RETURNS USER UMBLOCKED PAGINATED
	CREATE PROCEDURE [seg].[UsuariosPaginated]
		@Id UNIQUEIDENTIFIER,
		@UserName VARCHAR(255),
		@Nome VARCHAR(255),
		@NmrDocumento VARCHAR(255),
		@Email VARCHAR(255),
		@Ativo BIT,
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @PageNumber = 2
			-- SET @RowspPage = 5
			SELECT
				[T].[Identifier]									AS	Identifier
      			,[T].[Login]
      			,[T].[NmrDocumento]
      			,[T].[TipoDocumentoId]
      			,[T].[Senha]
      			,[T].[Nome]
      			,[T].[DataNascimento]
      			,[T].[Sexo]
      			,[T].[EstadoCivil]
      			,[T].[Email]
      			,[T].[Bloqueado]
      			,[T].[UsuarioInclusaoId]
      			,[T].[UsuarioUltimaAlteracaoId]
      			,[T].[DataInclusao]
      			,[T].[DataUltimaAlteracao]
      			,[T].[DataUltimaTrocaSenha]
      			,[T].[DataUltimoLogin]
      			,[T].[Ativo]
			FROM (
				SELECT
					[User].[UsuarioId]									AS	Identifier
					,[dbo].[FNCReturnIsItemcked]([User].[UsuarioId]) 	AS 	Blocked
      				,[User].[Login]
      				,[User].[NmrDocumento]
      				,[User].[TipoDocumentoId]
      				,[User].[Senha]
      				,[User].[Nome]
      				,[User].[DataNascimento]
      				,[User].[Sexo]
      				,[User].[EstadoCivil]
      				,[User].[Email]
      				,[User].[Bloqueado]
      				,[User].[UsuarioInclusaoId]
      				,[User].[UsuarioUltimaAlteracaoId]
      				,[User].[DataInclusao]
      				,[User].[DataUltimaAlteracao]
      				,[User].[DataUltimaTrocaSenha]
      				,[User].[DataUltimoLogin]
      				,[User].[Ativo]
				FROM [APDBDev].[seg].[Usuarios] [User]
				WHERE 		([User].[UsuarioId]						=		  @Id					OR	@Id 			IS NULL)
				AND 		([User].[Login]							=		  @UserName				OR	@UserName 		IS NULL)
				AND 		([User].[Nome]							=		  @Nome					OR	@Nome	 		IS NULL)
				AND 		([User].[NmrDocumento]					=		  @NmrDocumento			OR	@NmrDocumento 	IS NULL)
				AND 		([User].[Email]							=		  @Email				OR	@Email 			IS NULL)
				AND			([User].[Ativo] 			 			= 		  @Ativo 				OR	@Ativo 			IS NULL)
				ORDER BY [User].[DataInclusao], [User].[Email], [User].[NmrDocumento] DESC
				OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT @RowspPage ROWS ONLY) [T]
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Procedure [seg].[ReturnUsersToSelect]
-- -----------------------------------------------------

	-- CREATING A PAGING WITH OFFSET and FETCH clauses IN "SQL SERVER 2012"
	-- CREATED BY ALESSANDRO 06/13/2024
	-- THIS PROCEDURE RETURNS TABLE THE USER BY PARAMETER PAGINATED
	CREATE PROCEDURE [seg].[ReturnUsersToSelect]
		@Param VARCHAR(MAX),
		@PageNumber INT,
		@RowspPage INT
	AS
		BEGIN
			-- ATRIB TESTE PROC
			-- SET @Param VARCHAR(MAX) = NULL,
			-- SET @PageNumber = 1
			-- SET @RowspPage = 10
			SELECT
				[T].[UsuarioId]			AS	[Key],
				[T].[Nome]				AS 	[Parameter]
			FROM (
				SELECT
					[usu].[UsuarioId]
					,[usu].[Nome]
					,[dbo].[FNCReturnIsItemcked]([usu].[UsuarioId]) AS Blocked
				FROM [APDBDev].[seg].[Usuarios] [usu]
				WHERE 
				(LOWER(CONVERT(VARCHAR(50),[usu].[UsuarioId]))			  =			LOWER(CONVERT(VARCHAR(50),@Param))
				OR 			LOWER([usu].[Login])											LIKE 		'%' + LOWER(@Param) + '%'
				OR 			LOWER([usu].[NmrDocumento])										LIKE 		'%' + LOWER(@Param) + '%'
				OR 			LOWER([usu].[Nome]) 											LIKE 		'%' + LOWER(@Param) + '%'
				OR 			LOWER([usu].[Email]) 											LIKE 		'%' + LOWER(@Param) + '%'
				OR	@Param IS NULL)
				AND [usu].[Ativo] = 1
				ORDER BY [usu].[Nome] DESC, [usu].[Email] DESC, [usu].[DataInclusao] DESC, [usu].[DataUltimaAlteracao] DESC
				OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
				FETCH NEXT @RowspPage ROWS ONLY) [T]
			WHERE [T].[Blocked] = 0;
		END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- REGION SEED DATABASE
-- -----------------------------------------------------

-- This regions will feed the inicial information that system needs to woks

-- -----------------------------------------------------
-- Feed table [seg].[Grupos]
-- -----------------------------------------------------

INSERT INTO [seg].[Grupos] ([GrupoId], [Descricao], [DataInclusao], [DataUltimaAlteracao], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [Ativo])
VALUES('59647e61-db07-4b43-993d-3f7eda18fe7f', 'System', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1),
('cb4ba730-222c-4b05-bb56-c2fec255bd9d', 'Master', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1),
('5877361c-6f05-41f6-a60d-7c7daa0feb64', 'User', GETDATE(), GETDATE(), '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [seg].[Usuarios]
-- -----------------------------------------------------

INSERT INTO [seg].[Usuarios]([UsuarioId], [Login], [GrupoUsaruiId], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('9a5f0c64-8103-4ee1-8acd-84b28090d898', 'System', '59647e61-db07-4b43-993d-3f7eda18fe7f', '00000000000', 1, '$@#$@#$FWSDWERFSSDFSDFF%Dss==', 'System', GETDATE(), 'N', 'N', 'system@appmkt.com.br', 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1),
('d2a833de-5bb4-4931-a3c2-133c8994072a', 'Master', 'cb4ba730-222c-4b05-bb56-c2fec255bd9d', '00000000000', 1, '@M45ter', 'Master', GETDATE(), 'N', 'N', 'master@appmkt.com.br', 0, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------
-- Feed table [dbo].[Produtos]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.Produtos
(ProdutoId, TipoProdutoId, Titulo, Detalhes, ResumoDetalhes, CodigoBarras, Marca, Quantidade, IsIlimitado, QuantidadeCritica, PrecoCusto, PrecoVenda, Score, Relevance, Peso, Altura, Largura, Comprimento, Bloqueado, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao, Ativo, VendedorId)
VALUES(N'BB27FD71-648F-4F70-E4A4-08DC7681957E', 0, 'Cesta de chocolates personalizada', 'Cesta de chocolates personalizada', 'Cesta de chocolates personalizada com diversos chocolates, chocotone.', N'', N'', 120, 0, 10, 150.01, 205.50, 4.90, 4.95, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898');

-- -----------------------------------------------------
-- Feed table [dbo].[Imagens]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.Imagens
(ImagemId, Titulo, [File], Descricao, ImagemPrincipal, Publico, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao)
VALUES('707820bb-e1f7-4c1c-86b0-15ed01d84f91', 'Imagem Teste 1', './assets/img/test/d90029fa-c1fc-4310-9913-4c64b57498c8.jpeg', 'Imagem Teste 1', 1, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE());

-- -----------------------------------------------------
-- Feed table [dbo].[ImagensProdutos]
-- -----------------------------------------------------

INSERT INTO APDBDev.dbo.ImagensProdutos
(ImagemProdutoId, ImagemId, ProdutoId)
VALUES('9c6cb1ac-2834-4a84-86aa-f40ef62dd072', '707820bb-e1f7-4c1c-86b0-15ed01d84f91', N'BB27FD71-648F-4F70-E4A4-08DC7681957E');

-- -----------------------------------------------------
-- DROPDATABASE AREA
-- -----------------------------------------------------
--USE MASTER
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

--DROP DATABASE APDBDev
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

GO

-- ADDING PRODUCTS
INSERT INTO APDBDev.dbo.Produtos
(ProdutoId, TipoProdutoId, Titulo, Detalhes, ResumoDetalhes, CodigoBarras, Marca, Quantidade, IsIlimitado, QuantidadeCritica, PrecoCusto, PrecoVenda, Score, Relevance, Peso, Altura, Largura, Comprimento, Bloqueado, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInclusao, DataUltimaAlteracao, Ativo, VendedorId)
VALUES
(N'253BED7B-CAC9-4309-AA6C-0BBDFFEA3BE4', 0, 'Forno Microondas 220V', 'Forno Microondas 220V', 'Forno Microondas 220V', N'', N'', 120, 0, 10, 500.01, 560.01, 5.00, 5.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'3C8CD641-8A05-410D-B767-0AAA56780229', 0, 'Forno Microondas 110V', 'Forno Microondas 110V', 'Forno Microondas 110V', N'', N'', 120, 0, 10, 500.01, 560.01, 4.90, 4.90, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'F55218E2-B6BE-48FE-9D36-093CB6C55A5F', 0, 'Caixa de fom JBL', 'Caixa de fom JBL', 'Caixa de fom JBL', N'', N'', 120, 0, 10, 2000.10, 2600.99, 4.80, 4.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'810CA71B-CF2C-4E80-A77B-094559C8A02D', 0, 'Caixa de fom Sony', 'Caixa de fom Sony', 'Caixa de fom JBL', N'', N'', 120, 0, 10, 2000.10, 2600.99, 4.70, 4.70, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(N'C8A81D50-264A-40C4-B139-00EEEA87BF18', 0, 'Teclado Yamaha PXS210', 'Teclado Yamaha PXS210', 'Teclado Yamaha PXS210', N'', N'', 120, 0, 10, 1200.10, 1680.99, 4.60, 4.60, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S24 Ultra', 'Smarth fone galaxy S24 Ultra', 'Smarth fone galaxy S24 Ultra', N'', N'', 120, 0, 10, 5000.10, 6100.99, 5.00, 5.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S24', 'Smarth fone galaxy S24', 'Smarth fone galaxy S24', N'', N'', 120, 0, 10, 4800.10, 5600.99, 4.95, 4.95, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S23 Ultra', 'Smarth fone galaxy S23 Ultra', 'Smarth fone galaxy S23 Ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4600.10, 5500.99, 4.95, 4.95, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S23', 'Smarth fone galaxy S23', 'Smarth fone galaxy S23 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4400.10, 5200.99, 4.90, 4.90, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S22 Ultra', 'Smarth fone galaxy S22 Ultra', 'Smarth fone galaxy S22 ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4200.10, 4900.99, 4.85, 4.85, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S22', 'Smarth fone galaxy S22', 'Smarth fone galaxy S22 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4800.10, 5600.99, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S21 Ultra', 'Smarth fone galaxy S21 Ultra', 'Smarth fone galaxy S21 Ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4500.10, 5400.99, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S21', 'Smarth fone galaxy S21', 'Smarth fone galaxy S21 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4300.10, 5200.99, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S20 Ultra', 'Smarth fone galaxy S20 Ultra', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4300.10, 5200.99, 4.70, 4.70, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S20', 'Smarth fone galaxy S21', 'Smarth fone galaxy S20 ficha tecnica abreviada', N'', N'', 120, 0, 10, 4200.10, 5100.99, 4.70, 4.70, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10 Ultra', 'Smarth fone galaxy S10 Ultra', 'Smarth fone galaxy S10 Ultra ficha tecnica abreviada', N'', N'', 120, 0, 10, 4100.10, 5100.99, 4.65, 4.65, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10 Plus', 'Smarth fone galaxy S10 Plus', 'Smarth fone galaxy S10 plus ficha tecnica abreviada', N'', N'', 120, 0, 10, 4000.10, 5000.99, 4.60, 4.60, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('df0d97a9-922e-41ab-8619-1782d45d2585', 0, 'Smarth fone galaxy S10 Blocked 1', 'Smarth fone galaxy S10 Blocked 1', 'Smarth fone galaxy S10 Blocked 1 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('5dd30a70-2c84-4699-9752-1b60bfdd72bc', 0, 'Smarth fone galaxy S10 Blocked 2', 'Smarth fone galaxy S10 Blocked 2', 'Smarth fone galaxy S10 Blocked 2 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('3ab620e8-4631-4c07-a65f-3fe6c55435a5', 0, 'Smarth fone galaxy S10 Blocked 3', 'Smarth fone galaxy S10 Blocked 3', 'Smarth fone galaxy S10 Blocked 3 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('72813eed-6d5d-44d4-97fa-f1807aa729b0', 0, 'Smarth fone galaxy S10 Plus Blocked Permanente 1', 'Smarth fone galaxy S10 Blocked Permanente 1', 'Smarth fone galaxy S10 Blocked Permanente 1 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('53581e36-5f3d-4752-bba7-d1626c81729a', 0, 'Smarth fone galaxy S10 Plus Blocked Permanente 2', 'Smarth fone galaxy S10 Blocked Permanente 2', 'Smarth fone galaxy S10 Blocked Permanente 2 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
('56b5e909-65ed-4e9b-b3cc-6785200b5dc2', 0, 'Smarth fone galaxy S10 Plus Blocked Permanente 3', 'Smarth fone galaxy S10 Blocked Permanente 3', 'Smarth fone galaxy S10 Blocked Permanente 3 ficha tecnica abreviada', N'', N'', 120, 0, 10, 1150.01, 1550.01, 4.80, 4.80, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), 0, 'Smarth fone galaxy S10', 'Smarth fone galaxy S10', 'Smarth fone galaxy S10 ficha tecnica abreviada', N'', N'', 120, 0, 10, 50.01, 65.01, 2.00, 2.00, NULL, NULL, NULL, NULL, 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, GETDATE(), NULL, 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898');

GO

-- ADDING PRODUCT SHOPPING CART
INSERT INTO APDBDev.dbo.ShoppingCart
(ShoppingCartId, UsuarioId, ProdutoId, UsuarioInclusaoId, DataInclusao)
VALUES(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'253BED7B-CAC9-4309-AA6C-0BBDFFEA3BE4', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'3C8CD641-8A05-410D-B767-0AAA56780229', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'F55218E2-B6BE-48FE-9D36-093CB6C55A5F', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'810CA71B-CF2C-4E80-A77B-094559C8A02D', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'C8A81D50-264A-40C4-B139-00EEEA87BF18', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9',GETDATE()),
(NEWID(), N'D2A833DE-5BB4-4931-A3C2-133C8994072A', N'BB27FD71-648F-4F70-E4A4-08DC7681957E', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9',GETDATE());

GO

-- ADDING BLOCK
INSERT INTO APDBDev.dbo.Bloqueios
(BloqueioId, TipoBloqueioId, NomeBloqueio, Permanente, UsuarioInclusaoId, UsuarioUltimaAlteracaoId, DataInicio, DataFim, DataInclusao, DataUltimaAlteracao, Detalhes, Ativo)
VALUES
('b853394f-2034-4e36-9efa-64ffd006770b', 0, 'Bloqueio - Smarth fone galaxy S10 Blocked', 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, '2020-01-01', '2025-01-01', GETDATE(), NULL, 'Bloqueio - Smarth fone galaxy S10 Blocked Detalhes', 1),
('7629714d-ffed-4298-adf5-417c9b703ff6', 0, 'Bloqueio - TESTE BLOQUEIO 2', 0, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, '2020-01-01', '2025-01-01', GETDATE(), NULL, 'Bloqueio - Smarth fone galaxy S10 Blocked Detalhes', 1),
('d5a8620a-d089-48e3-bc00-8ab227c40b90', 0, 'Bloqueio - Smarth fone galaxy S10 Plus Blocked Permanente', 1, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', NULL, NULL, NULL, GETDATE(), NULL, 'Bloqueio - Smarth fone galaxy S10 Blocked Detalhes', 1);

-- ADDING USER TO PRODUCTS
INSERT INTO APDBDev.dbo.BloqueiosItens
(BloqueioItemId, BloqueioId, ItemId)
VALUES
(NEWID(), 'b853394f-2034-4e36-9efa-64ffd006770b', 'df0d97a9-922e-41ab-8619-1782d45d2585'),
(NEWID(), 'd5a8620a-d089-48e3-bc00-8ab227c40b90', '72813eed-6d5d-44d4-97fa-f1807aa729b0');

-- ADDING END
INSERT INTO APDBDev.dbo.Enderecos
(EnderecoId, TipoEnderecoId, Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP, PontoReferencia, UsuarioInclusaoId, DataInclusao, IsPrincipal, Ativo)
VALUES
('68a3c26e-6569-4e3e-ac70-fef24ec9f91b', 1, 'Av Guaruja', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1, 1),
('d10424c6-200d-4a3f-9451-7c3f7c88304d', 1, 'TESTE BLOQUEIO 1', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1, 1),
('17b8af41-3634-47e5-8d50-6f4b2a7b2e4f', 1, 'TESTE BLOQUEIO 2', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1, 1),
('3e9c33e1-7afd-4e2d-a2a3-c24d4102c1b6', 1, 'Av Guaruja Teste END sem USER', '90', 'APTO 10', 'Jardim Enseada', 'Guarujá', 'SP', '11443080', 'Hortifruti Betel', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1, 1),
('75eea234-45aa-431c-b765-c737fc8c778e', 1, 'Test end purchaser faria lima', '90', 'APTO 10', 'Faria Lima', 'Sao Paulo', 'SP', '01451000', 'Hortifruti Betel', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1, 1);

-- ADDING USER TO ADRESS
INSERT INTO APDBDev.dbo.EnderecosUsuarios
(EnderecoUsuarioId, EnderecoId, UsuarioId)
VALUES
(NEWID(), '68a3c26e-6569-4e3e-ac70-fef24ec9f91b', 'd2a833de-5bb4-4931-a3c2-133c8994072a'),
(NEWID(), 'd10424c6-200d-4a3f-9451-7c3f7c88304d', '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), '17b8af41-3634-47e5-8d50-6f4b2a7b2e4f', '9a5f0c64-8103-4ee1-8acd-84b28090d898'),
(NEWID(), '3e9c33e1-7afd-4e2d-a2a3-c24d4102c1b6', '9a5f0c64-8103-4ee1-8acd-84b28090d898');

-- ADDING USER TO PRODUCTS
INSERT INTO APDBDev.dbo.BloqueiosItens
(BloqueioItemId, BloqueioId, ItemId)
VALUES
(NEWID(), '7629714d-ffed-4298-adf5-417c9b703ff6', 'd10424c6-200d-4a3f-9451-7c3f7c88304d');

-- ADDING MERCADO PAGO GARANTIAS
INSERT INTO APDBDev.dbo.Garantias
(GarantiaId, TipoGarantia, Descricao, Detalhes, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('4884f1f5-e119-49e6-a394-b3289a2bf539', 1, 'Compra Garantida', 'É um programa que garante o reembolso do dinheiro no caso de alguma contingência ao receber a compra', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- ADDING MERCADO PAGO LANCAMENTO TESTE
INSERT INTO APDBDev.dbo.Lancamentos
(LancamentoId, TipoLancamento, [Status], Referencia, ValorLancamento, DataBaixa, Observacao, UsuarioIdBaixa, LancamentoIdPai, QtdeParcelas, NmrParcela, ValorParcela, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('42f442b0-7cc4-4e0c-b693-e594ea3a1728', 2, 9999999, 'Lançamento mercado pago teste', 10.00, GETDATE(), 'Lançamento mercado pago teste', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', '42f442b0-7cc4-4e0c-b693-e594ea3a1728', 1, 1, 10.00, '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), 1);

-- INSERT ENTREGA EM MAOS
INSERT INTO APDBDev.dbo.Entregas
(EntregaId, TipoEntrega, [Status], UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('f5c91ff9-075d-4723-baac-a1cb8e7e41b2', 0, 7, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1);

-- INSERT ENTREGA LOJA MTK PLACE
INSERT INTO APDBDev.dbo.Entregas
(EntregaId, TipoEntrega, [Status], UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('86c9efc9-9812-442d-a8b5-8fed62a3f35c', 6, 7, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1);

-- INSERT ENTREGA EM TERCEIRO
INSERT INTO APDBDev.dbo.Entregas
(EntregaId, TipoEntrega, [Status], UsuarioInclusaoId, DataInclusao, Ativo)
VALUES('48d51e3a-6f27-4916-94b9-e9ad53c9e8bb', 6, 7, N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1);

-- INSERT PURCHASE PENDING TEST
INSERT INTO APDBDev.dbo.Compras
(CompraId, CodigoCompra, CodigoPagamento, CompradorId, FormaPagamento, Status, EntregaId, LancamentoPaiId, GarantiaId, UsuarioInclusaoId, DataInclusao, Ativo)
VALUES
('1a7f3db4-e82b-4ff9-98a7-68559b88f19b', '1318687938', '1318687938', 'd2a833de-5bb4-4931-a3c2-133c8994072a', 3, 0, 'f5c91ff9-075d-4723-baac-a1cb8e7e41b2', '42f442b0-7cc4-4e0c-b693-e594ea3a1728', '4884f1f5-e119-49e6-a394-b3289a2bf539', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1),
('2a7f3db4-e82b-4ff9-98a7-68559b88f1a0', '123456', '123456', 'd2a833de-5bb4-4931-a3c2-133c8994072a', 3, 0, 'f5c91ff9-075d-4723-baac-a1cb8e7e41b2', '42f442b0-7cc4-4e0c-b693-e594ea3a1728', '4884f1f5-e119-49e6-a394-b3289a2bf539', N'94C1212A-AF9F-49BB-9F21-8AA35103B7C9', GETDATE(), 1);

-- COMPRA PRODUTOS RELACIONADOS
INSERT INTO APDBDev.dbo.ComprasProdutos
(CompraProdutoId, CompraId, ProdutoId, Quantidade)
VALUES
('d01943d9-e459-4b21-841a-68c37f3a6e3e', '1a7f3db4-e82b-4ff9-98a7-68559b88f19b', 'df0d97a9-922e-41ab-8619-1782d45d2585', 2),
('d01943d9-e459-4b21-841b-61c37f3a6130', '1a7f3db4-e82b-4ff9-98a7-68559b88f19b', '53581e36-5f3d-4752-bba7-d1626c81729a', 1),
('d01943d9-e459-4b21-841a-68c37f3a6e31', '2a7f3db4-e82b-4ff9-98a7-68559b88f1a0', 'df0d97a9-922e-41ab-8619-1782d45d2585', 3),
('d01943d9-e459-4b21-841b-61c37f3a6132', '2a7f3db4-e82b-4ff9-98a7-68559b88f1a0', '53581e36-5f3d-4752-bba7-d1626c81729a', 4)
;

-- COMPRADOR TESTE
INSERT INTO [seg].[Usuarios]([UsuarioId], [Login], [GrupoUsaruiId], [NmrDocumento], [TipoDocumentoId], [Senha], [Nome], [DataNascimento], [Sexo], [EstadoCivil], [Email], [Bloqueado], [UsuarioInclusaoId], [UsuarioUltimaAlteracaoId], [DataInclusao], [DataUltimaAlteracao], [DataUltimaTrocaSenha], [DataUltimoLogin], [Ativo])
VALUES ('e0d83b70-39f3-4909-ad74-d44208520029', 'purchaser', '5877361c-6f05-41f6-a60d-7c7daa0feb64', '00000000000', 1, '$@#$@#$FWSDWERFSSDFSDFF%Dss==', 'Purchaser Test', GETDATE(), 'N', 'N', 'purchaser@appmkt.com.br', 1, '9a5f0c64-8103-4ee1-8acd-84b28090d898', '9a5f0c64-8103-4ee1-8acd-84b28090d898', GETDATE(), GETDATE(), GETDATE(), GETDATE(), 1);

-- ADDING USER TO ADRESS
INSERT INTO APDBDev.dbo.EnderecosUsuarios
(EnderecoUsuarioId, EnderecoId, UsuarioId)
VALUES
(NEWID(), '75eea234-45aa-431c-b765-c737fc8c778e', 'e0d83b70-39f3-4909-ad74-d44208520029');
-- phpMyAdmin SQL Dump
-- versão 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16/05/2024 às 18:00
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `trabalho_bd`
--

-- -------------------------------------------------------------
-- Cuidado isso apaga o banco de dados existente!
-- -------------------------------------------------------------
DROP DATABASE IF EXISTS `trabalho_bd`;
CREATE DATABASE `trabalho_bd`;
USE `trabalho_bd`;

DELIMITER $$ 

CREATE PROCEDURE `setup_database`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocorreu um erro! Revertendo todas as alterações.' AS Mensagem_Erro;
        ROLLBACK;
    END;

    START TRANSACTION;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Categoria`
--

CREATE TABLE `Categoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Usuario`
--

CREATE TABLE `Usuario` (
  `id` int(11) NOT NULL,
  `primeiroNome` varchar(20) NOT NULL,
  `ultimoNome` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `senha` varchar(400) NOT NULL,
  `verificado` tinyint(1) NOT NULL,
  `ativo` tinyint(1) NOT NULL,
  `funcionario` tinyint(1) NOT NULL,
  `ultimoLogin` datetime DEFAULT current_timestamp(),
  `superUsuario` tinyint(1) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Produto`
--

CREATE TABLE `Produto` (
  `id` int(11) NOT NULL,
  `nome` varchar(40) NOT NULL,
  `categoriaId` int(11) DEFAULT NULL,
  `subCategoria` varchar(40) NOT NULL,
  `descricao` varchar(150) NOT NULL,
  `nomeUrl` varchar(40) DEFAULT NULL,
  `estoque` int(100) NOT NULL,
  `preco` double NOT NULL,
  `promocao` tinyint(1) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `FotoProduto`
--

CREATE TABLE `FotoProduto` (
  `id` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `principal` tinyint(1) NOT NULL,
  `caminho` char(255) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Pedido`
--

CREATE TABLE `Pedido` (
  `id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `usuarioId` int(11) DEFAULT NULL,
  `valorTotal` float NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ItemPedido`
--

CREATE TABLE `ItemPedido` (
  `id` int(11) NOT NULL,
  `pedidoId` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Carrinho`
--

CREATE TABLE `Carrinho` (
  `id` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `usuarioId` int(11) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ItemCarrinho`
--

CREATE TABLE `ItemCarrinho` (
  `id` int(11) NOT NULL,
  `carrinhoId` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `precoInd` double(10,0) NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizadoEm` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `Categoria`
--
ALTER TABLE `Categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `Usuario`
--
ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `Produto`
--
ALTER TABLE `Produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoriaId` (`categoriaId`);

--
-- Índices de tabela `FotoProduto`
--
ALTER TABLE `FotoProduto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produtoId` (`produtoId`);

--
-- Índices de tabela `Pedido`
--
ALTER TABLE `Pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarioId` (`usuarioId`);

--
-- Índices de tabela `ItemPedido`
--
ALTER TABLE `ItemPedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produtoId` (`produtoId`),
  ADD KEY `pedidoId` (`pedidoId`);

--
-- Índices de tabela `Carrinho`
--
ALTER TABLE `Carrinho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produtoId` (`produtoId`),
  ADD KEY `usuarioId` (`usuarioId`);

--
-- Índices de tabela `ItemCarrinho`
--
ALTER TABLE `ItemCarrinho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carrinhoId` (`carrinhoId`),
  ADD KEY `produtoId` (`produtoId`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `Categoria`
--
ALTER TABLE `Categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `Usuario`
--
ALTER TABLE `Usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de tabela `Produto`
--
ALTER TABLE `Produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `FotoProduto`
--
ALTER TABLE `FotoProduto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Pedido`
--
ALTER TABLE `Pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT de tabela `ItemPedido`
--
ALTER TABLE `ItemPedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `Carrinho`
--
ALTER TABLE `Carrinho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `ItemCarrinho`
--
ALTER TABLE `ItemCarrinho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabela `Produto`
--
ALTER TABLE `Produto`
  ADD CONSTRAINT `Produto_ibfk_1` FOREIGN KEY (`categoriaId`) REFERENCES `Categoria` (`id`);

--
-- Restrições para tabela `FotoProduto`
--
ALTER TABLE `FotoProduto`
  ADD CONSTRAINT `FotoProduto_ibfk_1` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`);

--
-- Restrições para tabela `Pedido`
--
ALTER TABLE `Pedido`
  ADD CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`usuarioId`) REFERENCES `Usuario` (`id`);

--
-- Restrições para tabela `ItemPedido`
--
ALTER TABLE `ItemPedido`
  ADD CONSTRAINT `ItemPedido_ibfk_1` FOREIGN KEY (`pedidoId`) REFERENCES `Pedido` (`id`),
  ADD CONSTRAINT `ItemPedido_ibfk_2` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`);

--
-- Restrições para tabela `Carrinho`
--
ALTER TABLE `Carrinho`
  ADD CONSTRAINT `Carrinho_ibfk_1` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`),
  ADD CONSTRAINT `Carrinho_ibfk_2` FOREIGN KEY (`usuarioId`) REFERENCES `Usuario` (`id`);

--
-- Restrições para tabela `ItemCarrinho`
--
ALTER TABLE `ItemCarrinho`
  ADD CONSTRAINT `ItemCarrinho_ibfk_1` FOREIGN KEY (`carrinhoId`) REFERENCES `Carrinho` (`id`),
  ADD CONSTRAINT `ItemCarrinho_ibfk_2` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`);
  
  COMMIT;
  
END$$
DELIMITER ;

CALL `setup_database`();

DROP PROCEDURE IF EXISTS `setup_database`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

USE `trabalho_bd`; 

DROP USER IF EXISTS 'administrador'@'localhost';
DROP USER IF EXISTS 'cliente_01'@'localhost';
DROP USER IF EXISTS 'cliente_02'@'localhost';
DROP USER IF EXISTS 'cliente_03'@'localhost';

CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'senha_supersegura195';
CREATE USER 'cliente_01'@'localhost' IDENTIFIED BY 'senha_390';
CREATE USER 'cliente_02'@'localhost' IDENTIFIED BY 'senha_821';
CREATE USER 'cliente_03'@'localhost' IDENTIFIED BY 'senha_093';

GRANT ALL PRIVILEGES ON trabalho_bd.* TO 'administrador'@'localhost';

GRANT ALL PRIVILEGES ON trabalho_bd.* TO 'cliente_01'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON trabalho_bd.* FROM 'cliente_01'@'localhost';

GRANT SELECT ON trabalho_bd.* TO 'cliente_02'@'localhost';

GRANT UPDATE ON trabalho_bd.Produto TO 'cliente_02'@'localhost';
GRANT UPDATE ON trabalho_bd.FotoProduto TO 'cliente_02'@'localhost';
GRANT UPDATE ON trabalho_bd.Carrinho TO 'cliente_02'@'localhost';
GRANT UPDATE ON trabalho_bd.Pedido TO 'cliente_02'@'localhost';
GRANT UPDATE ON trabalho_bd.ItemPedido TO 'cliente_02'@'localhost';

GRANT ALL PRIVILEGES ON trabalho_bd.* TO 'cliente_03'@'localhost';
REVOKE DELETE ON trabalho_bd.* FROM 'cliente_03'@'localhost';

FLUSH PRIVILEGES;


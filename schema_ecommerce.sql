-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16/05/2024 às 18:00
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `trabalho_bd`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `ProdutoFoto`
--

CREATE TABLE `ProdutoFoto` (
  `id` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `isMain` tinyint(1) NOT NULL,
  `path` char(300) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Pedido`
--

CREATE TABLE `Pedido` (
  `id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `valorTotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PedidoItem`
--

CREATE TABLE `PedidoItem` (
  `id` int(11) NOT NULL,
  `pedidoId` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Categoria`
--

CREATE TABLE `Categoria` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Produto`
--

CREATE TABLE `Produto` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `categoriaId` int(11) DEFAULT NULL,
  `subCategory` varchar(40) NOT NULL,
  `description` varchar(150) NOT NULL,
  `urlName` varchar(40) DEFAULT NULL,
  `estoque` int(100) NOT NULL,
  `price` double NOT NULL,
  `promotion` tinyint(1) NOT NULL,
  `foto1` varchar(100) DEFAULT NULL,
  `foto2` varchar(100) DEFAULT NULL,
  `foto3` varchar(100) DEFAULT NULL,
  `foto4` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Usuario`
--

CREATE TABLE `Usuario` (
  `id` int(11) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(400) NOT NULL,
  `isVerified` tinyint(1) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `isStaff` tinyint(1) NOT NULL,
  `lastLogin` datetime DEFAULT current_timestamp(),
  `isSuperuser` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Carrinho`
--

CREATE TABLE `Carrinho` (
  `id` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `CarrinhoItem`
--

CREATE TABLE `CarrinhoItem` (
  `id` int(11) NOT NULL,
  `cartId` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `priceInd` double(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `ProdutoFoto`
--
ALTER TABLE `ProdutoFoto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produtoId` (`produtoId`);

--
-- Índices de tabela `Pedido`
--
ALTER TABLE `Pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Índices de tabela `PedidoItem`
--
ALTER TABLE `PedidoItem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produtoId` (`produtoId`),
  ADD KEY `pedidoId` (`pedidoId`);

--
-- Índices de tabela `Categoria`
--
ALTER TABLE `Categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `Produto`
--
ALTER TABLE `Produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoriaId` (`categoriaId`);

--
-- Índices de tabela `Usuario`
--
ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `Carrinho`
--
ALTER TABLE `Carrinho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produtoId` (`produtoId`),
  ADD KEY `userId` (`userId`);

--
-- Índices de tabela `CarrinhoItem`
--
ALTER TABLE `CarrinhoItem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cartId` (`cartId`),
  ADD KEY `produtoId` (`produtoId`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ProdutoFoto`
--
ALTER TABLE `ProdutoFoto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Pedido`
--
ALTER TABLE `Pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT de tabela `PedidoItem`
--
ALTER TABLE `PedidoItem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `Categoria`
--
ALTER TABLE `Categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `Produto`
--
ALTER TABLE `Produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `Usuario`
--
ALTER TABLE `Usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de tabela `Carrinho`
--
ALTER TABLE `Carrinho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `CarrinhoItem`
--
ALTER TABLE `CarrinhoItem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabela `ProdutoFoto`
--
ALTER TABLE `ProdutoFoto`
  ADD CONSTRAINT `ProdutoFoto_ibfk_1` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`);

--
-- Restrições para tabela `Pedido`
--
ALTER TABLE `Pedido`
  ADD CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Usuario` (`id`);

--
-- Restrições para tabela `PedidoItem`
--
ALTER TABLE `PedidoItem`
  ADD CONSTRAINT `PedidoItem_ibfk_1` FOREIGN KEY (`pedidoId`) REFERENCES `Pedido` (`id`),
  ADD CONSTRAINT `PedidoItem_ibfk_2` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`);

--
-- Restrições para tabela `Produto`
--
ALTER TABLE `Produto`
  ADD CONSTRAINT `Produto_ibfk_1` FOREIGN KEY (`categoriaId`) REFERENCES `Categoria` (`id`);

--
-- Restrições para tabela `Carrinho`
--
ALTER TABLE `Carrinho`
  ADD CONSTRAINT `Carrinho_ibfk_1` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`),
  ADD CONSTRAINT `Carrinho_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `Usuario` (`id`);

--
-- Restrições para tabela `CarrinhoItem`
--
ALTER TABLE `CarrinhoItem`
  ADD CONSTRAINT `CarrinhoItem_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `Carrinho` (`id`),
  ADD CONSTRAINT `CarrinhoItem_ibfk_2` FOREIGN KEY (`produtoId`) REFERENCES `Produto` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

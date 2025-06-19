USE `trabalho_bd`;
DELIMITER $$

CREATE PROCEDURE realizar_insercoes()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SELECT 'Erro na inserção. Transação revertida.' AS Resultado;
  END;

  START TRANSACTION;

  INSERT INTO Categoria (id, nome) VALUES 
    (1, 'Eletrônicos'), 
    (2, 'Roupas'), 
    (3, 'Livros');

  INSERT INTO Usuario (id, primeiroNome, ultimoNome, email, senha, verificado, ativo, funcionario, superUsuario)
  VALUES
    (1, 'Lucas', 'Silva', 'lucas@email.com', 'senha123', 1, 1, 0, 0),
    (2, 'Ana', 'Souza', 'ana@email.com', 'senha456', 1, 1, 1, 0);

  -- Atualiza auto_increment para evitar conflito
  ALTER TABLE Usuario AUTO_INCREMENT = 3;
  ALTER TABLE Categoria AUTO_INCREMENT = 4;

  INSERT INTO Produto (id, nome, categoriaId, subCategoria, descricao, nomeUrl, estoque, preco, promocao)
  VALUES
    (1, 'Smartphone Galaxy', 1, 'Celulares', 'Smartphone Android', 'smartphone-galaxy', 50, 1999.90, 0),
    (2, 'Camiseta Branca', 2, 'Masculino', 'Camiseta algodão', 'camiseta-branca', 100, 49.90, 1);

  ALTER TABLE Produto AUTO_INCREMENT = 3;

  INSERT INTO Pedido (status, usuarioId, valorTotal) VALUES ('Pendente', 1, 2049.80);
  SET @pedidoId = LAST_INSERT_ID();

  INSERT INTO ItemPedido (pedidoId, produtoId, quantidade)
  VALUES (@pedidoId, 1, 1), (@pedidoId, 2, 1);

  INSERT INTO Carrinho (id, produtoId, usuarioId) VALUES (1, 1, 2);

  INSERT INTO ItemCarrinho (carrinhoId, produtoId, quantidade, precoInd)
  VALUES (1, 1, 2, 1999);

  COMMIT;

  SELECT 'Inserções realizadas com sucesso!' AS Resultado;
END$$

DELIMITER ;

CALL realizar_insercoes();

DROP PROCEDURE IF EXISTS realizar_insercoes;

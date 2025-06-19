USE `trabalho_bd`;
DELIMITER $$

CREATE PROCEDURE realizar_delecoes()
BEGIN
  DECLARE ultimoPedidoId INT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SELECT 'Erro na exclusão. Transação revertida.' AS Resultado;
  END;

  START TRANSACTION;

  -- Busca o último pedido do usuário 1
  SELECT id INTO ultimoPedidoId FROM Pedido WHERE usuarioId = 1 ORDER BY id DESC LIMIT 1;

  DELETE FROM ItemCarrinho WHERE carrinhoId = 1;

  DELETE FROM Carrinho WHERE id = 1;

  DELETE FROM ItemPedido WHERE pedidoId = ultimoPedidoId;

  DELETE FROM Pedido WHERE id = ultimoPedidoId;

  DELETE FROM Produto WHERE id IN (1, 2);

  DELETE FROM Usuario WHERE id IN (1, 2);

  DELETE FROM Categoria WHERE id IN (1, 2, 3);

  COMMIT;

  SELECT 'Deleções realizadas com sucesso!' AS Resultado;
END$$

DELIMITER ;

CALL realizar_delecoes();
DROP PROCEDURE IF EXISTS realizar_delecoes;

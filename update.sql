USE `trabalho_bd`;
DELIMITER $$

CREATE PROCEDURE realizar_atualizacoes()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SELECT 'Erro na atualização. Transação revertida.' AS Resultado;
  END;

  START TRANSACTION;

  -- Atualiza nome da categoria com id = 1
  UPDATE Categoria
  SET nome = 'Eletrônicos e Tecnologia'
  WHERE id = 1;

  -- Diminui 1 unidade do estoque do produto com id = 1
  UPDATE Produto
  SET estoque = estoque - 1
  WHERE id = 1;

  -- Atualiza status do pedido (assumindo o último inserido)
  UPDATE Pedido
  SET status = 'Enviado'
  WHERE usuarioId = 1
  ORDER BY id DESC
  LIMIT 1;

  -- Atualiza ultimoLogin do usuário com id = 1 para o timestamp atual
  UPDATE Usuario
  SET ultimoLogin = NOW()
  WHERE id = 1;

  COMMIT;

  SELECT 'Atualizações realizadas com sucesso!' AS Resultado;
END$$

DELIMITER ;

CALL realizar_atualizacoes();
DROP PROCEDURE IF EXISTS realizar_atualizacoes;

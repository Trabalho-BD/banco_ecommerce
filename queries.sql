-- Fazer uma consulta que retorne a quantidade de pedidos por status.
SELECT status, COUNT(*) AS total
FROM Pedido
GROUP BY status;

-- Fazer uma consulta que retorne o total vendido por produto, ordenado por produtos mais vendidos.
SELECT p.nome, SUM(ip.quantidade) AS total_vendido
FROM ItemPedido ip
JOIN Produto p ON ip.produtoId = p.id
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 10;

-- Fazer uma consulta que retorne o total gasto por usuário, ordenado do maior para o menor.
SELECT u.primeiroNome, u.ultimoNome, COUNT(p.id) AS total_pedidos, 
       SUM(p.valorTotal) AS total_gasto
FROM Pedido p
JOIN Usuario u ON p.usuarioId = u.id
GROUP BY u.id
ORDER BY total_gasto DESC;

-- Fazer uma consulta que retorne o nome e preço dos produtos em promoção com estoque abaixo de 10.
SELECT nome, preco, estoque
FROM Produto
WHERE promocao = 1 AND estoque < 10;

-- Fazer uma consulta que retorne o total de produtos por categoria.
SELECT c.nome AS categoria, COUNT(p.id) AS total_produtos
FROM Produto p
JOIN Categoria c ON p.categoriaId = c.id
GROUP BY c.nome;

-- Fazer uma consulta que retorne o total de itens no carrinho por usuário, ordenado do maior para o menor.
SELECT u.email, COUNT(ic.id) AS total_itens
FROM ItemCarrinho ic
JOIN Carrinho c ON ic.carrinhoId = c.id
JOIN Usuario u ON c.usuarioId = u.id
GROUP BY u.id
ORDER BY total_itens DESC;

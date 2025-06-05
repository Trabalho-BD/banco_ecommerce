    #Fazer uma consulta que retorne a quantidade de pedidos por status.
    SELECT status, COUNT(*) AS total
    FROM pedido
    GROUP BY status;

    #Fazer uma consulta que retorne o total vendido por produto, ordenado por produtos mais vendidos.
    SELECT p.name, SUM(pi.quantity) AS total_vendido
    FROM pedidoitem pi
    JOIN produto p ON pi.produto_id = p.product_id
    GROUP BY p.name
    ORDER BY total_vendido DESC
    LIMIT 10;


    #Fazer uma consulta que retorne o total gasto por usuário, ordenado do maior para o menor.
    SELECT u.first_name, u.last_name, COUNT(p.delivery_id) AS total_pedidos, 
    SUM(p.valor_total) AS total_gasto
    FROM pedido p
    JOIN usuario u ON p.user_id = u.id
    GROUP BY u.id
    ORDER BY total_gasto DESC;
    
    #Fazer uma consulta que retorne o nome e preço dos produtos em promoção com estoque abaixo de 10.
    SELECT name, price, estoque
    FROM produto
    WHERE promotion = 1 AND estoque < 10;

    #Fazer uma consulta que retorne o total de produtos por categoria.
    SELECT c.name AS categoria, COUNT(p.product_id) AS total_produtos
    FROM produto p
    JOIN categoria c ON p.categoria_id = c.category_id
    GROUP BY c.name;

    #Fazer uma consulta que retorne o total de itens no carrinho por usuário, ordenado do maior para o menor.
    SELECT u.email, COUNT(ci.cartitem_id) AS total_itens
    FROM carrinhoitem ci
    JOIN carrinho c ON ci.cart_id = c.cart_id
    JOIN usuario u ON c.user_id = u.id
    GROUP BY u.id
    ORDER BY total_itens DESC;

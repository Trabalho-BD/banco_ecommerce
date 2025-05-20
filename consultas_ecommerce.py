import mysql.connector

# Função para conectar ao banco de dados
def conectar_banco():
    return mysql.connector.connect(
        host="localhost",
        user="root",         # Substitua pelo seu usuário
        password="",         # Substitua pela sua senha
        database="trabalho_bd"
    )

# Função para executar e retornar os resultados
def executar_consulta(query, params=None):
    conn = conectar_banco()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params or ())
    resultados = cursor.fetchall()
    cursor.close()
    conn.close()
    return resultados

# Funções com consultas
def pedidos_por_status():
    query = """
    SELECT status, COUNT(*) AS total
    FROM pedido
    GROUP BY status;
    """
    return executar_consulta(query)

def produtos_mais_vendidos():
    query = """
    SELECT p.name, SUM(pi.quantity) AS total_vendido
    FROM pedidoitem pi
    JOIN produto p ON pi.produto_id = p.product_id
    GROUP BY p.name
    ORDER BY total_vendido DESC
    LIMIT 10;
    """
    return executar_consulta(query)

def gasto_por_cliente():
    query = """
    SELECT u.first_name, u.last_name, COUNT(p.delivery_id) AS total_pedidos, 
           SUM(p.valor_total) AS total_gasto
    FROM pedido p
    JOIN usuario u ON p.user_id = u.id
    GROUP BY u.id
    ORDER BY total_gasto DESC;
    """
    return executar_consulta(query)

def produtos_em_promocao_com_baixo_estoque():
    query = """
    SELECT name, price, estoque
    FROM produto
    WHERE promotion = 1 AND estoque < 10;
    """
    return executar_consulta(query)

def produtos_por_categoria():
    query = """
    SELECT c.name AS categoria, COUNT(p.product_id) AS total_produtos
    FROM produto p
    JOIN categoria c ON p.categoria_id = c.category_id
    GROUP BY c.name;
    """
    return executar_consulta(query)

def itens_no_carrinho_por_usuario():
    query = """
    SELECT u.email, COUNT(ci.cartitem_id) AS total_itens
    FROM carrinhoitem ci
    JOIN carrinho c ON ci.cart_id = c.cart_id
    JOIN usuario u ON c.user_id = u.id
    GROUP BY u.id
    ORDER BY total_itens DESC;
    """
    return executar_consulta(query)

# Menu para o usuário
def menu():
    opcoes = {
        "1": ("Total de pedidos por status", pedidos_por_status),
        "2": ("Produtos mais vendidos", produtos_mais_vendidos),
        "3": ("Total gasto por cliente", gasto_por_cliente),
        "4": ("Produtos em promoção com estoque baixo", produtos_em_promocao_com_baixo_estoque),
        "5": ("Quantidade de produtos por categoria", produtos_por_categoria),
        "6": ("Itens adicionados ao carrinho por usuário", itens_no_carrinho_por_usuario),
    }

    while True:
        print("\n--- CONSULTAS E-COMMERCE ---")
        for chave, (desc, _) in opcoes.items():
            print(f"{chave}. {desc}")
        print("0. Sair")

        escolha = input("Escolha uma opção: ")

        if escolha == "0":
            break
        elif escolha in opcoes:
            descricao, funcao = opcoes[escolha]
            print(f"\n>>> {descricao} <<<\n")
            resultados = funcao()
            for linha in resultados:
                print(linha)
        else:
            print("Opção inválida.")

# Executar
if __name__ == "__main__":
    menu()

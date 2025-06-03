# 📦 Projeto E-Commerce - Banco de Dados MySQL

Este projeto simula a estrutura de um sistema de e-commerce com um banco de dados relacional MySQL/MariaDB, contendo entidades como usuários, produtos, pedidos, carrinho de compras e permissões de acesso. Além disso, inclui um script em Python para executar consultas analíticas úteis.

---

## 🗃️ Estrutura do Projeto

O banco de dados é criado e populado através de um dump SQL (`.sql`) com as seguintes funcionalidades:

- Criação e exclusão do banco de dados `trabalho_bd`
- Definição de tabelas principais como `Usuario`, `Produto`, `Pedido`, `Carrinho`, entre outras
- Criação de índices, relacionamentos e chaves estrangeiras
- Procedimento armazenado para setup com `ROLLBACK` em caso de erro
- Controle de permissões e criação de usuários com privilégios específicos

---

## 📊 Consultas Python com `mysql-connector-python`

O script `consultas.py` se conecta ao banco de dados MySQL e permite que o usuário escolha uma entre várias consultas SQL úteis:

### 🔎 Consultas disponíveis:

1. **Total de pedidos por status**  
   Agrupa e conta os pedidos por status (ex: "Pendente", "Entregue", etc.)

2. **Top 10 produtos mais vendidos**  
   Lista os produtos mais vendidos com base na soma das quantidades nos pedidos

3. **Total gasto por cliente**  
   Mostra o total gasto e número de pedidos por usuário

4. **Produtos em promoção com baixo estoque**  
   Exibe os produtos promocionais com estoque abaixo de 10 unidades

5. **Quantidade de produtos por categoria**  
   Agrupa os produtos por categoria

6. **Itens adicionados ao carrinho por usuário**  
   Lista quantos itens cada usuário adicionou ao carrinho

---

## 💡 Tecnologias Utilizadas

- **MySQL / MariaDB** – modelagem e criação de banco de dados relacional
- **Procedures SQL** – manipulação transacional de dados
- **Python 3** – execução de consultas SQL via `mysql-connector-python`
- **CLI Interativo** – interface simples via terminal para análise dos dados

---

## ⚙️ Como Executar

### 1. 🧱 Importar o banco de dados

Execute o script `.sql` no seu servidor MySQL (ex: via phpMyAdmin ou CLI):

```bash
mysql -u root -p < dump.sql


### 2. 🐍 Instalar dependências Python

```bash
pip install mysql-connector-python


### 3. ▶️ Executar script
python consultas.py



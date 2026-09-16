# Banco de dados da biblioteca

## Qual código usar em cada site

Há **dois códigos diferentes**, um para cada ferramenta:

| Onde colar | Arquivo | Conteúdo |
|---|---|---|
| **dbdiagram.io** | [`codigo_dbdiagram.dbml`](codigo_dbdiagram.dbml) | Somente a modelagem DBML do diagrama |
| **SQLite Online** | [`codigo_sqlite.sql`](codigo_sqlite.sql) | Criação das tabelas, dados e consultas SQL |

> **Importante:** não cole o arquivo DBML no SQLite e não cole o arquivo SQL no
> dbdiagram.io. Abra cada arquivo, copie todo o seu conteúdo e cole na ferramenta
> indicada na tabela acima.

Esta pasta contém a entrega completa das duas etapas da atividade.

## 1. Modelagem no dbdiagram.io

O arquivo [`codigo_dbdiagram.dbml`](codigo_dbdiagram.dbml) pode ser copiado diretamente para o editor do
[dbdiagram.io](https://dbdiagram.io). A imagem [`diagrama.svg`](diagrama.svg) é a
exportação pronta para entrega.

O modelo tem quatro tabelas e três relacionamentos **1:N**:

- um autor escreve vários livros; cada livro possui um autor;
- um livro pode aparecer em vários empréstimos; cada empréstimo se refere a um livro;
- um leitor realiza vários empréstimos; cada empréstimo pertence a um leitor.

## 2. Implementação no SQLite Online

1. Abra o [SQLite Online](https://sqliteonline.com/).
2. Selecione **SQLite** como banco.
3. Copie todo o conteúdo de [`codigo_sqlite.sql`](codigo_sqlite.sql), cole no editor e
   pressione **Run**.
4. Para visualizar separadamente cada resultado, selecione uma consulta `SELECT`
   por vez e pressione **Run**.

O roteiro ativa as chaves estrangeiras, recria as tabelas na ordem correta, inclui
os dados mínimos pedidos e contém as cinco consultas. Datas são armazenadas no
formato ISO `AAAA-MM-DD`, que permite comparação e ordenação corretas no SQLite.

## Resultados esperados das consultas

| Consulta | Resultado resumido |
|---|---|
| 1 | 5 livros |
| 2 | 5 leitores |
| 3 | 5 empréstimos, com leitor e livro |
| 4 | 3 livros do gênero Romance |
| 5 | 3 empréstimos sem devolução (IDs 2, 4 e 5) |

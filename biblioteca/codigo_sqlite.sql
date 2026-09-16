-- CÓDIGO 2 — SQLITE ONLINE
-- Cole TODO este arquivo no editor do SQLite Online e clique em Run.
-- Banco de dados da biblioteca - compatível com SQLite/SQLite Online.
-- Ativa a validação de chaves estrangeiras nesta conexão.
PRAGMA foreign_keys = ON;

-- Permite executar novamente este roteiro sem conflito com tabelas existentes.
DROP TABLE IF EXISTS emprestimos;
DROP TABLE IF EXISTS livros;
DROP TABLE IF EXISTS leitores;
DROP TABLE IF EXISTS autores;

CREATE TABLE autores (
    id_autor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    nacionalidade TEXT NOT NULL
);

CREATE TABLE livros (
    id_livro INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    ano_publicacao INTEGER NOT NULL CHECK (ano_publicacao > 0),
    genero TEXT NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 0 CHECK (quantidade >= 0),
    id_autor INTEGER NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE leitores (
    id_leitor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefone TEXT NOT NULL
);

CREATE TABLE emprestimos (
    id_emprestimo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_livro INTEGER NOT NULL,
    id_leitor INTEGER NOT NULL,
    data_emprestimo TEXT NOT NULL,
    data_devolucao TEXT,
    FOREIGN KEY (id_livro) REFERENCES livros (id_livro)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_leitor) REFERENCES leitores (id_leitor)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CHECK (data_devolucao IS NULL OR data_devolucao >= data_emprestimo)
);

INSERT INTO autores (id_autor, nome, nacionalidade) VALUES
    (1, 'Machado de Assis', 'Brasileira'),
    (2, 'George Orwell', 'Britânica'),
    (3, 'Clarice Lispector', 'Brasileira');

INSERT INTO livros
    (id_livro, titulo, ano_publicacao, genero, quantidade, id_autor)
VALUES
    (1, 'Dom Casmurro', 1899, 'Romance', 4, 1),
    (2, 'Memórias Póstumas de Brás Cubas', 1881, 'Romance', 3, 1),
    (3, '1984', 1949, 'Ficção distópica', 5, 2),
    (4, 'A Revolução dos Bichos', 1945, 'Fábula', 2, 2),
    (5, 'A Hora da Estrela', 1977, 'Romance', 4, 3);

INSERT INTO leitores (id_leitor, nome, email, telefone) VALUES
    (1, 'Ana Souza', 'ana.souza@example.com', '(11) 99911-2233'),
    (2, 'Bruno Lima', 'bruno.lima@example.com', '(21) 98822-3344'),
    (3, 'Carla Mendes', 'carla.mendes@example.com', '(31) 97733-4455'),
    (4, 'Diego Alves', 'diego.alves@example.com', '(41) 96644-5566'),
    (5, 'Elisa Rocha', 'elisa.rocha@example.com', '(51) 95555-6677');

INSERT INTO emprestimos
    (id_emprestimo, id_livro, id_leitor, data_emprestimo, data_devolucao)
VALUES
    (1, 1, 1, '2026-08-01', '2026-08-12'),
    (2, 3, 2, '2026-08-15', NULL),
    (3, 5, 3, '2026-08-20', '2026-09-01'),
    (4, 2, 1, '2026-09-02', NULL),
    (5, 4, 5, '2026-09-05', NULL);

-- CONSULTA 1: todos os livros cadastrados.
SELECT *
FROM livros
ORDER BY id_livro;

-- CONSULTA 2: todos os leitores cadastrados.
SELECT *
FROM leitores
ORDER BY id_leitor;

-- CONSULTA 3: empréstimos com o nome do leitor e o título do livro.
SELECT
    e.id_emprestimo,
    le.nome AS leitor,
    li.titulo AS livro,
    e.data_emprestimo,
    e.data_devolucao
FROM emprestimos AS e
INNER JOIN leitores AS le ON le.id_leitor = e.id_leitor
INNER JOIN livros AS li ON li.id_livro = e.id_livro
ORDER BY e.id_emprestimo;

-- CONSULTA 4: livros do gênero Romance.
SELECT *
FROM livros
WHERE genero = 'Romance'
ORDER BY titulo;

-- CONSULTA 5: empréstimos que ainda não possuem data de devolução.
SELECT
    e.id_emprestimo,
    le.nome AS leitor,
    li.titulo AS livro,
    e.data_emprestimo
FROM emprestimos AS e
INNER JOIN leitores AS le ON le.id_leitor = e.id_leitor
INNER JOIN livros AS li ON li.id_livro = e.id_livro
WHERE e.data_devolucao IS NULL
ORDER BY e.data_emprestimo;

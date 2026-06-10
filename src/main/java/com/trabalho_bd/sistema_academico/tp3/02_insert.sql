-- =============================================================================
-- SCRIPT 02: POPULAÇÃO DOS DADOS (DML)
-- =============================================================================

-- Inserindo Usuários (Gerais)
INSERT INTO USUARIO (nome, cpf, email, telefone) VALUES
('Ana Silva', '11122233344', 'ana.silva@univ.edu', '11999998888'), -- ID 1 (Aluno)
('Bruno Costa', '22233344455', 'bruno.c@univ.edu', '11988887777'), -- ID 2 (Aluno)
('Carlos Souza', '33344455566', 'carlos.s@univ.edu', NULL),        -- ID 3 (Aluno)
('Dr. Roberto Penha', '44455566677', 'roberto.p@univ.edu', '11977776666'), -- ID 4 (Prof)
('Dra. Maria Mendes', '55566677788', 'maria.m@univ.edu', '11966665555');  -- ID 5 (Prof)

-- Inserindo Cursos
INSERT INTO CURSO (nome_curso, carga_horaria_total) VALUES
('Ciência da Computação', 3200),
('Engenharia de Software', 3600);

-- Inserindo Alunos (Ligados aos IDs 1, 2 e 3 de USUARIO)
INSERT INTO ALUNO (id_usuario, matricula, dt_ingresso, IQD, id_curso) VALUES
(1, 'MAT2024001', '2024-02-15', 8.5, 1),
(2, 'MAT2024002', '2024-02-15', 9.2, 1),
(3, 'MAT2025001', '2025-02-10', 7.0, 2);

-- Inserindo Professores (Ligados aos IDs 4 e 5 de USUARIO)
INSERT INTO PROFESSOR (id_usuario, titulacao_max, area_pesquisa, link_lattes) VALUES
(4, 'Doutor', 'Banco de Dados e Big Data', 'http://lattes.cnpq.br/4444'),
(5, 'Doutora', 'Inteligência Artificial', 'http://lattes.cnpq.br/5555');

-- Inserindo Disciplinas
INSERT INTO DISCIPLINA (nome_disciplina, sigla, creditos, id_curso) VALUES
('Banco de Dados I', 'GBC043', 4, 1),
('Programação Orientada a Objetos', 'GBC022', 4, 1),
('Estruturas de Dados', 'GBC031', 4, 2);

-- Inserindo Salas
INSERT INTO SALA (bloco, cap_maxima) VALUES
('Bloco B', 40),
('Bloco C', 35),
('Laboratório 4', 25);

-- Inserindo Matrículas de Alunos nas Disciplinas (N:N)
-- Nota final deixada intencionalmente NULL para simular "Cursando"
INSERT INTO ALUNO_DISCIPLINA (id_usuario_aluno, id_disciplina, nota_final, frequencia, dt_desistencia) VALUES
(1, 1, NULL, 90.00, NULL),
(1, 2, 8.50, 95.00, NULL),
(2, 1, NULL, 100.00, NULL),
(2, 2, 9.80, 100.00, NULL),
(3, 3, NULL, 50.00, '2026-04-10'); -- Aluno desistiu desta matéria

-- Inserindo Alocações de Turmas (Ternário)
INSERT INTO ALOCACAO_TURMA (id_usuario_professor, id_disciplina, id_sala) VALUES
(4, 1, 1), -- Roberto em Banco de Dados na Sala Bloco B
(4, 2, 3), -- Roberto em POO no Laboratório 4
(5, 3, 2); -- Maria em Estrutura de Dados na Sala Bloco C

-- Inserindo Contratos de Estágio (1:1)
INSERT INTO CONTRATO_ESTAGIO (empresa_conced, data_inicio, valor_bolsa, id_usuario_aluno) VALUES
('Tech Solutions Ltda', '2025-06-01', 1500.00, 1),
('Inova Soft', '2026-01-10', 2000.00, 2);
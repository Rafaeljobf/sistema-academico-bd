-- =============================================================================
-- SCRIPT 04: ROTEIRO DE TESTES NO CONSOLE SQL
-- =============================================================================

-- 1. CONSULTA COM JOIN
-- Prova que o relacionamento ternário (Professor + Disciplina + Sala) está funcionando.
SELECT
    u.nome AS professor,
    p.titulacao_max,
    d.nome_disciplina,
    s.bloco,
    s.cap_maxima
FROM ALOCACAO_TURMA alt
JOIN PROFESSOR p ON alt.id_usuario_professor = p.id_usuario
JOIN USUARIO u ON p.id_usuario = u.id_usuario
JOIN DISCIPLINA d ON alt.id_disciplina = d.id_disciplina
JOIN SALA s ON alt.id_sala = s.id_sala;


-- 2. CONSULTA COM GROUP BY E FUNÇÃO DE AGREGAÇÃO
-- Calcula a quantidade de alunos e a média de frequência de cada disciplina.
SELECT
    d.nome_disciplina,
    COUNT(ad.id_usuario_aluno) AS total_alunos,
    ROUND(AVG(ad.frequencia), 2) AS media_frequencia
FROM ALUNO_DISCIPLINA ad
JOIN DISCIPLINA d ON ad.id_disciplina = d.id_disciplina
GROUP BY d.nome_disciplina;


-- 3. CONSULTA COM HAVING
-- Filtra e mostra apenas as disciplinas cuja média de notas dos alunos seja maior que 8.0.
SELECT
    d.nome_disciplina,
    AVG(ad.nota_final) AS media_notas
FROM ALUNO_DISCIPLINA ad
JOIN DISCIPLINA d ON ad.id_disciplina = d.id_disciplina
GROUP BY d.nome_disciplina
HAVING AVG(ad.nota_final) > 8.0;


-- 4. SUBCONSULTA (SUBQUERY)
-- Busca os alunos que possuem o IQD acima da média de todos os alunos cadastrados.
SELECT u.nome, a.matricula, a.IQD
FROM ALUNO a
JOIN USUARIO u ON a.id_usuario = u.id_usuario
WHERE a.IQD > (SELECT AVG(IQD) FROM ALUNO);


-- 5. USO DA VIEW CRIADA
-- Demonstra a tabela virtual que exibe "Cursando" para notas nulas (Regra de Negócio).
SELECT * FROM vw_historico_alunos;


-- 6. CONSULTA COMPATÍVEL COM O ÍNDICE
-- Realiza uma busca por substring no nome que aciona o índice criado para otimizar a performance.
SELECT * FROM USUARIO WHERE nome LIKE 'Ana%';


-- 7. TESTE DE VALIDAÇÃO DE RESTRIÇÃO DE INTEGRIDADE
-- Tenta inserir uma nota inválida (11.50). O banco DEVE bloquear.
-- Esperado: Erro de violação da restrição CHECK (CK_AL_DISC_NOTA).
INSERT INTO ALUNO_DISCIPLINA (id_usuario_aluno, id_disciplina, nota_final, frequencia)
VALUES (1, 3, 11.50, 80.00);


-- 8. TESTE DO GATILHO (TRIGGER)
-- Altera o IQD do Aluno 3 para 6.5 (abaixo do mínimo que é 7.0) e tenta inserir um contrato de estágio.
-- Esperado: O gatilho intercepta e dispara a EXCEPTION com a mensagem personalizada.
UPDATE ALUNO SET IQD = 6.5 WHERE id_usuario = 3;

INSERT INTO CONTRATO_ESTAGIO (empresa_conced, data_inicio, valor_bolsa, id_usuario_aluno)
VALUES ('Tech Falha', '2026-06-01', 1200.00, 3);

-- 9. EXECUÇÃO DE TRANSAÇÃO EXPLÍCITA
-- Garante que a criação de um Curso e de sua Disciplina aconteçam de forma atômica (tudo ou nada).
BEGIN;

INSERT INTO CURSO (nome_curso, carga_horaria_total)
VALUES ('Sistemas de Informação', 3000);

INSERT INTO DISCIPLINA (nome_disciplina, sigla, creditos, id_curso)
VALUES ('Segurança da Informação', 'GBC099', 4, (SELECT id_curso FROM CURSO WHERE nome_curso = 'Sistemas de Informação'));

COMMIT;

-- Confirmação do sucesso da transação
SELECT * FROM DISCIPLINA WHERE sigla = 'GBC099';
-- =============================================================================
-- SCRIPT 03: OBJETOS FÍSICOS COMPLEMENTARES
-- =============================================================================

-- 1. CRIAÇÃO DE ÍNDICE (Otimiza buscas por nome e substrings na aplicação)
CREATE INDEX idx_usuario_nome ON USUARIO (nome);


-- 2. CRIAÇÃO DE VIEW (Gera o histórico acadêmico unificado com JOINs)
CREATE OR REPLACE VIEW vw_historico_alunos AS
SELECT
    u.nome AS nome_aluno,
    a.matricula,
    c.nome_curso,
    d.nome_disciplina,
    d.sigla AS sigla_disciplina,
    COALESCE(TO_CHAR(ad.nota_final, '99.9'), 'Cursando') AS situacao_nota, -- Regra de negócio do relatório
    ad.frequencia
FROM ALUNO_DISCIPLINA ad
JOIN ALUNO a ON ad.id_usuario_aluno = a.id_usuario
JOIN USUARIO u ON a.id_usuario = u.id_usuario
JOIN DISCIPLINA d ON ad.id_disciplina = d.id_disciplina
JOIN CURSO c ON d.id_curso = c.id_curso;


-- 3. CRIAÇÃO DE GATILHO (Trigger em PL/pgSQL)
-- Regra de negócio: Alunos com IQD abaixo de 7.0 não podem assinar contratos de estágio.
CREATE OR REPLACE FUNCTION fn_valida_iqd_estagio()
RETURNS TRIGGER AS $$
DECLARE
    v_iqd DECIMAL(4,2);
BEGIN
    -- Busca o IQD do aluno que está recebendo o contrato
    SELECT IQD INTO v_iqd FROM ALUNO WHERE id_usuario = NEW.id_usuario_aluno;

    -- Valida o limite do IQD conforme regra de negócio
    IF v_iqd < 7.0 THEN
        RAISE EXCEPTION 'Contrato rejeitado! O aluno possui IQD de %, mas o mínimo exigido para estágio é 7.0.', v_iqd;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_valida_estagio_aluno
BEFORE INSERT OR UPDATE ON CONTRATO_ESTAGIO
FOR EACH ROW
EXECUTE FUNCTION fn_valida_iqd_estagio();
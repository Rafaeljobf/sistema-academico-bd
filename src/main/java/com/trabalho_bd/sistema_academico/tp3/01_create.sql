-- =============================================================================
-- SCRIPT 01: CRIAÇÃO DO BANCO DE DADOS (DDL)
-- =============================================================================

-- Remoção das tabelas existentes em ordem reversa para evitar problemas de FK
DROP TABLE IF EXISTS CONTRATO_ESTAGIO CASCADE;
DROP TABLE IF EXISTS ALOCACAO_TURMA CASCADE;
DROP TABLE IF EXISTS ALUNO_DISCIPLINA CASCADE;
DROP TABLE IF EXISTS SALA CASCADE;
DROP TABLE IF EXISTS DISCIPLINA CASCADE;
DROP TABLE IF EXISTS CURSO CASCADE;
DROP TABLE IF EXISTS PROFESSOR CASCADE;
DROP TABLE IF EXISTS ALUNO CASCADE;
DROP TABLE IF EXISTS USUARIO CASCADE;

-- 1. TABELA: USUARIO
CREATE TABLE USUARIO (
    id_usuario SERIAL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    CONSTRAINT PK_USUARIO PRIMARY KEY (id_usuario),
    CONSTRAINT UK_USUARIO_CPF UNIQUE (cpf)
);

-- 2. TABELA: CURSO
CREATE TABLE CURSO (
    id_curso SERIAL,
    nome_curso VARCHAR(100) NOT NULL,
    carga_horaria_total INT NOT NULL,
    CONSTRAINT PK_CURSO PRIMARY KEY (id_curso),
    CONSTRAINT CK_CURSO_CARGA CHECK (carga_horaria_total > 0)
);

-- 3. TABELA: ALUNO (Especialização de USUARIO)
CREATE TABLE ALUNO (
    id_usuario INT NOT NULL,
    matricula VARCHAR(20) NOT NULL,
    dt_ingresso DATE NOT NULL,
    IQD DECIMAL(4,2),
    id_curso INT NOT NULL,
    CONSTRAINT PK_ALUNO PRIMARY KEY (id_usuario),
    CONSTRAINT UK_ALUNO_MATRICULA UNIQUE (matricula),
    CONSTRAINT FK_ALUNO_USUARIO FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_ALUNO_CURSO FOREIGN KEY (id_curso)
        REFERENCES CURSO(id_curso) ON DELETE RESTRICT
);

-- 4. TABELA: PROFESSOR (Especialização de USUARIO)
CREATE TABLE PROFESSOR (
    id_usuario INT NOT NULL,
    titulacao_max VARCHAR(30) NOT NULL,
    area_pesquisa VARCHAR(100) NOT NULL,
    link_lattes VARCHAR(150),
    CONSTRAINT PK_PROFESSOR PRIMARY KEY (id_usuario),
    CONSTRAINT FK_PROFESSOR_USUARIO FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

-- 5. TABELA: DISCIPLINA
CREATE TABLE DISCIPLINA (
    id_disciplina SERIAL,
    nome_disciplina VARCHAR(100) NOT NULL,
    sigla VARCHAR(10) NOT NULL,
    creditos INT NOT NULL,
    id_curso INT NOT NULL,
    CONSTRAINT PK_DISCIPLINA PRIMARY KEY (id_disciplina),
    CONSTRAINT FK_DISCIPLINA_CURSO FOREIGN KEY (id_curso)
        REFERENCES CURSO(id_curso) ON DELETE RESTRICT,
    CONSTRAINT CK_DISCIPLINA_CREDITOS CHECK (creditos > 0)
);

-- 6. TABELA: SALA
CREATE TABLE SALA (
    id_sala SERIAL,
    bloco VARCHAR(10) NOT NULL,
    cap_maxima INT NOT NULL,
    CONSTRAINT PK_SALA PRIMARY KEY (id_sala),
    CONSTRAINT CK_SALA_CAPACIDADE CHECK (cap_maxima > 0)
);

-- 7. TABELA ASSOCIATIVA: ALUNO_DISCIPLINA (Relacionamento N:N)
CREATE TABLE ALUNO_DISCIPLINA (
    id_usuario_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    nota_final DECIMAL(4,2) DEFAULT NULL, -- Inicializado nulo conforme RN
    frequencia DECIMAL(5,2),
    dt_desistencia DATE,
    CONSTRAINT PK_ALUNO_DISCIPLINA PRIMARY KEY (id_usuario_aluno, id_disciplina),
    CONSTRAINT FK_AL_DISC_ALUNO FOREIGN KEY (id_usuario_aluno)
        REFERENCES ALUNO(id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_AL_DISC_DISC FOREIGN KEY (id_disciplina)
        REFERENCES DISCIPLINA(id_disciplina) ON DELETE CASCADE,
    CONSTRAINT CK_AL_DISC_NOTA CHECK (nota_final BETWEEN 0.00 AND 10.00),
    CONSTRAINT CK_AL_DISC_FREQ CHECK (frequencia BETWEEN 0.00 AND 100.00)
);

-- 8. TABELA ASSOCIATIVA: ALOCACAO_TURMA (Relacionamento Ternário)
CREATE TABLE ALOCACAO_TURMA (
    id_usuario_professor INT NOT NULL,
    id_disciplina INT NOT NULL,
    id_sala INT NOT NULL,
    CONSTRAINT PK_ALOCACAO_TURMA PRIMARY KEY (id_usuario_professor, id_disciplina, id_sala),
    CONSTRAINT FK_ALOC_PROF FOREIGN KEY (id_usuario_professor)
        REFERENCES PROFESSOR(id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_ALOC_DISC FOREIGN KEY (id_disciplina)
        REFERENCES DISCIPLINA(id_disciplina) ON DELETE CASCADE,
    CONSTRAINT FK_ALOC_SALA FOREIGN KEY (id_sala)
        REFERENCES SALA(id_sala) ON DELETE RESTRICT
);

-- 9. TABELA: CONTRATO_ESTAGIO (Relacionamento 1:1)
CREATE TABLE CONTRATO_ESTAGIO (
    id_contrato SERIAL,
    empresa_conced VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    valor_bolsa DECIMAL(10,2),
    id_usuario_aluno INT NOT NULL,
    CONSTRAINT PK_CONTRATO_ESTAGIO PRIMARY KEY (id_contrato),
    CONSTRAINT UK_CONTRATO_ALUNO UNIQUE (id_usuario_aluno), -- Garante a restrição 1:1
    CONSTRAINT FK_CONTRATO_ALUNO FOREIGN KEY (id_usuario_aluno)
        REFERENCES ALUNO(id_usuario) ON DELETE CASCADE
);
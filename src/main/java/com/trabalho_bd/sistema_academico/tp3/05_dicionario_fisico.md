# 05. Dicionário de Dados Físico Resumido

Este documento apresenta a especificação física das tabelas implementadas no SGBD PostgreSQL (via Supabase) para o sistema de controle acadêmico.

---

### 1. Tabela: `USUARIO`
* **Descrição:** Armazena os dados cadastrais gerais de todos os usuários do sistema (base para a especialização).

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario` | SERIAL | Obrigatório | Chave Primária (PK) | Auto-incremento sequencial automático. |
| `nome` | VARCHAR(100) | Obrigatório | Atributo Comum | Nome completo do usuário. |
| `cpf` | VARCHAR(11) | Obrigatório | Atributo Comum | Restrição UNIQUE (Chave Alternativa para evitar duplicidade). |
| `email` | VARCHAR(100) | Obrigatório | Atributo Comum | Endereço eletrônico de contato oficial. |
| `telefone` | VARCHAR(20) | Opcional | Atributo Comum | Registro opcional de contato telefônico. |

---

### 2. Tabela: `CURSO`
* **Descrição:** Armazena as informações dos cursos de graduação oferecidos pela instituição.

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_curso` | SERIAL | Obrigatório | Chave Primária (PK) | Auto-incremento sequencial automático. |
| `nome_curso` | VARCHAR(100) | Obrigatório | Atributo Comum | Nome oficial descritivo da graduação. |
| `carga_horaria_total` | INT | Obrigatório | Atributo Comum | Restrição CHECK (> 0) para garantir horas válidas. |

---

### 3. Tabela: `ALUNO`
* **Descrição:** Subclasse da entidade USUARIO, contendo informações específicas dos discentes.

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario` | INT | Obrigatório | PK e FK | Chave Primária e Estrangeira. Referencia `USUARIO(id_usuario)` com ON DELETE CASCADE. |
| `matricula` | VARCHAR(20) | Obrigatório | Atributo Comum | Restrição UNIQUE (Chave Alternativa para controle acadêmico). |
| `dt_ingresso` | DATE | Obrigatório | Atributo Comum | Data oficial de início do vínculo com a instituição. |
| `IQD` | DECIMAL(4,2) | Opcional | Atributo Comum | Índice de Qualificação do Discente. |
| `id_curso` | INT | Obrigatório | Chave Estrangeira (FK) | Referencia `CURSO(id_curso)` com restrição ON DELETE RESTRICT. |

---

### 4. Tabela: `PROFESSOR`
* **Descrição:** Subclasse da entidade USUARIO, contendo informações específicas do corpo docente.

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario` | INT | Obrigatório | PK e FK | Chave Primária e Estrangeira. Referencia `USUARIO(id_usuario)` com ON DELETE CASCADE. |
| `titulacao_max` | VARCHAR(30) | Obrigatório | Atributo Comum | Maior nível acadêmico atingido (Ex: Mestre, Doutor). |
| `area_pesquisa` | VARCHAR(100) | Obrigatório | Atributo Comum | Linha ou área de concentração científica principal. |
| `link_lattes` | VARCHAR(150) | Opcional | Atributo Comum | Link de direcionamento para o Currículo Lattes. |

---

### 5. Tabela: `DISCIPLINA`
* **Descrição:** Componentes curriculares (matérias) vinculadas a um curso específico.

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_disciplina` | SERIAL | Obrigatório | Chave Primária (PK) | Auto-incremento sequencial automático. |
| `nome_disciplina` | VARCHAR(100) | Obrigatório | Atributo Comum | Nome oficial da matéria. |
| `sigla` | VARCHAR(10) | Obrigatório | Atributo Comum | Código identificador (Ex: GBC043). |
| `creditos` | INT | Obrigatório | Atributo Comum | Restrição CHECK (> 0) para número de créditos válidos. |
| `id_curso` | INT | Obrigatório | Chave Estrangeira (FK) | Referencia `CURSO(id_curso)` com restrição ON DELETE RESTRICT. |

---

### 6. Tabela: `SALA`
* **Descrição:** Infraestrutura física das salas de aula e laboratórios do campus.

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_sala` | SERIAL | Obrigatório | Chave Primária (PK) | Auto-incremento sequencial automático. |
| `bloco` | VARCHAR(10) | Obrigatório | Atributo Comum | Identificação do prédio ou bloco físico (Ex: Bloco B). |
| `cap_maxima` | INT | Obrigatório | Atributo Comum | Restrição CHECK (> 0) para garantir capacidade positiva. |

---

### 7. Tabela: `ALUNO_DISCIPLINA`
* **Descrição:** Tabela associativa que materializa o relacionamento N:N entre Alunos e Disciplinas (Matrículas acadêmicas).

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario_aluno` | INT | Obrigatório | PK Composta e FK | Referencia `ALUNO(id_usuario)` com ON DELETE CASCADE. |
| `id_disciplina` | INT | Obrigatório | PK Composta e FK | Referencia `DISCIPLINA(id_disciplina)` com ON DELETE CASCADE. |
| `nota_final` | DECIMAL(4,2) | Opcional | Atributo Comum | Valor DEFAULT NULL (representa 'Cursando'). CHECK (0.00 a 10.00). |
| `frequencia` | DECIMAL(5,2) | Opcional | Atributo Comum | Percentual de presença final. Restrição CHECK (0.00 a 100.00). |
| `dt_desistencia` | DATE | Opcional | Atributo Comum | Registra a data de trancamento ou desistência na matéria. |

---

### 8. Tabela: `ALOCACAO_TURMA`
* **Descrição:** Tabela associativa que resolve o relacionamento ternário (Professor leciona uma Disciplina em uma determinada Sala).

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario_professor` | INT | Obrigatório | PK Composta e FK | Referencia `PROFESSOR(id_usuario)` com ON DELETE CASCADE. |
| `id_disciplina` | INT | Obrigatório | PK Composta e FK | Referencia `DISCIPLINA(id_disciplina)` com ON DELETE CASCADE. |
| `id_sala` | INT | Obrigatório | PK Composta e FK | Referencia `SALA(id_sala)` com restrição ON DELETE RESTRICT. |

---

### 9. Tabela: `CONTRATO_ESTAGIO`
* **Descrição:** Registra os termos de compromisso de estágio vinculados individualmente aos alunos (Relacionamento 1:1).

| Atributo | Tipo de Dado (PostgreSQL) | Obrigatoriedade | Papel | Restrições / Observações |
| :--- | :--- | :--- | :--- | :--- |
| `id_contrato` | SERIAL | Obrigatório | Chave Primária (PK) | Auto-incremento sequencial automático. |
| `empresa_conced` | VARCHAR(100) | Obrigatório | Atributo Comum | Nome da empresa ou pessoa jurídica parceira. |
| `data_inicio` | DATE | Obrigatório | Atributo Comum | Data inicial acordada de vigência do estágio. |
| `valor_bolsa` | DECIMAL(10,2) | Opcional | Atributo Comum | Remuneração pecuniária mensal (Bolsa de estágio). |
| `id_usuario_aluno` | INT | Obrigatório | Chave Estrangeira (FK) | Restrição **UNIQUE** (Garante a regra estrita de 1:1). Referencia `ALUNO(id_usuario)`. |
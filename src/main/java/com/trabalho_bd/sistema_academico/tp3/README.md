# TP3 — Modelo Físico em PostgreSQL

## 🏫 Informações Gerais
* **Nome do Sistema:** Sistema de Gestão e Controle Acadêmico (SGCA)
* **Disciplina:** Banco de Dados
* **Equipe:** Rafael Jose, Ruan Almeida, João Italo e Antonio Carlos

---

## 💻 Ambiente de Execução
* **SGBD Obrigatório:** PostgreSQL (v15+ hospedado em nuvem)
* **Plataforma/Ambiente:** Supabase (Backend-as-a-Service)
* **Ferramenta de Execução dos Scripts:** Supabase SQL Editor

---

## 🗂️ Estrutura da Pasta e Ordem de Execução
Para recriar o banco de dados do zero com total consistência e integridade referencial, os scripts contidos nesta pasta devem ser executados **estritamente** na seguinte ordem:

1. **`01_create.sql`**: Remove estruturas antigas (`DROP CASCADE`) e recria todas as 9 tabelas do esquema lógico com suas respectivas restrições (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` e `CHECK`).
2. **`02_insert.sql`**: Alimenta o banco de dados com dados fictícios e coerentes para testes de relacionamentos e validações.
3. **`03_objects.sql`**: Cria os objetos físicos complementares do sistema (Índice, View e Gatilho).
4. **`04_tests.sql`**: Script de testes contendo as 9 consultas complexas e cenários de erro solicitados para validação em console.

---

## ⚙️ Justificativas dos Objetos Físicos Criados (Script 03)

### 1. Justificativa do Índice (`idx_usuario_nome`)
* **Objetivo:** Otimizar a performance em consultas textuais.
* **Justificativa:** A tabela `USUARIO` centraliza todos os indivíduos do sistema. A aplicação Full Stack (PF) realizará buscas frequentes por substrings na barra de pesquisa (ex: pesquisar por alunos ou professores digitando parte do nome). O índice estruturado na coluna `nome` transforma uma busca sequencial lenta (`Sequential Scan`) em uma busca indexada rápida, garantindo alta escalabilidade ao sistema.

### 2. Justificativa da VIEW (`vw_historico_alunos`)
* **Objetivo:** Centralizar a lógica de negócio acadêmica e simplificar o código da aplicação.
* **Justificativa:** Esta visão realiza a junção (`JOIN`) de 5 tabelas para montar o espelho acadêmico do aluno. Ela implementa fisicamente a regra de negócio do projeto: quando a nota final de uma matrícula for nula (indicação de que a matéria ainda está ocorrendo), a função `COALESCE` faz o tratamento e retorna a string `"Cursando"`. Isso evita códigos complexos no Back-end e poupa processamento da aplicação.

### 3. Descrição do Gatilho Implementado (`tg_valida_estagio_aluno`)
* **Objetivo:** Proteger a consistência dos dados e aplicar regras de negócio impeditivas diretamente no banco.
* **Justificativa:** Implementado em linguagem **PL/pgSQL**, este gatilho atua de forma preventiva (`BEFORE INSERT OR UPDATE`) na tabela `CONTRATO_ESTAGIO`. Ele consulta o Índice de Qualificação do Discente (`IQD`) do aluno em questão. Caso o `IQD` seja inferior a **7.0**, o gatilho bloqueia a persistência do dado disparando uma exceção (`RAISE EXCEPTION`), impedindo que alunos com baixo rendimento acadêmico assinem contratos de estágio, blindando o banco contra falhas da camada de aplicação.

---

## 🔄 Instruções para Recriar o Banco do Zero
Se houver necessidade de resetar o ambiente durante a avaliação ou desenvolvimento:
1. Abra o **SQL Editor** no painel do Supabase.
2. Crie uma nova aba de query.
3. Copie e execute o conteúdo de `01_create.sql`.
4. Em seguida, copie e execute o conteúdo de `02_insert.sql`.
5. Por fim, execute o script `03_objects.sql`.
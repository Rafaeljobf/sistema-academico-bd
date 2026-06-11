package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "alocacao_turma")
public class AlocacaoTurma {

    @EmbeddedId
    private AlocacaoTurmaId id = new AlocacaoTurmaId();

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idUsuarioProfessor")
    @JoinColumn(name = "id_usuario_professor")
    private Professor professor;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idDisciplina")
    @JoinColumn(name = "id_disciplina")
    private Disciplina disciplina;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idSala")
    @JoinColumn(name = "id_sala")
    private Sala sala;

    public AlocacaoTurma(AlocacaoTurmaId id, Professor professor, Disciplina disciplina, Sala sala) {
        this.id = id;
        this.professor = professor;
        this.disciplina = disciplina;
        this.sala = sala;
    }

    public AlocacaoTurma() {
    }

    public AlocacaoTurmaId getId() {
        return id;
    }

    public void setId(AlocacaoTurmaId id) {
        this.id = id;
    }

    public Professor getProfessor() {
        return professor;
    }

    public void setProfessor(Professor professor) {
        this.professor = professor;
    }

    public Disciplina getDisciplina() {
        return disciplina;
    }

    public void setDisciplina(Disciplina disciplina) {
        this.disciplina = disciplina;
    }

    public Sala getSala() {
        return sala;
    }

    public void setSala(Sala sala) {
        this.sala = sala;
    }
}

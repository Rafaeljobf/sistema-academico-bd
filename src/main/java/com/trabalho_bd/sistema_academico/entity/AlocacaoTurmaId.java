package com.trabalho_bd.sistema_academico.entity;

import java.io.Serializable;
import java.util.Objects;

public class AlocacaoTurmaId implements Serializable {
    private Long idUsuarioProfessor;
    private Long idDisciplina;
    private Long idSala;

    public AlocacaoTurmaId() {
    }

    public AlocacaoTurmaId(Long idUsuarioProfessor, Long idDisciplina, Long idSala) {
        this.idUsuarioProfessor = idUsuarioProfessor;
        this.idDisciplina = idDisciplina;
        this.idSala = idSala;
    }

    public Long getIdUsuarioProfessor() {
        return idUsuarioProfessor;
    }

    public void setIdUsuarioProfessor(Long idUsuarioProfessor) {
        this.idUsuarioProfessor = idUsuarioProfessor;
    }

    public Long getIdDisciplina() {
        return idDisciplina;
    }

    public void setIdDisciplina(Long idDisciplina) {
        this.idDisciplina = idDisciplina;
    }

    public Long getIdSala() {
        return idSala;
    }

    public void setIdSala(Long idSala) {
        this.idSala = idSala;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;

        AlocacaoTurmaId that = (AlocacaoTurmaId) o;
        return Objects.equals(idUsuarioProfessor, that.idUsuarioProfessor) && Objects.equals(idDisciplina, that.idDisciplina) && Objects.equals(idSala, that.idSala);
    }

    @Override
    public int hashCode() {
        int result = Objects.hashCode(idUsuarioProfessor);
        result = 31 * result + Objects.hashCode(idDisciplina);
        result = 31 * result + Objects.hashCode(idSala);
        return result;
    }
}

package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
class AlunoDisciplinaId implements Serializable {

    @Column(name = "id_usuario_aluno") private Integer idUsuarioAluno;

    @Column(name = "id_disciplina") private Integer idDisciplina;

    public AlunoDisciplinaId() {
    }

    public Integer getIdUsuarioAluno() {
        return idUsuarioAluno;
    }

    public void setIdUsuarioAluno(Integer idUsuarioAluno) {
        this.idUsuarioAluno = idUsuarioAluno;
    }

    public Integer getIdDisciplina() {
        return idDisciplina;
    }

    public void setIdDisciplina(Integer idDisciplina) {
        this.idDisciplina = idDisciplina;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;

        AlunoDisciplinaId that = (AlunoDisciplinaId) o;
        return Objects.equals(idUsuarioAluno, that.idUsuarioAluno) && Objects.equals(idDisciplina, that.idDisciplina);
    }

    @Override
    public int hashCode() {
        int result = Objects.hashCode(idUsuarioAluno);
        result = 31 * result + Objects.hashCode(idDisciplina);
        return result;
    }
}
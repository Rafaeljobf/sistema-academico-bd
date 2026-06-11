package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.math.BigDecimal;

@Entity
@Table(name = "aluno_disciplina")
public class AlunoDisciplina {

    @EmbeddedId
    private AlunoDisciplinaId id = new AlunoDisciplinaId();

    @ManyToOne
    @MapsId("idUsuarioAluno")
    @JoinColumn(name = "id_usuario_aluno")
    private Aluno aluno;

    @ManyToOne
    @MapsId("idDisciplina")
    @JoinColumn(name = "id_disciplina")
    private Disciplina disciplina;

    @Column(name = "nota_final", precision = 4, scale = 2)
    private BigDecimal notaFinal; // Regra de negócio: Inicializa nulo ("Cursando")

    @Column(precision = 5, scale = 2)
    private BigDecimal frequencia;

    @Column(name = "dt_desistencia")
    private LocalDate dtDesistencia;

    public AlunoDisciplina(AlunoDisciplinaId id, Aluno aluno, Disciplina disciplina, BigDecimal notaFinal, BigDecimal frequencia, LocalDate dtDesistencia) {
        this.id = id;
        this.aluno = aluno;
        this.disciplina = disciplina;
        this.notaFinal = notaFinal;
        this.frequencia = frequencia;
        this.dtDesistencia = dtDesistencia;
    }

    public AlunoDisciplina() {
    }

    public AlunoDisciplinaId getId() {
        return id;
    }

    public void setId(AlunoDisciplinaId id) {
        this.id = id;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public Disciplina getDisciplina() {
        return disciplina;
    }

    public void setDisciplina(Disciplina disciplina) {
        this.disciplina = disciplina;
    }

    public BigDecimal getNotaFinal() {
        return notaFinal;
    }

    public void setNotaFinal(BigDecimal notaFinal) {
        this.notaFinal = notaFinal;
    }

    public BigDecimal getFrequencia() {
        return frequencia;
    }

    public void setFrequencia(BigDecimal frequencia) {
        this.frequencia = frequencia;
    }

    public LocalDate getDtDesistencia() {
        return dtDesistencia;
    }

    public void setDtDesistencia(LocalDate dtDesistencia) {
        this.dtDesistencia = dtDesistencia;
    }
}
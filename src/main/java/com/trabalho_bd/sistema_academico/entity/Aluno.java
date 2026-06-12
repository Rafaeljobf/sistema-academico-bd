package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.math.BigDecimal;

@Entity
@Table(name = "aluno")
@PrimaryKeyJoinColumn(name = "id_usuario") // Chave Primária e Estrangeira herdada
public class Aluno extends Usuario {

    @Column(nullable = false, unique = true, length = 20)
    private String matricula;

    @Column(name = "dt_ingresso", nullable = false)
    private LocalDate dtIngresso;

    @Column(name = "iqd", precision = 4, scale = 2)
    private BigDecimal iqd; // Decimal(4,2) opcional

    @ManyToOne
    @JoinColumn(name = "id_curso", nullable = false)
    private Curso curso;

    public Aluno(Integer idUsuario, String nome, String cpf, String email, String telefone, String matricula, LocalDate dtIngresso, BigDecimal iqd, Curso curso) {
        super(idUsuario, nome, cpf, email, telefone);
        this.matricula = matricula;
        this.dtIngresso = dtIngresso;
        this.iqd = iqd;
        this.curso = curso;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public LocalDate getDtIngresso() {
        return dtIngresso;
    }

    public void setDtIngresso(LocalDate dtIngresso) {
        this.dtIngresso = dtIngresso;
    }

    public BigDecimal getIqd() {
        return iqd;
    }

    public void setIqd(BigDecimal iqd) {
        this.iqd = iqd;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }
}
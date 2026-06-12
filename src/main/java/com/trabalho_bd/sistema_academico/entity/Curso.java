package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "curso")
public class Curso {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id_curso")
    private Integer idCurso;

    @Column(name = "nome_curso", nullable = false, length = 100)
    private String nomeCurso;

    @Column(name = "carga_horaria_total", nullable = false)
    private Integer cargaHorariaTotal;

    public Curso(Integer idCurso, String nomeCurso, Integer cargaHorariaTotal) {
        this.idCurso = idCurso;
        this.nomeCurso = nomeCurso;
        this.cargaHorariaTotal = cargaHorariaTotal;
    }

    public Integer getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(Integer idCurso) {
        this.idCurso = idCurso;
    }

    public String getNomeCurso() {
        return nomeCurso;
    }

    public void setNomeCurso(String nomeCurso) {
        this.nomeCurso = nomeCurso;
    }

    public Integer getCargaHorariaTotal() {
        return cargaHorariaTotal;
    }

    public void setCargaHorariaTotal(Integer cargaHorariaTotal) {
        this.cargaHorariaTotal = cargaHorariaTotal;
    }
}
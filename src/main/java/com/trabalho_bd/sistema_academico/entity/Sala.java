package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "sala")
public class Sala {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id_sala")
    private Integer idSala;

    @Column(nullable = false, length = 10)
    private String bloco;

    @Column(name = "cap_maxima", nullable = false)
    private Integer capMaxima;

    public Sala(Integer idSala, String bloco, Integer capMaxima) {
        this.idSala = idSala;
        this.bloco = bloco;
        this.capMaxima = capMaxima;
    }

    public Integer getIdSala() {
        return idSala;
    }

    public void setIdSala(Integer idSala) {
        this.idSala = idSala;
    }

    public String getBloco() {
        return bloco;
    }

    public void setBloco(String bloco) {
        this.bloco = bloco;
    }

    public Integer getCapMaxima() {
        return capMaxima;
    }

    public void setCapMaxima(Integer capMaxima) {
        this.capMaxima = capMaxima;
    }
}
package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;

@Entity
@Table(name = "professor")
@PrimaryKeyJoinColumn(name = "id_usuario")
public class Professor extends Usuario {

    @Column(name = "titulacao_max", nullable = false, length = 30)
    private String titulacaoMax;

    @Column(name = "area_pesquisa", nullable = false, length = 100)
    private String areaPesquisa;

    @Column(name = "link_lattes", length = 150)
    private String linkLattes; // Opcional

    public Professor(Integer idUsuario, String nome, String cpf, String email, String telefone, String titulacaoMax, String areaPesquisa, String linkLattes) {
        super(idUsuario, nome, cpf, email, telefone);
        this.titulacaoMax = titulacaoMax;
        this.areaPesquisa = areaPesquisa;
        this.linkLattes = linkLattes;
    }

    public String getTitulacaoMax() {
        return titulacaoMax;
    }

    public void setTitulacaoMax(String titulacaoMax) {
        this.titulacaoMax = titulacaoMax;
    }

    public String getAreaPesquisa() {
        return areaPesquisa;
    }

    public void setAreaPesquisa(String areaPesquisa) {
        this.areaPesquisa = areaPesquisa;
    }

    public String getLinkLattes() {
        return linkLattes;
    }

    public void setLinkLattes(String linkLattes) {
        this.linkLattes = linkLattes;
    }
}
package com.trabalho_bd.sistema_academico.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "contrato_estagio")
public class ContratoEstagio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_contrato")
    private Integer idContrato;

    @Column(name = "empresa_conced", nullable = false, length = 100)
    private String empresaConced;

    @Column(name = "data_inicio", nullable = false)
    private LocalDate dataInicio;

    @Column(name = "valor_bolsa", precision = 10, scale = 2)
    private BigDecimal valorBolsa; // Decimal(10,2), Opcional

    @OneToOne
    @JoinColumn(name = "id_usuario_aluno", referencedColumnName = "id_usuario", unique = true, nullable = false)
    private Aluno aluno; // Garante a restrição UNIQUE 1:1 do Aluno no Contrato

    public ContratoEstagio(Integer idContrato, String empresaConced, LocalDate dataInicio, BigDecimal valorBolsa, Aluno aluno) {
        this.idContrato = idContrato;
        this.empresaConced = empresaConced;
        this.dataInicio = dataInicio;
        this.valorBolsa = valorBolsa;
        this.aluno = aluno;
    }

    public Integer getIdContrato() {
        return idContrato;
    }

    public void setIdContrato(Integer idContrato) {
        this.idContrato = idContrato;
    }

    public String getEmpresaConced() {
        return empresaConced;
    }

    public void setEmpresaConced(String empresaConced) {
        this.empresaConced = empresaConced;
    }

    public LocalDate getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(LocalDate dataInicio) {
        this.dataInicio = dataInicio;
    }

    public BigDecimal getValorBolsa() {
        return valorBolsa;
    }

    public void setValorBolsa(BigDecimal valorBolsa) {
        this.valorBolsa = valorBolsa;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }
}
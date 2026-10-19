package br.com.itsjoias.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import java.time.OffsetDateTime;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;


@Entity
@Table(name = "clientes")
public class Cliente {

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false)
	private String nome;

	private String email;

	@Column(nullable = false)
	private String telefone;

	private String cpf;
	private String endereco;
	private String observacoes;

	@Column(nullable = false)
	private Boolean ativo;

	@Column(name = "criado_em", insertable = false, updatable = false)
	private OffsetDateTime criadoEm;

	@Column(name = "atualizado_em", insertable = false, updatable = false)
	private OffsetDateTime atualizadoEm;

	// Getters and Setters

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	public String getObservacoes() {
		return observacoes;
	}

	public void setObservacoes(String observacoes) {
		this.observacoes = observacoes;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public OffsetDateTime getCriadoEm() {
		return criadoEm;
	}

	public void setCriadoEm(OffsetDateTime criadoEm) {
		this.criadoEm = criadoEm;
	}

	public OffsetDateTime getAtualizadoEm() {
		return atualizadoEm;
	}

	public void setAtualizadoEm(OffsetDateTime atualizadoEm) {
		this.atualizadoEm = atualizadoEm;
	}

}

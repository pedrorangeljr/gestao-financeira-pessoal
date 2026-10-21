package model;

public class User {

	private long id;
	private String nome;
	private String email;
	private String passwordHash;
	private boolean ativo;

	public User() {
	}

	public User(Long id, String nome, String email, String passwordHash, boolean ativo) {

		this.id = id;
		this.nome = nome;
		this.email = email;
		this.passwordHash = passwordHash;
		this.ativo = ativo;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
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

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public boolean isAtivo() {
		return ativo;
	}

	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}

}

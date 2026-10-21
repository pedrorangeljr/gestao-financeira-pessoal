package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import config.DatabaseConnection;
import model.User;

public class UserDAO {

	public User create(User user) throws SQLException {

		String sql = """
				INSERT INTO usuarios (nome, email, password_hash)
				VALUES(?,?,?)
				RETURNING id, nome, email, passowrd_hash, ativo
				""";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {

			statement.setString(1, user.getNome());
			statement.setString(2, user.getEmail());
			statement.setString(3, user.getPasswordHash());

			try (ResultSet result = statement.executeQuery()) {

				if (!result.next()) {
					throw new SQLException("Não foi possível recuperar o usuário criado.");

				}

				return mapUser(result);
			}
		}
	}

	public Optional<User> findByEmail(String email) throws SQLException {

		String sql = """
				SELECT id, nome, email, password_hash, ativo
				FROM usuarios
				WHERE LOWER(email) = LOWER(?)
				""";

		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {

			statement.setString(1, email);

			try (ResultSet result = statement.executeQuery()) {
				if (result.next()) {
					return Optional.of(mapUser(result));
				}

				return Optional.empty();
			}
		}
	}

	private User mapUser(ResultSet result) throws SQLException {
		return new User(result.getLong("id"), result.getString("nome"), result.getString("email"),
				result.getString("password_hash"), result.getBoolean("ativo"));
	}
}

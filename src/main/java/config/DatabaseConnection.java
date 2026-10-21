package config;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public final class DatabaseConnection {

	private static final String CONFIG_FILE = "/db.properties";

	private static final Properties CONFIGURATION = loadConfiguration();

	private DatabaseConnection() {
		// Impede a instanciação desta classe utilitária.
	}

	private static Properties loadConfiguration() {

		Properties properties = new Properties();

		try (InputStream input = DatabaseConnection.class.getResourceAsStream(CONFIG_FILE)) {

			if (input == null) {
				throw new IllegalStateException("Arquivo db.properties não encontrado no classpath.");
			}

			properties.load(input);

		} catch (IOException e) {

			throw new IllegalStateException("Não foi possível carregar o arquivo db.properties.", e);
		}

		return properties;
	}

	public static Connection getConnection() throws SQLException {

		String url = requiredProperty("db.url");
		String username = requiredProperty("db.username");
		String password = requiredProperty("db.password");

		return DriverManager.getConnection(url, username, password);
	}

	private static String requiredProperty(String key) {
		String value = CONFIGURATION.getProperty(key);

		if (value == null || value.isBlank()) {
			throw new IllegalStateException("A propriedade '" + key + "' não foi configurada no db.properties.");
		}

		return value;
	}
}

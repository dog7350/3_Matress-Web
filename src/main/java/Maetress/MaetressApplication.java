package Maetress;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@SpringBootApplication()
@EnableJpaRepositories("Maetress.repository")
@EntityScan("Maetress.entity")
public class MaetressApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(MaetressApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(MaetressApplication.class);
	}

	@Bean
	public DataSource dataSource(){
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("org.mariadb.jdbc.Driver");
		dataSource.setUrl("jdbc:mariadb://13.125.77.214:3306/maetress?serverTimezone=UTC&characterEncoding=UTF-8&useSSL=false");
		dataSource.setUsername("maetress");
		dataSource.setPassword("maetress");
		return dataSource;
	}
}

package iam.solucoesdigitais.lojavirtual;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EntityScan(basePackages = "iam.solucoesdigitais.lojavirtual.service")
@ComponentScan(basePackages = {"iam.*"})
@EnableJpaRepositories(basePackages = {"iam.solucoesdigitais.lojavirtual.repository"})
@EnableTransactionManagement
public class LojaVitualApplication {

	public static void main(String[] args) {
		SpringApplication.run(LojaVitualApplication.class, args);
	}

}

package daangnmungcat.config;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

@Configuration
@Import({ContextDataSource.class, ContextSqlSession.class, SecurityConfig.class, WebSocketMessageBrokerConfig.class})
@ComponentScan(basePackages = {
		"daangnmungcat.mapper",
		"daangnmungcat.service",
		"daangnmungcat.websocket",
		"daangnmungcat.handler"})
public class ContextRoot {
	
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource ms = new ReloadableResourceBundleMessageSource();
		ms.setDefaultLocale(Locale.KOREA);
		ms.setBasenames("classpath:messages/message");
		ms.setDefaultEncoding("UTF-8");
		ms.setCacheSeconds(30);
		return ms;
	}
	
	@Bean
	public MessageSourceAccessor messageSourceAccessor() {
		return new MessageSourceAccessor(messageSource());
	}
}
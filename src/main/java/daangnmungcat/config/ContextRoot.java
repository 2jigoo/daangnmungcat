package daangnmungcat.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

import daangnmungcat.typehandler.CodeEnumTypeHandler;

@Configuration
@Import({ContextDataSource.class, ContextSqlSession.class, SecurityConfig.class, WebSocketMessageBrokerConfig.class})
@ComponentScan(basePackages = {
		"daangnmungcat.mapper",
		"daangnmungcat.service",
		"daangnmungcat.websocket"})
public class ContextRoot {
	
	
}
package daangnmungcat.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@Import({ContextDataSource.class})
@ComponentScan(basePackages = {"daangnmungcat.mapper", "daangnmungcat.service"})
public class ContextRoot {

}
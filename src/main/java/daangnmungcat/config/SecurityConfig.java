package daangnmungcat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import daangnmungcat.handler.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security 작동");
		http.authorizeRequests()
			.antMatchers("/#").permitAll()
			.antMatchers("/admin").access("hasRole('ROLE_ADMIN')")
			.antMatchers("/member").access("hasRole('ROLE_MEMBER')");
		
		http.cors().configurationSource(corsConfigurationSource());
		
		//admin access denined -> login page로 이동하여 로그인
		//loginPage("뷰이름").loginProcessingUrl("경로");
		http.formLogin().loginPage("/login").loginProcessingUrl("/sample/login");
		
		// 동일 도메인에서 iframe SockJS 지원하게끔
		http.headers()
	        .frameOptions().disable();
		
//		http.csrf().disable();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//{noop} -> 패스워드 인코딩처리 없이 사용
		auth.inMemoryAuthentication().withUser("admin").password("{noop}1234").roles("ADMIN");
		auth.inMemoryAuthentication().withUser("member").password("{noop}member").roles("member");
	}
	
	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	
	// CORS 허용 적용
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();

        configuration.addAllowedOrigin("*");
        configuration.addAllowedHeader("*");
        configuration.addAllowedMethod("*");
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
	
	
}

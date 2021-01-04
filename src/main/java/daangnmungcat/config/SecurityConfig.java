package daangnmungcat.config;

import java.security.AuthProvider;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

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
		
		//admin access denined -> login page로 이동하여 로그인
		//loginPage("뷰이름").loginProcessingUrl("경로");
		http.formLogin().loginPage("/login").loginProcessingUrl("/sample/login");
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
	
	
	
	
	
}

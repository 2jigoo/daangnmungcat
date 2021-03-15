package daangnmungcat.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import daangnmungcat.security.CustomUserDetailService;

@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = {"daangnmungcat.handler"})
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security 작동");
		http.authorizeRequests()
			.antMatchers("/").permitAll()
			.antMatchers("/login").anonymous()
			.antMatchers("/logout").authenticated()
			.antMatchers("/admin/**").hasRole("ADMIN")
			.antMatchers("/chat/**").authenticated()
			.anyRequest().permitAll();
		
		http.cors().configurationSource(corsConfigurationSource());
		
		http.formLogin()
			.loginPage("/login")
			.usernameParameter("id")
			.loginProcessingUrl("/doLogin")
			.successHandler(authenticationSuccessHandler);
		
		http.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true);
		
		// 동일 도메인에서 iframe SockJS 지원하게끔
		http.headers()
	        .frameOptions().disable();
		
		// 403 접근 권한 없을 때 페이지
		http.exceptionHandling()
			.accessDeniedPage("/WEB-INF/views/error/403.jsp");
		
//		http.csrf().ignoringAntMatchers("/logout");
		// csrf 활성화: LoginFilter에서 POST만 처리
		// csrf 비활성화: LoginFilter에서 다 처리
	}

	
	@Bean
	protected UserDetailsService userDetailsService() {
		return new CustomUserDetailService();
	}
	
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
//	@Autowired
//	private AuthenticationFailureHandler authenticationFailureHandler;
	
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		// web.debug(true); // debug 할 때
		web.ignoring().antMatchers("/resources/**");
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
	
    @Bean
    public PasswordEncoder passwordEncoder() {
    	return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
	
}

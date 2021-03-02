package daangnmungcat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import daangnmungcat.handler.LoginSuccessHandler;
import daangnmungcat.security.CustomUserDetailService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security 작동");
		http.authorizeRequests()
			.antMatchers("/").permitAll()
			.antMatchers("/chat/**").hasRole("USER")
			.antMatchers("/admin/**").hasRole("ADMIN");
		//.antMatchers("/**").permitAll();
		
		http.cors().configurationSource(corsConfigurationSource());
		
		http.formLogin()
			.loginPage("/login")
			.usernameParameter("id")
			.loginProcessingUrl("/doLogin");
		
		http.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true);
		
		// 동일 도메인에서 iframe SockJS 지원하게끔
		http.headers()
	        .frameOptions().disable();
		
//		http.csrf().ignoringAntMatchers("/logout");
		// csrf 활성화: LoginFilter에서 POST만 처리
		// csrf 비활성화: LoginFilter에서 다 처리
	}

	
	@Bean
	protected UserDetailsService userDetailsService() {
		return new CustomUserDetailService();
	}
	
	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
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

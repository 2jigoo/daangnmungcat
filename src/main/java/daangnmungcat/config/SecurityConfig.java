package daangnmungcat.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
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
			.antMatchers("/login", "/sign-up").anonymous()
			.antMatchers("/logout").authenticated()
			.antMatchers("/admin/**").hasRole("ADMIN")
			.antMatchers("/mypage/**").authenticated()
			.antMatchers("/joongoSale/addList/**", "/joongoSale/modiList/**", "/joongoSale/modify/**", "/joongoSale/delete", "/joongoSale/insert", "/joongoSale/modify", "/joongo/sale/**", "/joongoSale/pic/delete").authenticated()
			.antMatchers("/joongo/comment/**", "/heart", "/heartNo").authenticated()
			.antMatchers("/joongo/review/write", "/joongo/review/update", "/joongo/review/delete").authenticated()
			.antMatchers("/chat/**", "/api/chat/message", "/go-to-chat").authenticated()
			.antMatchers("/mall/product/write").hasRole("ADMIN")
			.antMatchers("/mall/pre-order/**").authenticated()
			.antMatchers("/address-list/**", "/address/**").authenticated()
			.antMatchers("/dongneUpdate").authenticated()
			.antMatchers("/profile/get", "/profile/post", "/profile-text/post", "/member/**", "/phone/post", "/pwd/post", "withdrawal", "order-cancel", "order-confirm").authenticated()
			.antMatchers("/kakao-pay", "/kakaoPaySuccess", "/kakaoPayCancel", "/kakao-cancel", "kakaoPayCancelSuccess", "accountPay", "/mall/order/**").authenticated()
			.antMatchers(HttpMethod.POST, "/profile/**").authenticated()
			.anyRequest().permitAll();
		
		http.cors().configurationSource(corsConfigurationSource());
		
		http.formLogin()
			.loginPage("/login")
			.usernameParameter("id")
			.loginProcessingUrl("/doLogin")
			.successHandler(authenticationSuccessHandler)
			.failureHandler(authenticationFailureHandler);
		
		http.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true);
		
		// 동일 도메인에서 iframe SockJS 지원하게끔
		http.headers()
	        .frameOptions().disable();
		
		/*http.exceptionHandling()
			.authenticationEntryPoint(authenticationEntryPoint) // 인증 실패시
			.accessDeniedPage(""); // 인가 실패시 */
		
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
	
	@Autowired
	private AuthenticationFailureHandler authenticationFailureHandler;
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		// web.debug(true); // debug 할 때
		web.ignoring().antMatchers("/resources/**");
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService()).passwordEncoder(passwordEncoder());
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

package daangnmungcat.config;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpMethod;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

@Configuration
@EnableWebMvc
@Import({JacksonConfig.class})
@ComponentScan(basePackages = {"daangnmungcat.controller"})
public class WebMvcContextConfig implements WebMvcConfigurer {
	
	private final int MAX_SIZE = 10 * 1024 * 1024;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/assets/**").addResourceLocations("classpath:/META-INF/resources/webjars/").setCachePeriod(31556926);
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(31556926);
	}

	// 매핑 정보가 없는 url 요청은 default servlet handler를 사용하게 함
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/views/", ".jsp");
	}
	
	
	// 컨트롤러 없는 매핑
	@Override
	public void addViewControllers(final ViewControllerRegistry registry) {
		System.out.println("addViewControllers 호출");
		registry.addViewController("/").setViewName("main");
		registry.addViewController("/test_page").setViewName("chat/test_page");
		
		registry.addViewController("sign/id_check").setViewName("sign/id_check");	
		registry.addViewController("sign/contract").setViewName("sign/contract");
		registry.addViewController("sign/welcome").setViewName("sign/welcome");
		
		registry.addViewController("mypage/mypage_main").setViewName("mypage/mypage_main");
		registry.addViewController("mypage/pwd_confirm").setViewName("mypage/pwd_confirm");
		registry.addViewController("/mypage/mypage_withdraw").setViewName("/mypage/mypage_withdraw");
		registry.addViewController("mypage/mypage_info").setViewName("mypage/mypage_info");
		registry.addViewController("mypage/mypage_pwd").setViewName("mypage/mypage_pwd");
		registry.addViewController("mypage/shipping_main").setViewName("mypage/shipping_main");
		registry.addViewController("mypage/shipping_add").setViewName("mypage/shipping_add");
		registry.addViewController("mypage/shipping_update").setViewName("mypage/shipping_update");
		registry.addViewController("mypage/mypage_order_list").setViewName("mypage/mypage_order_list");
		registry.addViewController("mypage/mypage_order_detail").setViewName("mypage/mypage_order_detail");
		registry.addViewController("mypage/mypage_order_cancel_list").setViewName("mypage/mypage_order_cancel_list");
		registry.addViewController("/mall/order/order_end").setViewName("/mall/order/order_end");
		
		registry.addViewController("admin").setViewName("admin/index");
		registry.addViewController("admin/main").setViewName("admin/main");
		
		registry.addViewController("mall/order/mall_pre_order").setViewName("mall/order/mall_pre_order");
		registry.addViewController("mall/order/mall_my_address").setViewName("mall/order/mall_my_address");
		registry.addViewController("mall/order/mall_shipping_add").setViewName("mall/order/mall_shipping_add");
		registry.addViewController("mall/order/mall_shipping_update").setViewName("mall/order/mall_shipping_update");
		
		registry.addViewController("admin/order/part_cancel").setViewName("admin/order/part_cancel");
	}
	
	//파일업로드
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setDefaultEncoding("UTF-8");
	    return resolver;
	}
	
	
	@Override
	public void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		ObjectMapper objectMapper = Jackson2ObjectMapperBuilder.json()
				.featuresToEnable(SerializationFeature.INDENT_OUTPUT)
				.serializerByType(LocalDateTime.class, new LocalDateTimeSerializer(formatter))
				.simpleDateFormat("yyyy-MM-dd HH:mm:ss").build();
		converters.add(0, new MappingJackson2HttpMessageConverter(objectMapper));
	}


	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
				.allowedOrigins("http://localhost:8080")
				.allowedMethods(
				    	HttpMethod.GET.name(),
				    	HttpMethod.HEAD.name(),
				    	HttpMethod.POST.name(),
				    	HttpMethod.PUT.name(),
				    	HttpMethod.DELETE.name());
	}
	
	@Override
	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
		resolvers.add(new AuthInfoMethodArgumentResolver());
		WebMvcConfigurer.super.addArgumentResolvers(resolvers);
	}
	
	
	/*@Bean
	public LocaleChangeInterceptor localeChangeInterceptor(){
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		localeChangeInterceptor.setParamName("lang");
		return localeChangeInterceptor;
	}
	
	@Bean
	public LocaleResolver localeResolver(){
		SessionLocaleResolver localeResolver = new SessionLocaleResolver();
		localeResolver.setDefaultLocale(Locale.KOREAN);
		return localeResolver;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// TODO Auto-generated method stub
		registry.addInterceptor(localeChangeInterceptor());
	}*/

}
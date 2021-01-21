package daangnmungcat.config;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
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

	/*@Bean
	public InternalResourceViewResolver getInternalResourceViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		return resolver;
	}*/
	
	
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
		registry.addViewController("/test").setViewName("joongoSale/addList");
		
		registry.addViewController("/idCheck").setViewName("sign/idCheck");	
		registry.addViewController("/contract").setViewName("sign/contract");
		registry.addViewController("/welcome").setViewName("sign/welcome");
		
		registry.addViewController("/mypage").setViewName("mypage/mypage_main");
		registry.addViewController("/mypage_pwd").setViewName("mypage/mypage_pwd");
		registry.addViewController("/member_info").setViewName("mypage/member_info");
		registry.addViewController("/member_pwd").setViewName("mypage/member_pwd");
		registry.addViewController("/shipping_address").setViewName("mypage/shipping_address");
		
	}
	
	/*
	@Bean
	public MessageSource messageSource() {
		ResourceBundleMessageSource ms = new ResourceBundleMessageSource();
		ms.setBasename("message.label");
		ms.setDefaultEncoding("UTF-8");
		return ms;
	}
	*/
	
	//파일업로드
	@Bean
	public MultipartResolver multipartResolver() {
	    StandardServletMultipartResolver resolver = new StandardServletMultipartResolver();
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
	

}
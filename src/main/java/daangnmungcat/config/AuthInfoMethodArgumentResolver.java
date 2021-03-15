package daangnmungcat.config;

import org.springframework.core.MethodParameter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import daangnmungcat.dto.AuthInfo;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class AuthInfoMethodArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return AuthInfo.class.equals(parameter.getParameterType());
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth == null) {
			return null;
		}
		
		Object principal = auth.getPrincipal();
		Class<?> parameterType = parameter.getParameterType();
		if(principal instanceof AuthInfo) {
			AuthInfo authInfo = (AuthInfo) principal;
			if(AuthInfo.class.equals(parameterType)) {
				return authInfo;
			}
		}
		
		return null;
	}

}

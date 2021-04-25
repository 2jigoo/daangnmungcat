### 파트별 상세 설명
- [README.md](https://github.com/2jigoo/daangnmungcat#readme)
- [회원 및 프로필 / 마이페이지](https://github.com/2jigoo/daangnmungcat/blob/master/documents/member_view.md)
- [중고거래](https://github.com/2jigoo/daangnmungcat/blob/master/documents/joongo_view.md)
- [1:1 채팅 및 리뷰](https://github.com/2jigoo/daangnmungcat/blob/master/documents/chat_review_view.md)
- [쇼핑몰 상품 및 장바구니](https://github.com/2jigoo/daangnmungcat/blob/master/documents/mall_pdt_cart_view.md)
- [쇼핑몰 주문](https://github.com/2jigoo/daangnmungcat/blob/master/documents/order_view.md)
- [마일리지 및 공지사항](https://github.com/2jigoo/daangnmungcat/blob/master/documents/mileage_notice_view.md)

----
<br>

# 회원가입

## 약관 동의

<img src="https://user-images.githubusercontent.com/75772990/115138171-8c3ed080-a065-11eb-99c5-a859bd158977.png" width="600px">

<br>

## 회원가입 폼

<img src="https://user-images.githubusercontent.com/75772990/115138175-8ea12a80-a065-11eb-9040-734158a18a3a.png" width="600px">

<br>

## 아이디 중복 검사 및 정규표현식 검사

<img src="https://user-images.githubusercontent.com/75772990/115138154-716c5c00-a065-11eb-997d-7ff01113a734.png">

<br>


## 휴대폰 본인인증

<img src="https://user-images.githubusercontent.com/75772990/115138451-3cf99f80-a067-11eb-918a-fa52ff62c5f4.png" width="350px">

<br>
<br>

**본인인증 인증번호 SMS 전송**

<br>

<img src="https://user-images.githubusercontent.com/75772990/115138729-d2e1fa00-a068-11eb-9c52-87c378ba30cb.png">

<br>
<br>

## 회원가입 완료

<img src="https://user-images.githubusercontent.com/75772990/115138265-ff484700-a065-11eb-80f8-41dd2069fc9e.png" width="600px">

<br><br>

## 비동기 로그인/로그아웃

### 로그인 실패시

```Java
@Component
@Log4j2
public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Autowired
	private ObjectMapper objectMapper;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		response.setStatus(HttpStatus.UNAUTHORIZED.value());
		response.setCharacterEncoding("UTF-8");
		
        Map<String, Object> data = new HashMap<>();
        data.put("exception", exception.getMessage());
        
        response.getWriter().println(objectMapper.writeValueAsString(data));
	}
}
```

<img src="https://user-images.githubusercontent.com/75772990/115138421-0459c600-a067-11eb-9c34-45ae75874ada.png">

<br>
<br>

Bean으로 등록한 MessageSource로부터 에러 메시지를 읽어옴

<br>

### 로그인 성공시
```Java
@Component
@Log4j2
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	private CartService cartService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		String url = "/";
		
		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		//사용자가 admin권한이면 바로 admin 페이지로
		if(roleNames.contains("ROLE_ADMIN")) {
			url = "/admin";
		}
		
		if(roleNames.contains("ROLE_USER")) {
			// 비회원의 장바구니가 존재하면, 현재 로그인 회원의 장바구니로 이전시켜줌
			Optional<Cookie> cookie = Arrays.stream(request.getCookies()).filter(c -> c.getName().equals("basket_id")).findAny();
			cookie.ifPresent(c -> {
				c.setMaxAge(0);
				cartService.moveToMember(c.getValue(), auth.getName());
				response.addCookie(c);
			});
		}
		
		response.setStatus(HttpStatus.OK.value());
		response.getWriter().println(url);
	}
}
```

- 관리자 계정으로 로그인 시 관리자 모드 페이지로 이동  
- 사용자 계정으로 로그인 시 /로 이동  
쿠키로 발급한 비회원 장바구니 아이디가 존재하면 해당 로그인 계정으로 이전시킨다

<br>

# 프로필

## 프로필 메인

<img src="https://user-images.githubusercontent.com/75772990/115137990-53522c00-a064-11eb-98f3-2fc70ea88e73.png" width="600px">

<br>
<br>

## 프로필 수정 모달

<img src="https://user-images.githubusercontent.com/75772990/114681697-5c33bc80-9d49-11eb-92ba-6bde084f3f14.png" width="300px">

<BR>
<br>

본인 프로필 화면에서 수정 모달을 열 수 있음

<br>

## 프로필 판매 상품 - 거래 완료

<img src="https://user-images.githubusercontent.com/75772990/115138029-9e6c3f00-a064-11eb-8526-a6f5260291d7.png" width="400px">

<br>
<br>

본인 프로필의 거래완료 판매상품 화면에 후기를 남기거나 작성된 후기를 확인할 수 있는 링크가 있음


<br>

# 마이페이지

<img src="https://user-images.githubusercontent.com/75772990/115138082-e4290780-a064-11eb-8f7e-be03f825f032.png" width="600px">
<img src="https://user-images.githubusercontent.com/75772990/114681696-5b9b2600-9d49-11eb-8a7a-ce2227491b2b.png" width="600px">

<br>
<br>


# 회원 관리

![image](https://user-images.githubusercontent.com/75772990/114857055-cd936e00-9e22-11eb-85a3-68e188888561.png)

날짜 / 상태 / 등급 / 동네 / 검색어로 필터링
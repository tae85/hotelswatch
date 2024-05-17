package com.hotels.springboot.social;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NaverService {

	@Value("${oauth.naver.baseUri}")
	private String baseUri;
	@Value("${oauth.naver.redirectUri}")
	private String redirectUri;
	@Value("${oauth.naver.client.id}")
	private String clientId;
	@Value("${oauth.naver.client.secret}")
	private String clientSecret;
	@Value("${oauth.naver.tokenUri}")
	private String tokenUri;

	private final RestTemplate restTemplate = new RestTemplate();

	public String getNaverAuthorizeUrl(String type, HttpSession session)
			throws URISyntaxException, MalformedURLException, UnsupportedEncodingException {

		String state = generateRandomString();
		// 세션에 저장
		session.setAttribute("state", state);

		UriComponents uriComponents = UriComponentsBuilder.fromUriString(baseUri + "/" + type)
				.queryParam("response_type", "code").queryParam("client_id", clientId)
				.queryParam("redirect_uri", URLEncoder.encode(redirectUri, "UTF-8"))
				.queryParam("state", URLEncoder.encode(state, "UTF-8")).build();

		return uriComponents.toString();
	}

	// 토큰 가져오는 메서드
	public String getAccessToken(String code) {
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(tokenUri)
				.queryParam("grant_type", "authorization_code").queryParam("client_id", clientId)
				.queryParam("client_secret", clientSecret).queryParam("redirect_uri", redirectUri)
				.queryParam("code", code);

		ResponseEntity<NaverTokenResponse> response = restTemplate.postForEntity(builder.toUriString(), null,
				NaverTokenResponse.class);
		return response.getBody().getAccessToken();
	}

	// 유저 프로필 가져오는 메서드
	public NaverUserResponse.NaverUserDetail getProfile(String accessToken) {
		String requestUrl = "https://openapi.naver.com/v1/nid/me";
		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth(accessToken);
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);

		ResponseEntity<NaverUserResponse> response = restTemplate.exchange(requestUrl, HttpMethod.GET, request,
				NaverUserResponse.class);
		return response.getBody().getNaverUserDetail();
	}

	private String generateRandomString() {

		return UUID.randomUUID().toString();
	}

}

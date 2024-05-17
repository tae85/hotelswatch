<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${member ne null}">
			<div class="profile_wrap">
				<button type="button" class="user_btn">
					<c:choose>
						<c:when test="${member.profile ne null }">
							<img src="uploads/${member.profile}" alt="프로필이미지"
								class="profile_img" />
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${member.email eq null }">
									<strong class="user_i">${fn:toUpperCase(fn:substring(member.naver, 0, 1))}</strong>
								</c:when>
								<c:when test="${member.naver eq null }">
									<strong class="user_i">${fn:toUpperCase(fn:substring(member.email, 0, 1))}</strong>
								</c:when>
								<c:otherwise>
									<strong class="user_i">${fn:toUpperCase(fn:substring(member.email, 0, 1))}</strong>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</button>
				<ul class="my_account_box">
					<li><a href="/mypage.do">내 계정</a></li>
					<c:if test="${member.admin eq 'y'}">
						<li><a href="/admin.do">관리자페이지</a></li>
					</c:if>
					<li><button type="button" class="logout_btn"
							onclick="location.href='/logout.do'">로그아웃</button></li>
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<button id="show">
				<p class="img"></p>
				<p class="txt">로그인</p>
			</button>
		</c:otherwise>
	</c:choose>
	<div class="background">
		<div class="window">
			<div class="popup">
				<div class="head">
					<a href="#"><img src="./images/logo.svg" /></a>
					<button id="close"></button>
				</div>
				<div class="image">
					<img src="./images/Loginimage.svg" />
				</div>
				<div class="email">
					<h3>로그인 또는 신규 계정 생성</h3>
					<p>호텔스와치에 로그인하여 회원 전용 특가와 실시간 가격을 확인하고, 여행 계획을 관리하실 수 있습니다.</p>
					<button id="emailproc">이메일 계정으로 진행</button>
				</div>
				<div class="or">
					<div class="line"></div>
					<p>또는</p>
					<div class="line"></div>
				</div>
				<div class="sns">
					<button class="naver" onclick="NaverPopup()">
						<img src="./images/naveri.png" />
						<p>네이버</p>
					</button>
					<button class="google">
						<img src="./images/googlei.svg" />
						<p>구글</p>
					</button>
					<button class="apple">
						<img src="./images/applei.svg" />
						<p>Apple</p>
					</button>
				</div>
				<div class="foot">
					<p>
						가입과 동시에 <a href="#">이용 약관</a> 및 <a href="#">개인 정보 보호 정책</a>에 동의하시게
						됩니다.
					</p>
				</div>
			</div>
			<div class="popup2">
				<div class="head">
					<a href="#">
						<div id="back">
							<img src="./images/back.svg" />
							<p>뒤로</p>
						</div>
					</a>
					<button id="close2"></button>
				</div>
				<div class="email">
					<h3>이메일 주소 입력</h3>
					<div class="buttonwrap">
						<input id=mail class="emailinput" type="text" placeholder="이메일 주소" />
						<button id="continue">계속</button>
					</div>
				</div>
			</div>
			<div class="popup3">
				<div class="head">
					<a href="#">
						<div id="back2">
							<img src="./images/back.svg" />
							<p>뒤로</p>
						</div>
					</a>
					<button id="close3"></button>
				</div>
				<div class="image">
					<img src="./images/verify.svg" />
				</div>
				<div class="email">
					<h3>이메일 주소를 확인해주세요</h3>
					<p>
						다음 이메일 주소(<span id=emailValue></span>)로 6자리 인증 번호를 전송했습니다. 10분 안에
						인증 번호를 입력하세요.
					</p>
					<form class="inputwrap">
						<input type="text" maxlength="1" class="numberInput" /> <input
							type="text" maxlength="1" class="numberInput" /> <input
							type="text" maxlength="1" class="numberInput" /> <input
							type="text" maxlength="1" class="numberInput" /> <input
							type="text" maxlength="1" class="numberInput" /> <input
							type="text" maxlength="1" class="numberInput" />
					</form>
				</div>
				<div id="error_message" style="color: red; display: none;"></div>
				<p>이메일을 받지 못하셨다면 이메일 주소가 맞는 지를 확인하시거나 스팸 폴더를 확인하세요.</p>
			</div>
		</div>
	</div>
</body>
</html>
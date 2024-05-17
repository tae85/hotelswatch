<%@page import="com.hotels.springboot.jdbc.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<meta name="viewport" content="width=1280" />
<meta content="최저가 보장! 모아보면 보인다, HotelSwatch" name="description" />
<meta property="og:type" content="website" />
<meta property="og:title" content="HotelSwatch" />
<!-- <meta property="og:url" content="http://yygraphikos.dothome.co.kr/test">
  <meta property="og:image" content="http://ossamuiux.com/subway/images/subway_og.png"> -->
<meta property="og:description" content="최저가 보장! 모아보면 보인다, HotelSwatch" />
<title>HotelSwatch</title>
<!-- <link rel="icon" href="/images/subway_favicon.ico?v=1" />
    <link rel="apple-touch-icon" href="images/touch_icon.png" /> -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/jquery-ui.min.css" />
<link rel="stylesheet" href="css/swiper.min.css" />
<link rel="stylesheet" href="css/common.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="css/main.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="css/sub.css?v=<?php echo time(); ?>" />
<!-- 자바스크립트는 css 아래에 연결해야 함 -->
<!-- 1. 웹폰트css, 2. common.css, 3. main.css, 4. sub.css, 5. jquery, 6.외부 라이브러리, 7. ui-common.js 순으로 연결  -->
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/ui-common.js?v=<?php echo time(); ?>"></script>
<script src="js/sub.js?v=<?php echo time(); ?>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#upload_btn").on("click", function() {
			$("#uploadFile").click();
		});
		$("#uploadFile").change(function(e) {
			var file = e.target.files[0];
			var reader = new FileReader();

			reader.onload = function(e) {
				$("#imagePreview").attr("src", e.target.result);
			};
			reader.readAsDataURL(file);
		});

		$("#save_btn").on("click", function() {
			var formData = new FormData();
			formData.append('uploadFile', $("#uploadFile")[0].files[0]);
			$.ajax({
				url : '/uploadProfile',
				type : 'POST',
				data : formData,
				contentType : false,
				processData : false,
				success : function(response) {
					window.location.reload();
				},
				error : function(xhr) {
					alert('업로드 실패: ' + xhr.responseText);
				}
			});
		});
	});
</script>

</head>
<body>
	<div class="wrap">
		<div id="header">
			<div class="inner">
				<div class="logo">
					<a href="/">
						<p></p>
					</a>
				</div>
				<%@ include file="/WEB-INF/views/member/loginAuth.jsp"%>
			</div>
		</div>
		<main id="container" class="mypage sub_container">
			<div class="inner">
				<div class="my_info_wrap">
					<button type="button" class="user_profile" title="사진 변경">
						<c:choose>
							<c:when test="${member.profile ne null}">
								<img src="uploads/${member.profile}" alt="유저프로필" />
							</c:when>
							<c:when test="${member.profile eq null}">
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
							</c:when>
						</c:choose>
					</button>
					<div class="txt_wrap">
						<strong>안녕하세요, 반갑습니다.</strong> <span>계정 이메일</span>
						<p>
							<c:choose>
								<c:when test="${member.email ne null}">
									${member.email }
								</c:when>
								<c:when test="${member.naver ne null}">
									${member.naver }
								</c:when>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="modal_box modal_1">
					<strong class="modal_tit">프로필 사진을 변경하세요</strong>
					<div class="upload_wrap">
						<input type="file" id="uploadFile" name="uploadFile"
							style="display: none;" accept="image/*">
						<button type="button" class="upload_btn" id="upload_btn">컴퓨터에서
							업로드</button>
						<p>최대 6MB</p>
						<p>JPG, PNG, GIF 파일만 가능</p>
					</div>
					<button type="button" class="close_btn">
						<span class="blind">닫기</span>
					</button>
				</div>
				<div class="modal_box modal_2">
					<button type="button" class="close_btn">
						<span class="blind">닫기</span>
					</button>
					<img id="imagePreview" src="#" alt="프로필 사진 체크" />
					<div class="btn_wrap">
						<button type="button" class="back_btn">돌아가기</button>
						<button type="button" class="save_btn" id="save_btn">프로필
							사진 저장</button>
					</div>
				</div>
				<div class="modal_bg"></div>
				<ul class="tab_menu">
					<li class="personal_info active"><a href="#">개인 정보</a></li>
					<li class="trip_info"><a href="#">여행 정보</a></li>
				</ul>
				<div class="contents active">
					<ul class="personal_tab_menu sub_tab_menu active">
						<li class="my_account active"><a href="#">계정 관리</a></li>
						<li class="payment"><a href="#">결제 수단</a></li>
					</ul>
					<div class="personnal_contents">
						<div class="my_account_wrap tab_wrap active">
							<strong class="tit">내 정보</strong>
							<button class="edit_btn" type="button" title="수정하기">
								<span class="blind">수정하기</span>
							</button>
							<form id="profileForm" method="POST" action="/updateProfile" >
								<div class="input_wrap">
									<span>이름</span> <input type="text" name="name"
										placeholder="이름을 입력해주세요." value="${member.name }" />
								</div>
								<div class="input_wrap">
									<span>닉네임</span> <input type="text" name="nickname"
										placeholder="닉네임을 입력해주세요."  value="${member.nickname }"/>
								</div>
								<div class="input_wrap">
									<span>이메일</span>
									<c:choose>
										<c:when test="${member.email ne null}">
											<input type="text" name="email" value="${member.email }" />
										</c:when>
										<c:when test="${member.naver ne null}">
											<input type="text" name="naver" value="${member.naver }" />
										</c:when>
									</c:choose>
								</div>
								<div class="input_wrap">
									<span>이메일 수신 사이트</span>
									<div class="country_select">
										<button class="select_btn" type="button">대한민국</button>
										<ul class="select_list">
											<li class="select_item">Australia</li>
											<li class="select_item">Canada (EN)</li>
											<li class="select_item">Canada (FR)</li>
											<li class="select_item">Danmark</li>
											<li class="select_item">Deutschland (DE)</li>
											<li class="select_item">Germany (EN)</li>
											<li class="select_item">Espanya (ES)</li>
											<li class="select_item">France</li>
											<li class="select_item">Hong kong (EN)</li>
											<li class="select_item">italia</li>
											<li class="select_item">New Zealand</li>
											<li class="select_item">Singapore (EN)</li>
											<li class="select_item">대한민국</li>
											<li class="select_item">United Arab Emirates</li>
											<li class="select_item">United Kingdom</li>
											<li class="select_item">United States</li>
											<li class="select_item">Saudi Arabia (EN)</li>
											<li class="select_item">Thailand (EN)</li>
										</ul>
									</div>
								</div>
								<button type="submit" class="save_btn">저장하기</button>
								<div class="connection_wrap">
									<div class="btn_wrap">
										<button type="button" class="google_con con_btn active"></button>
										<button type="button" class="naver_con con_btn"></button>
									</div>
									<p>고객님의 계정을 호텔스와치에 연결하세요</p>
								</div>
								<button class="acc_del_btn" type="button">계정 삭제</button>
							</form>
						</div>
					</div>
				</div>
				<div class="contents">
					<ul class="trip_tab_menu sub_tab_menu">
						<li class="active"><a href="#">최근 검색</a></li>
						<li><a href="#">예약</a></li>
						<li><a href="#">완료</a></li>
					</ul>
					<div class="trip_contents">
						<div class="dashboard_wrap tab_wrap active">
							<strong class="tit">최근 검색 기록</strong>
							<ul class="search_record">
								<li><a href="#"> <strong class="hotel_name">호텔명
											- 서울, 대한민국</strong> <span class="date">5/7 화 - 5/8 수</span> <span
										class="condition">객실 1개, 투숙객 2명</span>
								</a></li>
								<li><a href="#"> <strong class="hotel_name">더
											가든 호텔 - 서울, 대한민국</strong> <span class="date">5/7 화 - 5/8 수</span> <span
										class="condition">객실 1개, 투숙객 2명</span>
								</a></li>
								<li><a href="#"> <strong class="hotel_name">신라스테이
											광화문(명동) 호텔명이 기이이이일면 - 서울, 대한민국</strong> <span class="date">5/7
											화 - 5/8 수</span> <span class="condition">객실 1개, 투숙객 2명</span>
								</a></li>
							</ul>
							<a href="#" class="all_search_record">모든 검색 기록 보기</a>
						</div>
						<div class="reserve_wrap tab_wrap">예약</div>
						<div class="complete_wrap tab_wrap">완료</div>
					</div>
				</div>
			</div>
		</main>
		<footer id="footer">
			<div class="footin">
				<div class="inner">
					<div class="in1">
						<h3>회사 정보</h3>
						<ul>
							<li><a href="#">호텔스와치 소개</a></li>
							<li><a href="#">사이트 작동 방식</a></li>
							<li><a href="#">모바일</a></li>
						</ul>
					</div>
					<div class="in2">
						<h3>연락처</h3>
						<ul>
							<li><a href="#">도움말/FAQ</a></li>
							<li><a href="#">숙박시설 관리</a></li>
							<li><a href="#">제휴 프로그램</a></li>
							<li><a href="#">브랜드 콜라보/제휴</a></li>
						</ul>
					</div>
					<div class="in3">
						<h3>더 보기</h3>
						<ul>
							<li><a href="#">위치별 호텔 검색</a></li>
							<li><a href="#">최저가 보장</a></li>
						</ul>
					</div>
				</div>
				<div class="law">
					<ul>
						<li><a href="#">개인 정보 보호 정책</a></li>
						<li><a href="#">쿠키 정책</a></li>
						<li><a href="#">이용 약관</a></li>
						<li>©2024 HotelsCombined</li>
					</ul>
					<div class="exp">
						<p>호텔스와치에서 전 세계 주요 여행지의 호텔 상품을 최저가로 만나보세요. 수 백개의 호텔 사이트를 검색하여,
							고객님께서 딱 맞는 호텔 상품을 바로 찾아 예약하실 수 있도록 도와드립니다. 호텔스와치에서는 국내외 유명한 호텔
							사이트를 한 번에 검색하여 한눈에 비교할 수 있도록 도와 드리고 있어 특가 상품을 쉽게 찾으실 수 있습니다. 지금
							바로 시작해 보세요.</p>
					</div>
					<div class="link">
						<ul>
							<li><a href="#"><img src="./images/post.svg" /></a></li>
							<li><a href="#"><img src="./images/blog.svg" /></a></li>
							<li><a href="#"><img src="./images/brunch.svg" /></a></li>
							<li><a href="#"><img src="./images/facebook.svg" /></a></li>
							<li><a href="#"><img src="./images/youtube.svg" /></a></li>
							<li><a href="#"><img src="./images/instagram.svg" /></a></li>
							<li><a href="#"><img src="./images/googleplay.svg" /></a></li>
							<li><a href="#"><img src="./images/appstore.svg" /></a></li>
						</ul>
					</div>
					<div class="intro">
						<p>호텔스와치는 세계적인 온라인 여행 기업이 될 유니콘 기업입니다.</p>
					</div>
					<div class="group">
						<ul>
							<li><img src="./images/gbooking.png" /></li>
							<li><img src="./images/gkayak.png" /></li>
							<li><img src="./images/gopentable.png" /></li>
							<li><img src="./images/gpriceline.png" /></li>
							<li><img src="./images/grentalcars.png" /></li>
							<li><img src="./images/gagoda.png" /></li>
						</ul>
					</div>
				</div>
			</div>
		</footer>
	</div>
</body>
</html>
<%@page import="com.hotels.springboot.jdbc.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
<link rel="stylesheet" href="css/room.css?v=<?php echo time(); ?>" />
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/ui-common.js?v=<?php echo time(); ?>"></script>
<script src="js/sub.js?v=<?php echo time(); ?>"></script>
<!--포트원 sdk 라이브러리 v1 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

</head>
<body>
<script>
//지도
var showPosition = function(position){
	var latitude = parseFloat(document.getElementById("latTxt").value);
	var longitude = parseFloat(document.getElementById("lngTxt").value);
	
	initMap(latitude, longitude) ;
}
function initMap(latVar, lngVar) {				
	var uluru = {lat: latVar, lng: lngVar};
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 18, 
		center: uluru
	});
	var marker = new google.maps.Marker({
		position: uluru,
		map: map,
		/////////////////////////////////////////////////////////////////////
		icon: './icon/icon_me.png'
		/////////////////////////////////////////////////////////////////////
	});
}
var showError = function(error){
	switch(error.code){
		case error.UNKNOWN_ERROR:
			span.innerHTML = "알수없는오류발생";break;
		case error.PERMISSION_DENIED:
			span.innerHTML = "권한이 없습니다";break;
		case error.POSITION_UNAVAILABLE:
			span.innerHTML = "위치 확인불가";break;
		case error.TIMEOUT:
			span.innerHTML = "시간초과";break;
	}
}
</script>
	<div id="wrap">
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
		<main id="container" class="room_page sub_container">
			<div class="inner">
				<ul class="tab_menu">
					<li class="active info_btn" onclick="goToScroll('info_wrap')"><a
						href="#">개요</a></li>
					<li class="room_btn" onclick="goToScroll('room_choice_wrap')"><a
						href="#">객실선택</a></li>
					<li class="notice_btn" onclick="goToScroll('notice_wrap')"><a
						href="#">공지사항</a></li>
					<li class="review_btn" onclick="goToScroll('review_wrap')"><a
						href="#">후기 5</a></li>
				</ul>
				<div id="info_wrap" class="info_wrap">
					<div class="info_top">
						<div class="left">
							<h2>${ht.hotel }</h2>
							<span class="addr">${ht.country } ${ht.city }
								${ht.province } ${ht.street }</span> <span class="grade">${grade } <em>/
									10</em></span>
						</div>
						<div class="right">
							<div class="price_wrap">
								<span>총 금액</span> <a href="#"><fmt:formatNumber
										value="${ht.price}" pattern="#,###" /> 원</a>
							</div>
							<a href="#" class="site_name">${ht.site}</a>
							<div class="btn_wrap">
								<a href="#" class="map_btn i_btn"> <span class="blind">지도
										바로가기</span>
								</a> <a href="#" class="wish_btn i_btn"> <span class="blind">위시리스트</span>
								</a> <a href="#" class="share_btn i_btn"> <span class="blind">공유하기</span>
								</a> 
								<c:forEach items="${ roomLists }" var="row" varStatus="status">
									<c:if test="${status.index eq 0 }" >
										<a id="room_idx" href="./order.do?hotel_idx=${row.room_idx }" class="site_go_btn">예약하기</a>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="info_bottom">
						<div class="swiper mySwiper">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
			                      <img src="${ht.picture }" />
			                    </div>
			                    <div class="swiper-slide">
			                      <img src="../images/s3.jpg" id="room-img1"/>
			                    </div>
			                    <div class="swiper-slide">
			                      <img src="../images/s4.jpg" id="room-img2" />
			                    </div>
			                    <div class="swiper-slide">
			                      <img src="../images/s5.jpg" id="room-img3" />
			                    </div>
			                  </div>
							<div class="swiper-pagination"></div>
							<!-- Swiper JS -->
							<script
								src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
							<!-- Initialize Swiper -->
							<script>
								var swiper = new Swiper('.mySwiper', {
									slidesPerView : 3,
									spaceBetween : 20,
									freeMode : true,
									pagination : {
										el : '.swiper-pagination',
										clickable : true,
									},
									breakpoints: {
			                    	  1280: {
			                              slidesPerView: 3,
			                              spaceBetween: 20,
			                            },
			                          767: {
			                            slidesPerView: 2,
			                            spaceBetween: 16,
			                          },
			                          360: {
			                              slidesPerView: 1,
			                            },
			                        },
								});
							</script>
						</div>
					</div>
				</div>
				<div class="room_choice_wrap" id="room_choice_wrap">
					<input type="hidden" value="min" />
					<input type="hidden" value="room_cnt" />
					<strong class="room_tit">객실 선택</strong>
					<c:forEach items="${ roomLists }" var="row" varStatus="status">
					<c:set var="p" value="${(row.price)/100*97 * min * room_cnt}"/>
					<div class="room_wrap">
						<c:if test="${status.index eq 0 }">
							<strong class="type_tit">Standard</strong>
						</c:if>
						<c:if test="${status.index eq 1 }">
							<strong class="type_tit">Deluxe</strong>
						</c:if>
						<c:if test="${status.index eq 2 }">
							<strong class="type_tit">Superior</strong>
						</c:if>
						<div class="contents_wrap">
							<div class="contents_left">
								<img class="room_img" src="${row.room_spic }" alt="방 사진" />
							</div>
							<div class="contents_right">
								<table class="room_tb">
									<thead>
										<tr>
											<th>객실 옵션 상세</th>
											<th width="25%">정원</th>
											<th width="40%">오늘의 요금</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="option_wrap">
												<ul>
													<li class="no_refund_txt">환불 불가</li>
													<li class="now_txt">대기없이 바로 확정!</li>
													<li class="payment_txt">온라인 사전 결제</li>
												</ul>
												<button type="button" class="q_btn">
													<span class="blind">질문</span>
												</button>
											</td>
											<td class="people_num"><span class="blind">정원</span></td>
											<td class="pay_wrap">
												<div class="price">
													<strong class="price_txt"><fmt:formatNumber value="${p}" pattern="#,###"/>원</strong> <span
														class="tax_txt">세금포함</span>
												</div>
												<div class="reserve_wrap">
													<a href="./order.do?hotel_idx=${row.room_idx }" class="reserve_btn">예약</a>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					</c:forEach>
					<div class="option_modal">
						<ul>
							<li><strong>취소</strong>
								<p>본 예약은 변경이 불가능한 상품으로, 취소 시 요금이 환불되지 않습니다.</p></li>
							<li><strong>확인</strong>
								<p>호텔 예약이 즉시 확정됩니다.</p></li>
							<li><strong>결제 방식</strong>
								<p>객실 요금 온라인 사전결제</p></li>
						</ul>
						<button type="button" class="close_btn">
							<span class="blind">닫기</span>
						</button>
					</div>
					<div class="option_modal_bg">
						<span class="blind">모달 배경</span>
					</div>
				</div>
				<div id="notice_wrap" class="notice_wrap">
					<strong class="room_tit">주요 공지사항</strong>
					<div class="txt_wrap">
						<div class="txt_left">
							<div class="checkin">
								<strong>체크인</strong> <span>${ht.checkin_time } 이후</span>
							</div>
							<div class="checkout">
								<strong>체크아웃</strong> <span>${ht.checkout_time } 까지</span>
							</div>
						</div>
						<div class="txt_right">
							<strong>취소/선결제</strong> <span>취소/선결제 정책은 객실 유형 및 예약 업체에 따라
								다릅니다.</span>
						</div>
					</div>
				</div>
				<div id="map_wrap" class="map_wrap">
		            <strong class="room_tit">지역 - ${ht.province }</strong>
		            <span>${ht.city } ${ht.province } ${ht.street }</span>
		            <input type="hidden" id="latTxt" name="latTxt" value="${ht.ht_lat }" />
					<input type="hidden" id="lngTxt" name="lngTxt" value="${ht.ht_lng }" />
		            <div class="map">
						<div id="map" style="width: 100%;height:100%;"></div>
					</div>
            	</div>
				<div id="review_wrap" class="review_wrap">
					<strong class="room_tit">후기</strong>
					<div class="grade_wrap">
						<div class="left">
							<strong>8.6 <em>/ 10</em></strong> <span></span>
						</div>
					</div>
					<ul class="review_list_wrap">
						<%@ include file="../../../react_review/index.html" %>
					</ul>
					<!-- <div class="pagination">
						<span>1 - 11페이지</span>
						<button type="button" class="num_btn"></button>
					</div> -->
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
						<li>©2024 HotelSwatch</li>
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
		<script>
        function show() {
          document.querySelector('.background').className = 'background show';
          document.querySelector('.popup3').style.visibility = 'hidden';
          document.querySelector('.popup2').style.visibility = 'hidden';
          document.querySelector('.popup').style.visibility = 'visible';
          $('.background .window .popup3 .email .inputwrap input').val('');
          $('.background .window .popup2 .email .buttonwrap input').val('');
        }
        function close() {
          document.querySelector('.background').className = 'background';
          $('.background .window .popup3 .email .inputwrap input').val('');
        }
        function popup2() {
          document.querySelector('.popup').style.visibility = 'hidden';
          document.querySelector('.popup2').style.visibility = 'visible';
          $('.background .window .popup3 .email .inputwrap input').val('');
        }

        function back() {
          document.querySelector('.popup2').style.visibility = 'hidden';
          document.querySelector('.popup').style.visibility = 'visible';
          $('.background .window .popup3 .email .inputwrap input').val('');
        }
        function close2() {
          document.querySelector('.background').className = 'background';
          $('.background .window .popup3 .email .inputwrap input').val('');
        }
        function continuous() {
          document.querySelector('.popup3').style.visibility = 'visible';
          document.querySelector('.popup2').style.visibility = 'hidden';
        }

        function back2() {
          document.querySelector('.popup3').style.visibility = 'hidden';
          document.querySelector('.popup2').style.visibility = 'visible';
          $('.background .window .popup3 .email .inputwrap input').val('');
        }

        function close3() {
          document.querySelector('.background').className = 'background';
          $('.background .window .popup3 .email .inputwrap input').val('');
        }
        
        document.querySelector('#show').addEventListener('click', show);
        document.querySelector('#close').addEventListener('click', close);
        document.querySelector('#emailproc').addEventListener('click', popup2);

        document.querySelector('#back').addEventListener('click', back);
        document.querySelector('#close2').addEventListener('click', close);
        // document.querySelector('#continue').addEventListener('click', continuous);

        document.querySelector('#back2').addEventListener('click', back2);
        document.querySelector('#close3').addEventListener('click', close3);
      </script>
	</div>
	<script>
		window.onload = function() {
			console.log("온로드");
			//지도	
			if(navigator.geolocation){
				var options = {	
					enableHighAccurcy:true, 
					timeout:5000,
					maximumAge:3000
				};
				navigator.geolocation.getCurrentPosition(showPosition,showError,options);
			}
			else{
				span.innerHTML = "이 브라우저는 Geolocation API를 지원하지 않습니다.";
			}	
		}
	</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA5-DB9e6-Lsqr4KB8zDoW5lxRmSffl4u8"></script>
</body>
</html>
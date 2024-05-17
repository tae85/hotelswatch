<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1280" />
    <meta
      content="최저가 보장! 모아보면 보인다, HotelSwatch"
      name="description"
    />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="HotelSwatch" />
    <meta
      property="og:description"
      content="최저가 보장! 모아보면 보인다, HotelSwatch"
    />
    <title>HotelSwatch</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@200;300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="css/jquery-ui.min.css" />
    <link rel="stylesheet" href="css/swiper.min.css" />
    <link rel="stylesheet" href="css/common.css?v=<?php echo time(); ?>" />
    <link rel="stylesheet" href="css/detail.css?v=<?php echo time(); ?>" />
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/swiper.min.js"></script>
    <script src="js/ui-common.js?v=<?php echo time(); ?>"></script>
    <script src="js/sub.js?v=<?php echo time(); ?>"></script>
  </head>

<body>
<script>
var str = "";
var data = [];
var min = '<c:out value="${min}"/>';
var rcnt = '<c:out value="${room_cnt}"/>';
$(function(){
	$('#roomAPI').click(function(){
		var hotel_idx = $('#roomAPI').val();
		for(var i = 1; i < 4; i++) {
			$.ajax({
				url : getUrl(i),
				type: 'get', 
				async: false,
				data: {
					hotel_idx: hotel_idx,
				},
				dataType: 'json',
				contentType: 'application/json; charset=UTF-8',
				success: sucHotelJson,
				error: errorFunc
			})
		}
		var hotelSort = priceSortFunc(data);
		print(hotelSort);
		var imgSort = reduceFunc(data);
		console.log("imgSort=",imgSort);
		for(var i = 0; i < imgSort.length; i++) {
			var j = "#room-img" + (i+1);
			$(j).attr('src', imgSort[i].room_spic);
		}
		data =[];
	});
});

function getUrl(i) {
	var url;
	switch(i) {
	case 1 : 
		url = "./viewRoom.do";
		break;
	case 2 : 
		url = "http://192.168.0.42:8586/restHotelView.do";
		break;
	case 3 : 
		url = "http://192.168.0.42:8585/restHotelView.do";
		break;
	default:
		break;
	}
	return url;
}

/* ajax성공 데이터 객체 배열에 추가 */
function sucHotelJson(d) {
	$.each(d, function(index, item) {
		data.push(item);
	});
	
}
/* ajax에러 */
function errorFunc(errData) {
  console.log(errData.state, errData.statusText);
  $('#load-img').hide();
}

/* 가격 순으로 정렬 메서드 */
function priceSortFunc(d) {
	var result = d.sort((a, b) => parseInt(a.price) - parseInt(b.price));
	return result;
}

/* 중복 제거 메서드 */
function reduceFunc(d) {
	var result = d.filter((item, i) => {
		return (
			d.findIndex((item2, j) => {
				return parseInt(item.room_idx) === parseInt(item2.room_idx);
			})	=== i	
		);
	});
	return result;
}

/* 리스트 출력 */
function print(d) {
	if(rcnt==""){
		rcnt = 1;
	}
	if(${index} == 2) {
		str += "<tr>";
		str += "	<td>Standard</td>";
		str += "	<td><img class='site_logo' src='images/logo.svg' alt='로고' /></td>";
		str += "	<td class='price_txt low_price'>" + ((d[0].price*0.97*min*rcnt).toFixed(0)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</td>";
		str += "	<td><a href='room.do?hotel_idx=" + d[0].hotel_idx + "' style='color:#fff; background: var(--primary-color);' class='site_go_btn pay'>상품 확인</a></td>";
		str += "</tr>";
	}
	$.each(d, function(index, item) {
		var multi = item.price * min * rcnt;
		var price = multi.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') ;
		if(index == 0) {
			console.log("index=", index);
			$('#mPrice').html(price + "원");
		}
		str += "<tr>";
		str += "	<td>" + item.room + "</td>";
		str += "	<td><img class='site_logo' src='images/";
		if(item.site =='booking') {
			str += "BOOKINGDOTCOM.png";
		}
		else if(item.site=="agoda") {
			str += "AGODA.png";
		}
		else if(item.site=="hotels") {
			str += "HOTELSDOTCOMHC.png";
		}
		else if(item.site=="expedia") {
			str += "EXPEDIAHOTELHC.png";
		}
		else {
			str += "HOTELSDOTCOMHC.png";
		}
		str += "' alt='로고' /></td>";
		str += "	<td class='price_txt low_price'>" + price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</td>";
		if(item.site =='hotelswatch') {
			str += "	<td><a href='https://www.hotels.com/' target='_blank' class='site_go_btn pay'>상품 확인</a></td>";
		}
		else if(item.site =='agoda') {
			str += "	<td><a href='https://www.agoda.com' target='_blank' class='site_go_btn'>상품 확인</a></td>";
		}
		else if(item.site =='booking') {
			str += "	<td><a href='https://www.booking.com' target='_blank' class='site_go_btn'>상품 확인</a></td>";
		}
		else if(item.site =='expedia') {
			str += "	<td><a href='https://www.expedia.com' target='_blank' class='site_go_btn'>상품 확인</a></td>";
		}
		str += "</tr>";
	});
	$('#roomResult').html(str);
	str="";
}

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
<body>
	<div id="skip_navi">
		<a href="#container">본문바로가기</a>
	</div>
	<div id="wrap">
		<header id="header">
			<div class="inner">
				<div class="logo">
					<a href="/">
						<p></p>
					</a>
				</div>
				<%@ include file="/WEB-INF/views/member/loginAuth.jsp"%>
			</div>
      	</header>
		</div>
		<main id="container" class="hotel_view_page sub_container">
	      <div class="contents">
	        <div class="inner">
	          <input type="hidden" value="${ht.hotel_idx }" id="roomAPI">
	          <ul class="tab_menu">
	            <li class="active info_btn" onclick="goToScroll('info_wrap')"><a href="#">개요</a></li>
	            <li class="price_btn" onclick="goToScroll('fee_wrap')"><a href="#">가격</a></li>
	            <li class="notice_btn" onclick="goToScroll('notice_wrap')"><a href="#">공지사항</a></li>
	            <li class="map_btn" onclick="goToScroll('map_wrap')"><a href="#">위치</a></li>
	            <li class="review_btn" onclick="goToScroll('review_wrap')"><a href="#">후기 5</a></li>
	          </ul>
	          <ul class="search_route">
	            <li><a href="#">${ht.country }</a></li>
	            <li><a href="#">${ht.city }</a></li>
	            <li><a href="#">${ht.province }</a></li>
	            <li><a href="#">${ht.street }</a></li>
	            <li>${ht.hotel }</li>
	          </ul>
	          <div id="info_wrap" class="info_wrap">
	            <div class="info_top">
	              <div class="left">
	                <h2>${ht.hotel }</h2>
	                <span class="addr">${ht.country } ${ht.city } ${ht.province } ${ht.street }</span>
	                <span class="grade">${grade } <em>/ 10</em></span>
	              </div>
	              <div class="right">
	                <div class="price_wrap">
	                  <span>총 금액</span>
	                  <c:set var="price" value="${ht.price * min * room_cnt}" />
	                  <a href="#" id="mPrice"><fmt:formatNumber value="${price}" pattern="#,###"/> 원</a>
	                </div>
	                <a href="#" class="site_name">${ht.site}</a>
	                <div class="btn_wrap">
	                  <a href="#" class="map_btn i_btn" onclick="goToScroll('map_wrap')">
	                    <span class="blind">지도 바로가기</span>
	                  </a>
	                  <a href="#" class="wish_btn i_btn">
	                    <span class="blind">위시리스트</span>
	                  </a>
	                  <a href="#" class="share_btn i_btn">
	                    <span class="blind">공유하기</span>
	                  </a>
	                  <a href="room.do?hotel_idx=${ht.hotel_idx }" class="site_go_btn">상품 확인</a>
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
                  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
                  <!-- Initialize Swiper -->
                  <script>
                    var swiper = new Swiper('.mySwiper', {
                      slidesPerView: 3,
                      spaceBetween: 20,
                      freeMode: true,
                      pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
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
	          <div id="fee_wrap" class="fee_wrap">
	            <strong class="view_tit">예약 가능 요금</strong>
	            <table>
	              <thead>
	                <tr>
	                 <th width="45%">숙소 유형</th>
	                 <th width="15%">공급 업체</th>
	                 <th width="25%">숙박 총액 + 세금 및 기타 요금</th>
	                 <th width="15%">예약 링크</th>
	                </tr>
	              </thead>
	              <tbody id="roomResult">
	              </tbody>
	            </table>
              <span
                >총 금액은 체크아웃 시 지불해야 하는 추정 지방세 및 수수료를
                포함하고 있습니다.</span
              >
              <span
                >표시 금액은 숙박 총액이며 세금 및 기타 요금을 포함하고
                있습니다.</span
              >
            </div>
	          <div id="notice_wrap" class="notice_wrap">
	            <strong class="view_tit">주요 공지사항</strong>
	            <div class="txt_wrap">
	              <div class="txt_left">
	                <div class="checkin">
	                  <strong>체크인</strong>
	                  <span>${ht.checkin_time } 이후</span>
	                </div>
	                <div class="checkout">
	                  <strong>체크아웃</strong>
	                  <span>${ht.checkout_time } 까지</span>
	                </div>
	              </div>
                <div class="txt_right">
                  <strong>취소/선결제</strong>
                  <span
                    >취소/선결제 정책은 객실 유형 및 예약 업체에 따라
                    다릅니다.</span
                  >
                </div>
              </div>
            </div>
            <div id="map_wrap" class="map_wrap">
	            <strong class="view_tit">지역 - ${ht.province }</strong>
	            <span>${ht.city } ${ht.province } ${ht.street }</span>
	            <input type="hidden" id="latTxt" name="latTxt" value="${ht.ht_lat }" />
				<input type="hidden" id="lngTxt" name="lngTxt" value="${ht.ht_lng }" />
	            <div class="map">
					<div id="map" style="width: 100%;height: 100%;"></div>
				</div>
            </div>
            <div id="review_wrap" class="review_wrap">
              <strong class="view_tit">후기</strong>
              <div class="grade_wrap">
                <div class="left">
                  <strong>${grade } <em>/ 10</em></strong>
                  <span></span>
                </div>
              </div>
              <ul class="review_list_wrap">
              	<%@ include file="../../../react_review/index.html" %>
              </ul>
              <%-- <div class="pagination">
                <span>1 - 11페이지</span>
                <button type="button" class="num_btn"></button>
              </div> --%>
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
              <li>©2024 HotelSwatch</li>
            </ul>
            <div class="exp">
              <p>
                호텔스와치에서 전 세계 주요 여행지의 호텔 상품을 최저가로
                만나보세요. 수 백개의 호텔 사이트를 검색하여, 고객님께서 딱 맞는
                호텔 상품을 바로 찾아 예약하실 수 있도록 도와드립니다.
                호텔스와치에서는 국내외 유명한 호텔 사이트를 한 번에 검색하여
                한눈에 비교할 수 있도록 도와 드리고 있어 특가 상품을 쉽게 찾으실
                수 있습니다. 지금 바로 시작해 보세요.
              </p>
            </div>
            <div class="link">
              <ul>
                <li>
                  <a href="#"><img src="./images/post.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/blog.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/brunch.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/facebook.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/youtube.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/instagram.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/googleplay.svg" /></a>
                </li>
                <li>
                  <a href="#"><img src="./images/appstore.svg" /></a>
                </li>
              </ul>
            </div>
            <div class="intro">
              <p>
                호텔스와치는 세계적인 온라인 여행 기업이 될 유니콘 기업입니다.
              </p>
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

window.onload = function() {
	$('#roomAPI').trigger('click');
	
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
        function show() {
          document.querySelector('.background').className = 'background show';
          document.querySelector('.popup3').style.visibility = 'hidden';
          document.querySelector('.popup2').style.visibility = 'hidden';
          document.querySelector('.popup').style.visibility = 'visible';
          $('.background .window .popup3 .email .inputwrap input').val('');
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
        document
          .querySelector('#continue')
          .addEventListener('click', continuous);

        document.querySelector('#back2').addEventListener('click', back2);
        document.querySelector('#close3').addEventListener('click', close3);
      </script>
    </div>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA5-DB9e6-Lsqr4KB8zDoW5lxRmSffl4u8"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=1280" />
<meta content="최저가 보장! 모아보면 보인다, HotelSwatch" name="description" />
<meta property="og:type" content="website" />
<meta property="og:title" content="HotelSwatch" />
<meta property="og:description" content="최저가 보장! 모아보면 보인다, HotelSwatch" />
<title>HotelSwatch</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@200;300;400;500;600;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="css/jquery-ui.min.css" />
<link rel="stylesheet" href="css/swiper.min.css" />
<link rel="stylesheet" href="css/common.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="css/main.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="css/sub.css?v=<?php echo time(); ?>" />
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/ui-common.js?v=<?php echo time(); ?>"></script>
<script src="js/sub.js?v=<?php echo time(); ?>"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css" />
<link rel="stylesheet" href="/resources/demos/style.css" />
    <script>
      $(function () {
        var checkoutDay;

        $('.search .condition .checkin').datepicker({
          dateFormat: 'yy-mm-dd',
          minDate: 0,
          onSelect: function (selectedDate) {
            var nextDay = new Date(selectedDate);
            nextDay.setDate(nextDay.getDate() + 1); // 선택한 날짜의 다음 날짜

            // 두 번째 datepicker의 minDate 설정
            $('.checkout').datepicker('option', 'minDate', nextDay);
          },
        });

        $('.search .condition .checkout').datepicker({
          dateFormat: 'yy-mm-dd',
        });

        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(today.getDate() + 1);

        $('.search .condition .checkin').val(
          today.toISOString().substring(0, 10)
        );
        $('.search .condition .checkout').val(
          tomorrow.toISOString().substring(0, 10)
        );
      });
    </script>
</head>
<body>
<script>
var str = "";
var data = [], pagingData = [];
var total;
var min = '<c:out value="${min}"/>';
var rcnt = '<c:out value="${room_cnt}"/>';
var clickPage = 1, currBlock = 1, start = 0, end = 9, totalCount=50, pageSize=10, blockSize=5;
//검색결과
function list(t){
	var searchWord = $('#searchWord').val();
	var minPrice = 0, maxPrice = 99999999, grade = 0.0;
	var site = [];
	console.log("등급= ", $('.btn_wrap .active').val());
	if($('#minPrice').val()) {
		minPrice = $('#minPrice').val();
	}
	if($('#maxPrice').val()) {
		maxPrice = $('#maxPrice').val();
	}
	if($('.btn_wrap .active').val()) {
		grade = $('.btn_wrap .active').val();
	}
	$('input:checkbox[name=site]').each(function (index) {
		if($(this).is(":checked")==true) {
			site.push($(this).val());
		}
	})
	for(var i = 0; i < site.length; i++) {
		$.ajax({
			url : getUrl(site[i]),
			type: 'get',
			async: false,
			data : {
				searchWord: searchWord,
				minPrice : minPrice,
				maxPrice : maxPrice,
				grade : grade,
			},
			dataType: 'json',
			contentType : 'application/json; charset=UTF-8',
			success : sucHotelJson,
			error : errorFunc
		})
	}
	//지도
	$.ajax({
		url : "./hotelMap.do",
		type: 'get',
		async: false,
		data : {
			searchWord: searchWord,
		},
		success : function(d){
			var mapStr = "<input type='hidden' id='latTxt' name='latTxt' value='" + d.latTxt + "' />";
			mapStr += "<input type='hidden' id='lngTxt' name='lngTxt' value='" + d.lngTxt + "' />";
			mapStr += "<div id='map'></div>";
			mapStr += "<button class='mapclose' type='button'>지도 닫기</button>";
			$('#map_wrap').html(mapStr);
		},
		error : function(e){
			console.log("결과 개수 실패", e.state, e.statusText);
		}
	})
	
	var hotelList;
	var hotelSort = priceAsc(data);
	var hotelReduce = reduceFunc(hotelSort);
	if(t.text == "거리 순"){
		hotelList = disKmAsc(hotelReduce);
	}
	else if(t.text == "호텔 평점 낮은 순"){
		hotelList = gradeAsc(hotelReduce);
	}
	else if(t.text == "호텔 평점 높은 순") {
		hotelList = gradeDesc(hotelReduce);
	}
	else if(t.text == "가격 높은 순"){
		hotelList = priceDesc(hotelReduce);
	}
	else {
		hotelList = priceAsc(hotelReduce);
	}
	$('#total').html(hotelList.length+"개의 결과");
	print(hotelList, start, end);
	openMap();
	pagingData=hotelList;
	data =[];
}

function getUrl(site) {
	var url;
	switch(site) {
	case "hotelswatch" : 
		url = "./searchHotel.do";
		break;
	case "booking" : 
		url = "http://192.168.0.42:8586/restHotelSearch.do";
		break;
	case "agoda" : 
		url = "http://192.168.0.42:8585/restHotelSearch.do";
		break;
	/* case "expedia" : 
		url = "http://192.168.0.42:8587/restHotelSearch.do";
		break; */
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
  //$('#load-img').hide();
}

/* 가격 순으로 정렬 메서드 */
function priceAsc(d) {
	var firstSort = d.sort((a, b) => parseInt(a.price) - parseInt(b.price));
	return firstSort;
}
function priceDesc(d) {
	var firstSort = d.sort((a, b) => parseInt(b.price) - parseInt(a.price));
	return firstSort;
}

/* 호텔 평점 순으로 정렬 메서드 */
function gradeAsc(d) {
	var firstSort = d.sort((a, b) => parseFloat(a.grade) - parseFloat(b.grade));
	return firstSort;
}
function gradeDesc(d) {
	var firstSort = d.sort((a, b) => parseFloat(b.grade) - parseFloat(a.grade));
	return firstSort;
}

/* 거리 순으로 정렬 메서드 */
function disKmAsc(d) {
	var firstSort = d.sort((a, b) => parseFloat(a.disKm) - parseFloat(b.disKm));
	return firstSort;
}

/* 중복 제거 메서드 */
function reduceFunc(d) {
	var result = d.filter((item, i) => {
		return (
			d.findIndex((item2, j) => {
				return parseInt(item.hotel_idx) === parseInt(item2.hotel_idx);
			})	=== i	
		);
	});
	return result;
}

//검색 유효성 체크(검색어)
function validateForm(form) {
	if(form.searchWord.value=="") {
		alert("장소를 입력해주세요.");
		form.searchWord.focus();
		return false;
	}
}

/* 페이징 */
function dataPaging(t) {
	var startBlock = (clickPage - 1) * pageSize + 1;
	var endBlock = clickPage * pageSize;
	if(t.value==1 || t.value==2 || t.value==3 || t.value==4 || t.value==5 ) {
		clickPage = t.value;
		start = (clickPage - 1) * 10;
		end = (clickPage * 10) - 1;
	}
	print(pagingData, start, end);
}
/* 리스트 출력 */
function print(d, sPage, ePage) {
	if(rcnt==""){
		rcnt = 1;
	}
	for(var i = sPage; i <= ePage; i++){
		console.log("d=",d[0].price);
		if(!d[i] == false) {
			var multi = d[i].price * min * rcnt;
			var price = multi.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') ;
			str += "<div class='result_box'>";
			str += "	<div class='hotel_image'>";
			str += "		<img src='" + d[i].picture + "' width='250px'/>";
			str += "	</div>";
			str += "	<div class='hotel_info'>";
			str += "		<div class='top'>";
			str += "			<div class='top_l'>";
			str += "				<a href='./viewHotel.do?hotel_idx=" + parseInt(d[i].hotel_idx) + "&index=" + i + "' class='hotel_name'>" + d[i].hotel + "</a>";
			str += "				<div class='map_info'>";
			str += "				<a href='javascript:void(0);' onclick='goHotelMap(this);' class='gu' id='" + i + "'>" + d[i].province + "</a>";
			str += "				<a href='#'>" + d[i].disKm.toFixed(1) + "km</a>";
			str += "				</div>";
			str += "			</div>";
			str += "			<div class='top_r'>";
			str += "			<strong class='grade'>" + d[i].grade.toFixed(1) + "<em>/10</em></strong>";
			str += "			<span class='review_txt' id='review_test'>후기 " + d[i].total_comment + "개</span>";
			str += "			</div>";
			str += "		</div>";
			str += "		<div class='bottom'>";
			str += "			<div class='bottom_l'>";
			str += "			<span>최저가 사이트</span>";
			if(d[i].site == "agoda") {
				str += "		<img src='images/AGODA.png' alt='로고' />";
			}
			else if(d[i].site =="booking") {
				str += "		<img src='images/BOOKINGDOTCOM.png' alt='로고' />";
			}
			else {
				str += "		<img src='images/EXPEDIAHOTELHC.png' alt='로고' />";
			}
			str += "		</div>";
			str += "		<div class='bottom_r'>";
			str += "			<span>1박 요금</span>";
			str += "			<strong class='price'>" + price + "원</strong>";
			str += "				<div class='btn_wrap'>";
			str += "					<a class='now_btn' href='#'>바로 예약</a>";
			str += "					<a class='more_btn now_btn' href='./viewHotel.do?hotel_idx=" + parseInt(d[i].hotel_idx) + "&index=" + i + "'>상세 보기</a>";
			str += "				</div></div></div></div></div>";
		}
		
	}
	$('#result_wrap').html("");
	$('#result_wrap').html(str);
	str="";
}

function openMap() {
	console.log("openMap");
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
var showPosition = function(position){
	var latitude = parseFloat(document.getElementById("latTxt").value);
	var longitude = parseFloat(document.getElementById("lngTxt").value);
	
	initMap(latitude, longitude);
}
function initMap(latVar, lngVar) {		
	var uluru = {lat: latVar, lng: lngVar};
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 13, 
		center: uluru,
		disableDefaultUI: true,
	});
	var marker = new google.maps.Marker({
		position: uluru,
		map: map,
		icon: './icon/icon_me.png'
		
	});
	
	//////////////////////////////////////////////////////////////////////////
	//다중마커s
	var infowindow = new google.maps.InfoWindow();
	
	var locations = [];
	for(var i = 0; i < pagingData.length; i++){
		locations.push([pagingData[i].picture, pagingData[i].hotel, pagingData[i].price, pagingData[i].ht_lat, pagingData[i].ht_lng, pagingData[i].hotel_idx]);
	}
	
 	var marker, i;

	for (i=0; i<locations.length; i++) {  
		var total = document.getElementById(i);
		
		marker = new google.maps.Marker({
			id:i,
			position: new google.maps.LatLng(locations[i][3], locations[i][4]),
			map: map,
			icon: './icon/icon_facil.png'
		});
	
		google.maps.event.addListener(marker, 'click', (function(marker, i) {
			return function() {
				infowindow.setContent("<img id='test' src='" +locations[i][0] + "' style='width:100px; height:50px'/><br/>" + locations[i][1]+"<br/>가격: " + locations[i][2] + "원<br/><a href='./viewHotel.do?hotel_idx="+locations[i][5]+"&index=" + i + "'>바로가기</a>");
				infowindow.open(map, marker);
			}
		})(marker, i));
		
		google.maps.event.addDomListener(total, 'click', (function(marker, i) {
			return function() {
				infowindow.setContent("<img id='test' src='" +locations[i][0] + "' style='width:100px; height:50px'/><br/>" + locations[i][1]+"<br/>가격: " + locations[i][2] + "원<br/><a href='./viewHotel.do?hotel_idx="+locations[i][5]+"&index=" + i + "'>바로가기</a>");
				infowindow.open(map, marker);
			}
		})(marker, i));
		
		if(marker)
		{
			marker.addListener('click', function() {
				map.setZoom(16);
				map.setCenter(this.getPosition());
			});
		}
	}
	//다중마커e
	//////////////////////////////////////////////////////////////////////////
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

function goHotelMap(t) {
	console.log("word=", $('#map') );
	var searchWord = t.text;
	
}

</script>
	<div id="skip_navi">
		<a href="#container">본문바로가기</a>
	</div>
	<div id="wrap" class="search_page">
		<header id="header">
			<div class="inner">
				<div class="logo">
					<a href="/">
						<p></p>
					</a>
				</div>
				<div class="search">
		          	<form class="condition" action="hotelList.do" method="get" >
			            <input class="city" type="text" id="searchWord" name="searchWord" value="${searchDTO.searchWord }" placeholder="서울, 대한민국">
			            <div class="date_wrap">
				            <input class="checkin" type="text" name="checkin" placeholder="${checkin }" value="${checkin }" />
				            <input class="checkout" type="text" name="checkout" placeholder="${checkout }" value="${checkout }" />
			            </div>
			            <input class="person" type="text" name="room_cnt" placeholder="객실 1개" value="${room_cnt }" />
						<div class="buttonwrap">
							<button class="button" type="submit" id="hotelAPI""></button>
						</div>
					</form>
				</div>
			<%@ include file="/WEB-INF/views/member/loginAuth.jsp"%>
			</div>
		</header>
      <main id="container" class="sub_container">
        <div class="filter_wrap">
          <div class="inner">
            <div class="price_filter_group">
              <button type="button" class="filter price_filter">
                <p>가격순</p>
                <img src="./images/arrow_icon.svg" />
              </button>
              <div class="price_filter_wrap">
                <span class="filter_tit">가격순</span>
                <form>
                  <input class="price_txt" type="number" id="minPrice" placeholder="21,820" />
                  <span>~</span>
                  <input
                    class="price_txt"
                    type="number"
                    id="maxPrice"
                    name="maxPrice"
                    placeholder="10,000,000"
                  />
                  <button type="button"class="apply_btn" onclick="list(this);">적용</button>
                </form>
              </div>
            </div>
            <div class="review_filter_group">
              <button type="button" class="filter review_filter">
                <p>후기 평점</p>
                <img src="./images/arrow_icon.svg" />
              </button>
              <div class="review_filter_wrap">
                <span class="filter_tit">후기 평점</span>
                <div class="btn_wrap">
	                <button type="button" class="all review_btn active" value="0">
	                  0+
	                </button>
	                <button type="button" class="normal review_btn" value="6">
	                  6+
	                  <div class="tip">보통이상</div>
	                </button>
	                <button type="button" class="good review_btn" value="7">
	                  7+
	                  <div class="tip">좋음</div>
	                </button>
	                <button type="button" class="very_good review_btn" value="8">
	                  8+
	                  <div class="tip">매우좋음</div>
	                </button>
	                <button type="button" class="great review_btn" value="9">
	                  9+
	                  <div class="tip">훌륭함</div>
	                </button>
                </div>
                <button type="button" class="apply_btn" onclick="list(this);">적용</button>
              </div>
            </div>
            <div class="site_filter_group">
              <button type="button" class="filter site_filter">
                <p>예약 사이트</p>
                <img src="./images/arrow_icon.svg" />
              </button>
              <div class="site_filter_wrap">
                <span class="filter_tit">예약 사이트</span>
                <ul class="site_list">
                  <li>
                    <input type="checkbox" name="site" id="hotelswatch" value="hotelswatch" checked />
                    <label for="hotelswatch">호텔스와치</label>
                  </li>
                  <li>
                    <input type="checkbox" name="site" id="expedia" value="expedia" checked />
                    <label for="expedia">익스피디아</label>
                  </li>
                  <li>
                    <input type="checkbox" name="site" id="booking" value="booking" checked />
                    <label for="booking">부킹닷컴</label>
                  </li>
                  <li>
                    <input type="checkbox" name="site" id="agoda" value="agoda" checked />
                    <label for="agoda">아고다</label>
                  </li>
                  <!-- <li>
                    <input type="checkbox" name="site" id="expedia" value="hotelswatch" checked />
                    <label for="expedia"></label>
                  </li>
                  <li>
                    <input type="checkbox" name="site" id="hotels" value="hotels" checked />
                    <label for="hotels">호텔스닷컴</label>
                  </li> -->
                </ul>
                <button type="submit" class="apply_btn" onclick="list(this);">적용</button>
              </div>
            </div>
            <div class="map">
              <button type="button" class="filter map" >
                <p>지도 보기</p>
              </button>
            </div>
          </div>
        </div>
	      <div class="contents">
	        <div class="inner">
	          <div class="result_txt_wrap">
	            <span id="total"></span>
	            <div class="result_sort_wrap">
	              <button type="button" class="sort_btn">가격 낮은 순</button>
	              <ul class="sort_list">
	                <li><a href="#" onclick='list(this);' >가격 낮은 순</a></li>
	                <li><a href="#" onclick='list(this);' >가격 높은 순</a></li>
	                <li><a href="#" onclick='list(this);' >호텔 평점 낮은 순</a></li>
	                <li><a href="#" onclick='list(this);' >호텔 평점 높은 순</a></li>
	                <li><a href="#" onclick='list(this);' >거리 순</a></li>
	              </ul>
	            </div>
	          </div>
            <div class="divide">
              <div class="nomap">
	          <div class="result_wrap" id="result_wrap">
              </div>
                <div class="pagination">
                  <button type="button" class="prev_btn" onclick="dataPaging(this)" value="prevBlock"></button>
                  <button type="button" class="num_btn active" onclick="dataPaging(this)" value="1">1</button>
                  <button type="button" class="num_btn" onclick="dataPaging(this)" value="2">2</button>
                  <button type="button" class="num_btn" onclick="dataPaging(this)" value="3">3</button>
                  <button type="button" class="num_btn" onclick="dataPaging(this)" value="4">4</button>
                  <button type="button" class="num_btn" onclick="dataPaging(this)" value="5">5</button>
                  <button type="button" class="next_btn" onclick="dataPaging(this)" value="nextBlock"></button>
                </div>
              </div>
              <div class="map">
                <button class="mapclose" type="button">지도 닫기</button>
                <div id="map_wrap">
	                <input type="hidden" id="latTxt" name="latTxt" value="${latTxt }" />
					<input type="hidden" id="lngTxt" name="lngTxt" value="${lngTxt }" />
	      			<div id="map"></div>
      			</div>
              </div>
            </div>
          </div>
        </div>
      </main>
      <!-- 푸터 -->
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
<script>
window.onload = function() {
	/* $('#hotelAPI').trigger('click'); */
	list($('#hotelAPI'));
	console.log("새로고침");
}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=${apiKey }"></script>
</body>
</html>
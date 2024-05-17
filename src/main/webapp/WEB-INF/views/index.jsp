<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css" />
<link rel="stylesheet" href="/resources/demos/style.css" />
    <script>
 function validateForm(frm) {
	 if($('#room_cnt').val() == "") {
		 $('#room_cnt').val() = 1;
	 }
	 
	 if($('#room_cnt').val() < 1) {
		 alert("1이상의 숫자를 입력해주세요.");
		 frm.room_cnt.focus();
		 return false;
	 }
 }
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
      <main id="container">
        <section class="searchwrap">
          <div class="searchbox">
            <div class="inner">
              <div class="intro">
                <h1>580만 개 호텔 한 번에 비교 예약, 최저가 보장!</h1>
                <ul class="provider">
                  <li><img src="./images/booking.svg" /></li>
                  <li><img src="./images/hotels.svg" /></li>
                  <li><img src="./images/agoda.svg" /></li>
                  <li><img src="./images/expedia.svg" /></li>
                  <li><img src="./images/trip.svg" /></li>
                  <li><img src="./images/tripbtoz.svg" /></li>
                  <li><img src="./images/hanatour.svg" /></li>
                  <li><img src="./images/modutour.svg" /></li>
                  <li><img src="./images/yanolja.svg" /></li>
                  <li><img src="./images/hotelpass.svg" /></li>
                  <li><img src="./images/rakutentravel.svg" /></li>
                </ul>
              </div>
              <div class="search">
                <form
                  class="condition"
                  action="./hotelList.do"
                  method="get"
                  onsubmit="return validateForm(this);"
                >
                  <input
                    class="city"
                    type="text"
		    name="searchWord"
                    placeholder="도시, 호텔, 공항 또는 랜드마크를 입력하세요."
                  />
                  <div class="date_wrap">
	                  <input class="checkin" type="text" name="checkin" />
	                  <input class="checkout" type="text" name="checkout" />
                  </div>
                  <input class="person" type="number" name="room_cnt" id="room_cnt" placeholder="객실 1개" />
                  <div class="buttonwrap">
                    <input class="button" type="submit" value="" />
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
        <section class="promo">
          <div class="inner">
            <div class="img">
              <img src="./images/promotion.jpg" />
            </div>
            <div class="txt">
              <img src="./images/toscana.svg" />
              <div class="txtwrap">
                <h1>토스카나 호텔, 온 가족이 함께 야외 온수풀 호캉스</h1>
                <p>
                  이국적인 수영장, 제주 최대 규모 키즈룸, 아이 동반 맞춤 서비스,
                  씨푸드 뷔페 다이닝으로 편안한 가족 여행을 계획해보세요.
                </p>
              </div>
              <button>
                혜택 더 보기
              </button>
            </div>
          </div>
        </section>
        <div class="firstprize">
          <div class="inner">
            <img src="./images/award.jpg" />
            <div class="txtwrap">
              <h3>2023 소비자가 뽑은 숙박앱 ‘1위'</h3>
              <p>
                호텔스와치가 2023 브랜드 고객충성도 대상을 수상하였습니다. 고객
                여러분의 관심과 사랑에 진심으로 감사드리며, 더 큰 신뢰와
                서비스로 보답하는 호텔스와치가 되겠습니다.
              </p>
            </div>
          </div>
        </div>
			<section class="event">
				<div class="inner">
					<div class="titlewrap">
						<h2>이달의 혜택</h2>
						<button type="button"
							onclick="location.href='./postLists.do?route=event'">모두
							보기</button>
					</div>
					<div class="eventwrap">
						<div class="ev01">
							<a href="./postView.do?post_idx=1&type=e"><img
								src="./images/ebanner01.png"></a>
						</div>
						<div class="ev02">
							<a href="./postView.do?post_idx=2&type=e"><img
								src="./images/ebanner02.png"></a>
						</div>
						<div class="ev03">
							<a href="./postView.do?post_idx=3&type=e"><img
								src="./images/ebanner03.png"></a>
						</div>
					</div>
				</div>
			</section>
			<section class="notice">
				<div class="inner">
					<div class="titlewrap">
						<h2>호텔스와치 이용 꿀팁</h2>
						<button type="button"
							onclick="location.href='./postLists.do?route=notice'">모두
							보기</button>
					</div>
					<div class="noticewrap">
						<div class="no01">
							<a href="./postView.do?post_idx=16&type=n"><img
								src="./images/nbanner01.png"></a>
						</div>
						<div class="no02">
							<a href="./postView.do?post_idx=17&type=n"><img
								src="./images/nbanner02.png"></a>
						</div>
					</div>
				</div>
			</section>
        <section class="hotelswatch">
          <div class="inner">
            <h2>호텔스와치 소개</h2>
            <p>
              호텔스와치에서는 고객님의 편에서 다양한 세계 여행을 탐색합니다.
              고급 검색 엔진을 통해 여행 계획 과정을 간소화하여 최적의 항공권,
              숙소, 렌터카를 손쉽게 찾을 수 있도록 도와드립니다. 여행사 및
              광고주와 제휴하는 비즈니스 모델 덕분에 무유용한 서비스를 무료로
              제공하고 있습니다. 여행을 ​떠나는 고객분들께 최고의 혜택을
              제공하는 것이 저희의 사명입니다. 호텔스와치에서는 고객님의 여행
              이야기를 최우선으로 생각합니다.
            </p>
            <h2>가격 알리미를 설정하고 스마트하게 절약하세요</h2>
            <p>
              가격 알리미 기능에는 고객분들께 더 편리한 여행 계획 도구를
              제공하고자 하는 저희의 노력이 담겨있습니다. 항공권, 호텔, 렌터카
              예약을 고려 중이지만 아직 예약을 확정할 준비가 되지 않았다면 가격
              알리미를 간편하게 설정해 보세요. 이메일 주소를 등록하시면 관심
              있는 상품의 가격이 떨어질 때 알림을 받으실 수 있습니다. 이렇게
              하면 가격이 가장 저렴할 때 바로 예약을 확정할 수 있습니다.
            </p>
            <h2>호텔스와치에서 이용 경험을 극대화하세요</h2>
            <p>
              ㆍ호텔스와치를 가장 효과적으로 사용하려면 사용자 지정이 가능한
              필터링 옵션을 활용하세요. 가격, 편의시설, 쾌적도 등 각자의 여행
              취향에 맞게 검색을 맞춤 설정할 수 있습니다.<br />
              ㆍ선택하신 상품의 총 금액을 자세히 살펴보세요. 저희는 투명성을
              약속드리며 제시된 가격이 모든 것을 포함한 최종 가격임을
              보장합니다.<br />
              ㆍ빠르게 변화하는 여행 상품에 대한 최신 정보를 받아보세요. 가격은
              수시로 달라질 수 있으므로 원하는 조건에 맞는 상품을 발견하셨다면
              즉시 예약하는 것이 좋습니다.
            </p>
          </div>
        </section>
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
  </body>
</html>

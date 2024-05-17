<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
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
    <main id="container" class="all_event_page sub_container">
      <div class="sub_tit_wrap">
        <h2 class="tit">호텔스와치 공지사항</h2>
      </div>
      <div class="content">
        <div class="inner">
          <ul class="event_list">
            <li class="list_tit">전체 이용 꿀팁</li>
		<c:choose>
			<c:when test="${ empty noticeLists }">
				<li>
					등록된 게시물이 없습니다~
				</li>
			</c:when>
			<c:otherwise>
				<c:forEach items="${ noticeLists }" var="row" varStatus="loop">
					<li class="event_box">
		              <a href="./postView.do?post_idx=${ row.post_idx }&type=n" class="left">
		                <img src="./uploads/${ row.sthumb }" alt="새로워진 맥스의 돌잔치를 축하해주세요!" />
		              </a>
		              <div class="right">
		                <span class="tag hotel">호텔</span>
		                <strong>${ row.title }</strong>
		                <p>${ row.content }</p>
		                <p class="period">${fn:substring(row.postdate,0,7) }</p>
		                <a href="./postView.do?post_idx=${ row.post_idx }&type=e" class="more_btn">자세히 보기</a>
		              </div>
		            </li>
				</c:forEach>
			</c:otherwise>
		</c:choose>
          </ul>
        </div>
        <table border="1" width="90%">
			<tr align="center">
				<td>
					${ pagingImg }
				</td>
			</tr>
		</table>
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
                <li><a href="./postWrite.do">위치별 호텔 검색</a></li>
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
  </div>
</body>
</html>
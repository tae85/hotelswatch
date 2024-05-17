<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="최저가 보장! 모아보면 보인다, HotelSwatch" name="description">
<meta property="og:type" content="website">
<meta property="og:title" content="HotelSwatch">
<meta property="og:description" content="최저가 보장! 모아보면 보인다, HotelSwatch">
<title>모두보기</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href=" css/common.css" />
<link rel="stylesheet" href="css/main.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css" />
<link rel="stylesheet" href="css/swiper.min.css" />
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/ui-common.js?v=<?php echo time(); ?>"></script>
<script src="js/sub.js"></script>
<script>
let deletePost = function(post_idx) {
	let frm = document.writeFrm;
	if(confirm('정말 삭제할까요?')) {
		frm.post_idx.value = post_idx;
		frm.action = "postDelete.do";
		frm.method = "post";
		frm.submit();
	}
}
</script>
</head>
<body>
	<c:choose>
		<c:when test="${postDTO.type eq 'e' }">
			<c:set var="route" value="event" />
		</c:when>
		<c:when test="${postDTO.type eq 'n' }">
			<c:set var="route" value="notice" />
		</c:when>
	</c:choose>
	<div id="wrap" class="post_view_page">
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
		<%-- <h2>게시판 상세보기</h2>	
		<form name="writeFrm">
			<input type="hid-den" name="post_idx" value="${postDTO.post_idx }" />
			<input type="hid-den" name="type" value="${postDTO.type }" />
		</form>
		<table border="1" width="90%">
		    <colgroup>
		        <col width="15%"/> <col width="35%"/>
		        <col width="15%"/> <col width="*"/>
		    </colgroup>	
		    <!-- 게시글 정보 -->
		    <tr>
		        <td>번호</td> <td>${ postDTO.post_idx }</td>
		    </tr>
		    <tr>
		        <td>작성일</td> <td>${ postDTO.postdate }</td>
		        <td>조회수</td> <td></td>
		    </tr>
		    <tr>
		        <td>제목</td>
		        <td colspan="3">${ postDTO.title }</td>
		    </tr>
		    <tr>
		        <td>내용</td>
		        <td colspan="3" height="100">
		        	${ postDTO.content }	   
					<img src="./uploads/${postDTO.sfile }" alt="내용"/>    	
		        </td>
		    </tr>
		    <tr>
		    	<td colspan="3" >
				<c:forEach items="${ saveFileMaps }" var="row" varStatus="status">
					업로드 한 파일명${ status.count } : ${ row.key } <br>
					저장된 파일명${ status.count } : ${ row.value } <br>
					<img src="./uploads/${ row.value }"/><br>
				</c:forEach>
		    	</td>
		    </tr>
		    <tr>
		    	<td colspan="3" >첨부파일 : <input type="file" name="fileList" multiple/></td>
		    </tr>
		    <!-- 하단 메뉴(버튼) -->
		    <tr>
		        <td colspan="4" align="center">
		            <button type="button" onclick="location.href='./postEdit.do?post_idx=${ param.post_idx }&type=${postDTO.type }';">
		                수정하기
		            </button>
		            <button type="button" onclick="deletePost(${ param.post_idx });">
		                삭제하기
		            </button>
		            <button type="button" onclick="location.href='./postLists.do?route=${route}';">
		                목록 바로가기
		            </button>
		        </td>
		    </tr>
		</table> --%>
		<main id="container" class="sub_container">
			<img src="./uploads/${postDTO.sfile }" alt="내용" width="100%"/>  
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
	</div>
</body>
</html>
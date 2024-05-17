<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
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
<link rel="stylesheet" href="css/main.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/payment.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css" />
<link rel="stylesheet" href="css/swiper.min.css" />
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/sub.js"></script>
</head>
<body>
	<div id="wrap" class="complete_page">
		<main id="container" class="sub_container">
			<div class="complete">
				<strong>결제가 완료되었습니다.</strong> <span>(결제 완료 시간 :
					${payment.paydate})</span>
				<div class="hotel_info">
					<img src="images/m1.jpg" alt="호텔 사진" />
					<div class="txt_wrap">
						<strong class="name"> ${payment.payproduct}</strong>
						<p class="checkin">
							<em>체크인</em>${payment.payperiod.split(" - ")[0]}
						</p>
						<p class="checkout">
							<em>체크아웃</em>${payment.payperiod.split(" - ")[1]}
						</p>
						<div class="price_wrap">
							<p>결제 금액</p>
							<strong class="price"><fmt:formatNumber
									value="${payment.payprice}" pattern="#,###,###" />원</strong>
						</div>
					</div>
				</div>
				<div class="btn_wrap">
					<a href="#">홈페이지</a> <a href="#">마이페이지</a>
				</div>
			</div>
		</main>
	</div>
</body>
</html>
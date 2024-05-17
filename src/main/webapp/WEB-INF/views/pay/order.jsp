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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/main.css?v=<%= System.currentTimeMillis() %>" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/payment.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css" />
<link rel="stylesheet" href="css/swiper.min.css" />
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/ui-common.js?v=<%= System.currentTimeMillis() %>"></script>
<script src="js/sub.js"></script>
<!--포트원 sdk 라이브러리 v1 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
	<div id="wrap" class="payment_page">
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
		<main id="container" class="sub_container">
			<div class="inner">
				<div class="pay_info_wrap">
					<div class="hotel_wrap">
						<span class="site_txt">호스텔</span> <strong class="hotel_name">${room.hotel}</strong>
						<p class="addr_txt">${room.country} ${room.city} ${room.province} ${room.street}</p>
						<span class="grade">${grade}</span> <span class="review_txt">후기 570개</span>
					</div>
					<div class="reserve_info_wrap">
						<strong class="tit">내 예약 정보</strong>
						<div class="time_wrap">
							<div class="checkin">
								<span>체크인</span> <span class="date_txt" id="checkin">${checkin}</span>
								<span class="time_txt">${room.checkin_time}부터</span>
							</div>
							<div class="checkout">
								<span>체크아웃</span> <span class="date_txt" id="checkout">${checkout}</span>
								<span class="time_txt">${room.checkout_time}까지</span>
							</div>
						</div>
						<p class="total_stay_txt">총 숙박 기간:</p>
						<strong class="total_stay">${min}박</strong>
						<div class="option_wrap">
							<!-- 여기에 룸이름이 나와야 함 -->
							<span>선택한 옵션</span> <strong class="option_txt">${room_cnt}개 객실 - 성인 2명 숙박</strong> <a href="#">다른 객실로 변경</a>
						</div>
					</div>
					<div class="pay_history_wrap">
						<strong class="tit">결제 요금 내역</strong>
						<div class="total_charge">
							<strong>총 요금</strong>
							<div class="charge_wrap">
								<c:set var="oPrice" value="${room.price * min * room_cnt}" />
								<c:set var="dPrice" value="${room.price * min * room_cnt * 0.97}" />
								<span class="basic_charge"><fmt:formatNumber value="${oPrice}" pattern="#,###,###" /></span> 
								<strong>￦<fmt:formatNumber value="${dPrice}" pattern="#,###,###" /></strong> 
								<span>세금 및 기타 요금 포함</span>
							</div>
						</div>
					</div>
					<div class="cancel_wrap">
						<strong class="tit">취소 위약금은 얼마인가요?</strong>
						<div class="txt_wrap">
							<span>취소 시 수수료가 부과됩니다</span> <span>￦73,500</span>
						</div>
					</div>
				</div>
				<div class="user_info_wrap">
					<div class="user_info">
						<strong class="tit">상세 정보를 입력해 주세요</strong>
						<div class="tip">
							<p>이제 거의 마무리되었어요! <span>*</span>필수 정보만 마저 입력하시면 됩니다.</p>
							<p>개인 정보를 한국어 또는 영어로 입력해 주십시오.</p>
						</div>
						<form id="paymentForm">
							<div class="name_wrap">
								<div class="last_name">
									<span class="info_tit">성(영문)<em> *</em></span> <input type="text" class="info_form" id="last_name" />
								</div>
								<div class="first_name">
									<span class="info_tit">이름(영문)<em> *</em></span> <input type="text" class="info_form" id="first_name" />
								</div>
							</div>
							<div class="mail_addr">
								<span class="info_tit">이메일 주소<em> *</em></span>
								<c:choose>
									<c:when test="${member.email != null && !member.email.isEmpty()}">
										<input type="text" class="info_form" id="email" value="${member.email}" />
									</c:when>
									<c:otherwise>
										<input type="text" class="info_form" id="email" value="${member.naver}" />
									</c:otherwise>
								</c:choose>
								<p>예약 확인서가 전송될 이메일 주소 입력</p>
							</div>
							<div class="mail_addr">
								<span class="info_tit">국가/지역<em> *</em></span>
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
							<div class="phone_num">
								<span class="info_tit">전화번호 (가능한 경우 휴대폰)<em> *</em></span>
								<div class="phone_wrap">
									<select>
										<option>+1</option>
										<option>+1 671</option>
										<option>+233</option>
										<option>+250</option>
										<option>+256</option>
										<option>+299</option>
										<option>+30</option>
										<option>+31</option>
										<option>+32</option>
										<option>+33</option>
										<option>+34</option>
										<option>+351</option>
										<option>+352</option>
										<option>+353</option>
										<option>+354</option>
										<option>+41</option>
										<option>+43</option>
										<option>+44</option>
										<option>+46</option>
										<option>+49</option>
										<option>+81</option>
										<option selected>+82</option>
										<option>+84</option>
										<option>+852</option>
										<option>+853</option>
										<option>+855</option>
										<option>+856</option>
										<option>+86</option>
										<option>+880</option>
										<option>+886</option>
									</select> 
									<input type="text" class="info_form" oninput="oninputPhone(this)" maxlength="13" id="phoneNumber" />
								</div>
								<p>숙박 시설에서 연락을 드릴 수 있습니다.</p>
							</div>
							<div class="check_wrap">
								<input type="checkbox" id="confirmation_check" /> 
								<label for="confirmation_check">모바일 예약 확인서 무료로 받기 (권장)</label>
								<p>앱 다운로드를 위한 링크를 문자 메시지로 보내드립니다.</p>
							</div>
							<div class="name_wrap">
								<span class="room_tit">투숙객 성명</span> 
								<input type="text" id="name" />
							</div>
							<div class="request_wrap">
								<strong class="tit">별도 요청 사항</strong>
								<p>별도 요청 사항을 보장해드릴 수는 없으나, 숙소 측에서 서비스 제공을 위해 최선의 노력을 다할 것입니다. 예약을 완료한 후에도 별도 요청 사항을 보내실 수 있으니 참고 바랍니다.</p>
								<div class="request_field">
									<span class="request_tit">아래에 요청 사항을 작성해 주시기 바랍니다. <em>(선택 사항)</em></span>
									<textarea id="requestMemo"></textarea>
								</div>
							</div>
							<div class="btn_wrap">
								<span>최저가 맞춤</span> 
								<a href="#" class="prev_btn">이전</a> 
								<a href="#" class="next_btn">다음: 최종단계</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script>
	
	
		$(document).ready(function() {
			setDayNames();
			$(".next_btn").on("click", function() {
				pay();
			});
		});

		function pay() {
			const lastName = $("#last_name").val();
			const firstName = $("#first_name").val();
			const email = $("#email").val();
			const phoneNumber = $("#phoneNumber").val();
			const guestName = $("#name").val();

			if (!lastName) {
				alert("성을 입력해 주세요.");
				$("#last_name").focus();
				return;
			}
			if (!firstName) {
				alert("이름을 입력해 주세요.");
				$("#first_name").focus();
				return;
			}
			if (!email) {
				alert("이메일 주소를 입력해 주세요.");
				$("#email").focus();
				return;
			}
			if (!phoneNumber) {
				alert("전화번호를 입력해 주세요.");
				$("#phoneNumber").focus();
				return;
			}
			if (!guestName) {
				alert("투숙객 성명을 입력해 주세요.");
				$("#name").focus();
				return;
			}

			// 모든 필드가 유효하면 결제 진행
			kg_request_pay();
		}

		function kg_request_pay() {
			const buyerEmail = $("#email").val();
			const buyerName = $("#name").val();
			const requestMemo = $("#requestMemo").val();
			const firstName = $("#first_name").val();
			const lastName = $("#last_name").val();
			const phone = $("#phoneNumber").val();

			const checkinDate = $("#checkin").text().split(" (")[0].trim();
			const checkoutDate = $("#checkout").text().split(" (")[0].trim();
			const payperiod = checkinDate + " - " + checkoutDate;

			// 주문번호 생성
			const orderNumber = createOrderNum();

			// 결제 사전 검증
			$.ajax({
				url: 'payment/prepare',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					merchantUid: orderNumber,
					amount: 100 // 실제 결제 금액
				}),
				success: function(res) {
					if (res) {
						// 결제 요청
						IMP.init("imp42454125");
						IMP.request_pay({
							pg: "html5_inicis",
							pay_method: "card",
							merchant_uid: orderNumber, // 주문 고유번호
							name: "종로쉘라근 스탠다드", // 호텔이름 + 룸 옵션 으로 구현해야함.
							amount: 100, // 가격
							buyer_email: buyerEmail,
							buyer_name: buyerName,
							buyer_tel: phone
						}, function(rsp) {
							console.log(rsp);
							if (rsp.success) {
								$.ajax({
									url: 'payment/validate',
									type: 'POST',
									contentType: 'application/json',
									data: JSON.stringify({
										imp_uid: rsp.imp_uid,
										merchant_uid: rsp.merchant_uid
									}),
									success: function(validateRes) {
										if (validateRes === "결제가 유효합니다.") {
											alert('결제가 완료되었습니다.');
											var result = {
												"payNum": rsp.merchant_uid, // 결제번호
												"impUid": rsp.imp_uid, // 포트원 거래 ID
												"memberIdx": "${sessionScope.member.memberIdx}", // 회원번호
												"paymethod": rsp.pay_method, // 결제수단
												"payproduct": rsp.name, // 호텔 이름 + 상품이름
												"payprice": rsp.paid_amount, // 결제금액
												"guestName": rsp.buyer_name, // 투숙객 이름
												"phone": rsp.buyer_tel, // 전화번호
												"paydate": new Date().toISOString(), // 결제시간
												"payperiod": payperiod, // 상품이용기간
												"firstName": firstName, // 이름
												"lastName": lastName, // 성
												"ask": requestMemo // 요청사항
											}

											console.log(result);

											$.ajax({
												url: 'payment/save',
												type: 'POST',
												contentType: 'application/json',
												data: JSON.stringify(result),
												success: function(saveRes) {
													console.log("결제정보 저장완료");
													window.location.href = 'paidOrder.do?payNum=' + saveRes;
												},
												error: function(err) {
													console.log(err);
													alert('결제 정보 저장 중 오류가 발생했습니다.');
												}
											});

										} else {
											alert('결제 검증에 실패했습니다.');
										}
									},
									error: function(err) {
										console.log(err);
										alert('결제 검증 중 오류가 발생했습니다.');
									}
								});
							} else {
								var msg = '결제 실패';
								msg += '\n에러내용 : ' + rsp.error_msg;
								alert(msg);
							}
						});
					} else {
						alert("결제 사전검증에 실패했습니다.");
					}
				},
				error: function(err) {
					console.log(err);
					alert("결제 사전검증 중 오류가 발생했습니다.");
				}
			});
		}

		function createOrderNum() {
			const date = new Date();
			const year = date.getFullYear();
			const month = String(date.getMonth() + 1).padStart(2, "0");
			const day = String(date.getDate()).padStart(2, "0");

			let orderNum = year + month + day;
			for (let i = 0; i < 5; i++) {
				orderNum += Math.floor(Math.random() * 10);
			}
			return orderNum;
		}

		function setDayNames() {
			const checkinDate = $("#checkin").text();
			const checkoutDate = $("#checkout").text();
			$("#checkin").html(checkinDate + "<br>(" + getDayName(checkinDate) + ")");
			$("#checkout").html(checkoutDate + "<br>(" + getDayName(checkoutDate) + ")");
		}

		function getDayName(dateString) {
			const date = new Date(dateString);
			const days = ['일', '월', '화', '수', '목', '금', '토'];
			return days[date.getDay()];
		}
	</script>
</body>
</html>

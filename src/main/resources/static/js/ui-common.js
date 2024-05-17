// 로그인
$(function() {
	$('#header .inner #show')
		.on('mouseenter', function() {
			$('#header .inner #show').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .inner #show').removeClass('on');
		});

	$('#header .profile_wrap .user_btn').on('click', function() {
		$('#header .profile_wrap .my_account_box').toggleClass('on');
	});
});

// 검색 버튼
$(function() {
	$('#container .searchwrap .searchbox .inner .search .condition .city')
		.on('mouseenter', function() {
			$(
				'#container .searchwrap .searchbox .inner .search .condition .city'
			).addClass('on');
		})
		.on('mouseleave', function() {
			$(
				'#container .searchwrap .searchbox .inner .search .condition .city'
			).removeClass('on');
		});
	$('#container .searchwrap .inner .search .condition .checkin')
		.on('mouseenter', function() {
			$('#container .searchwrap .inner .search .condition .checkin').addClass(
				'on'
			);
		})
		.on('mouseleave', function() {
			$(
				'#container .searchwrap .inner .search .condition .checkin'
			).removeClass('on');
		});
	$('#container .searchwrap .inner .search .condition .checkout')
		.on('mouseenter', function() {
			$('#container .searchwrap .inner .search .condition .checkout').addClass(
				'on'
			);
		})
		.on('mouseleave', function() {
			$(
				'#container .searchwrap .inner .search .condition .checkout'
			).removeClass('on');
		});
	$('#container .searchwrap .inner .search .condition .person')
		.on('mouseenter', function() {
			$('#container .searchwrap .inner .search .condition .person').addClass(
				'on'
			);
		})
		.on('mouseleave', function() {
			$('#container .searchwrap .inner .search .condition .person').removeClass(
				'on'
			);
		});
	$('#container .searchwrap .inner .search .condition .buttonwrap')
		.on('mouseenter', function() {
			$(
				'#container .searchwrap .inner .search .condition .buttonwrap'
			).addClass('on');
		})
		.on('mouseleave', function() {
			$(
				'#container .searchwrap .inner .search .condition .buttonwrap'
			).removeClass('on');
		});
});

// 모두 보기
$(function() {
	$('#container .event .inner .titlewrap button')
		.on('mouseenter', function() {
			$('#container .event .inner .titlewrap button').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .event .inner .titlewrap button').removeClass('on');
		});
	$('#container .notice .inner .titlewrap button')
		.on('mouseenter', function() {
			$('#container .notice .inner .titlewrap button').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .notice .inner .titlewrap button').removeClass('on');
		});
});

// 이메일 인증
var globalEmail = "";

$(document).ready(function() {

	// 전역 변수로 이메일을 선언
	var email = "";

	$("#continue").click(function() {
		sendNumber();
	});

	//이메일 입력 메서드
	function sendNumber() {
		var email = $("#mail").val();
		var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

		if (email === "") {
			alert("이메일 주소를 입력해주세요.");
		} else if (!emailPattern.test(email)) {
			alert("유효한 이메일 주소를 입력해주세요.");
		} else {
			$('#emailValue').html(email);

			globalEmail = email;

			$.ajax({
				url: "/emailSend.do",
				type: "post",
				dataType: "json",
				data: {
					"mail": email
				},
				success: function(response) {
					console.log("이메일이 발송되었습니다.", response);
					continuous()
				},
				error: function(xhr, status, error) {
					console.error("이메일 발송이 실패했습니다:", error);
				}
			});
		};
	}

	//인증번호 입력 및 전송
	var inputs = $('.numberInput');
	var concatenatedNumber = '';

	$('.numberInput').on('input', function(e) {
		var input = $(this).val().trim();
		var length = input.length;
		if (length > 1) {
			$(this).val(input.slice(0, 1));
		}

		if (!/^\d$/.test(input)) {
			$(this).val('');
			return;
		}

		if (length === 1 && $(this).next('.numberInput').length > 0) {
			$(this).next('.numberInput').focus();
		}

		if (inputs.filter(function() { return $(this).val() == ''; }).length == 0) {
			concatenatedNumber = '';
			inputs.each(function() {
				concatenatedNumber += $(this).val();
			});
			console.log('Concatenated number:', concatenatedNumber);
			sendConcatenatedNumberToServer(concatenatedNumber);
		} else {
			concatenatedNumber = '';
		}
	});

	$('.numberInput').keydown(function(e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode === 8 && $(this).val() === '') {
			$(this).prev('.numberInput').focus();
		}
	});

	$('.numberInput').on('paste', function(e) {
		var pastedText = (e.originalEvent || e).clipboardData.getData('text/plain');
		var numbersOnly = pastedText.replace(/\D/g, '');
		var inputs = $(this).closest('form').find('.numberInput');
		var currentInput = $(this);
		var concatenatedNumber = '';

		for (var i = 0; i < numbersOnly.length && currentInput.length > 0; i++) {
			currentInput.val(numbersOnly[i]);
			concatenatedNumber += numbersOnly[i];
			currentInput = currentInput.next('.numberInput');
		}

		console.log('Concatenated number:', concatenatedNumber);
		sendConcatenatedNumberToServer(concatenatedNumber);
		return false;
	});

	//전송 메서드
	function sendConcatenatedNumberToServer(concatenatedNumber) {

		$.ajax({
			url: '/confirmEmail.do',
			method: 'POST',
			data: {
				"email": globalEmail,
				"certNum": concatenatedNumber,
			},
			success: function(response, textStatus, xhr) {
				window.location.href = "/";
			},
			error: function(xhr) {
				var errorMessage = xhr.responseJSON && xhr.responseJSON.message ?
					xhr.responseJSON.message : "An unknown error occurred.";
				$("#error_message").text(errorMessage).show();
			}

		});
	}


});

//네이버 팝업
function NaverPopup() {
	var url = "/naver-login";
	window.open(url, 'NaverLogin', "width=450, height=600");
}






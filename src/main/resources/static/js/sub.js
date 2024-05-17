// 로그인
$(function() {
	$('#header .inner #show')
		.on('mouseenter', function() {
			$('#header .inner #show').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .inner #show').removeClass('on');
		});
});

// 헤더 검색 버튼
$(function() {
	$('#header .search .condition .city')
		.on('mouseenter', function() {
			$('#header .search .condition .city').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .search .condition .city').removeClass('on');
		});

	$('#header .search .condition .checkin')
		.on('mouseenter', function() {
			$('#header .search .condition .checkin').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .search .condition .checkin').removeClass('on');
		});

	$('#header .search .condition .checkout')
		.on('mouseenter', function() {
			$('#header .search .condition .checkout').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .search .condition .checkout').removeClass('on');
		});

	$('#header .search .condition .person')
		.on('mouseenter', function() {
			$('#header .search .condition .person').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .search .condition .person').removeClass('on');
		});

	$('#header .search .condition .buttonwrap')
		.on('mouseenter', function() {
			$('#header .search .condition .buttonwrap').addClass('on');
		})
		.on('mouseleave', function() {
			$('#header .search .condition .buttonwrap').removeClass('on');
		});
});

//	search_page 시작-----------------------
// 2단 헤더 검색 버튼
$(function() {
	$(".search_page [class*='filter_group'] > button").on('click', function() {
		$(this).siblings().toggleClass('on').parent().siblings().find('[class*=filter_wrap]')
			.removeClass('on');
			
			$('.search_page .sort_list').removeClass('on');
	});

	$('#container .filter_wrap .inner .price_filter')
		.on('mouseenter', function() {
			$('#container .filter_wrap .inner .price_filter').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .filter_wrap .inner .price_filter').removeClass('on');
		});
	$('#container .filter_wrap .inner .review_filter')
		.on('mouseenter', function() {
			$('#container .filter_wrap .inner .review_filter').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .filter_wrap .inner .review_filter').removeClass('on');
		});
	$('#container .filter_wrap .inner .grade_filter')
		.on('mouseenter', function() {
			$('#container .filter_wrap .inner .grade_filter').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .filter_wrap .inner .grade_filter').removeClass('on');
		});
	$('#container .filter_wrap .inner .site_filter')
		.on('mouseenter', function() {
			$('#container .filter_wrap .inner .site_filter').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .filter_wrap .inner .site_filter').removeClass('on');
		});
	$('#container .filter_wrap .inner .map')
		.on('mouseenter', function() {
			$('#container .filter_wrap .inner .map').addClass('on');
		})
		.on('mouseleave', function() {
			$('#container .filter_wrap .inner .map').removeClass('on');
		});
		
  $('#container .filter_wrap .inner .map')
    .on('click', function () {
      $('#container .divide .map').addClass('on');
    })
    .on('click', function () {
      $('#container .divide .nomap').addClass('on');
    });
  $('#container .divide .map button')
    .on('click', function () {
      $('#container .divide .map').removeClass('on');
    })
    .on('click', function () {
      $('#container .divide .nomap').removeClass('on');
    });
});

$(function() {
	
	// 검색 정렬 기준 열기/닫기
	$('.search_page .sort_btn').on('click', function() {
		$('.search_page .sort_list').toggleClass('on');
		
		$('.search_page [class*="filter_group"] [class*="filter_wrap"]').removeClass('on');
	});
	
	/* 후기 평점 탭 */
	$('.search_page .review_filter_wrap .review_btn').on('click', function() {
	    if ( $(this).hasClass('all') === true ) {
	      $(this).addClass('active').siblings().removeClass('active');
	    }
	    else if ( $(this).hasClass('normal') === true ) {
	      $(this).addClass('active').prev().removeClass('active').nextAll().addClass('active');
	    }
	    else if ( $(this).hasClass('good') === true ) {
	      $(this).addClass('active').prevAll().removeClass('active');
	      $(this).nextAll().addClass('active');
	    }
	    else if ( $(this).hasClass('very_good') === true ) {
	      $(this).addClass('active').prevAll().removeClass('active');
	      $(this).nextAll().addClass('active');
	    }
	    else if ( $(this).hasClass('great') === true ) {
	      $(this).addClass('active').prevAll().removeClass('active');
	    }
  	});
  	
  	$('.search_page .apply_btn').on('click', function () {
		$('.search_page [class*="filter_group"] [class*="filter_wrap"]').removeClass('on');
	});

	$('.search_page .sort_list a').on('click', function(e) {
		e.preventDefault();

		// 텍스트 값 변경
		$('.search_page .sort_btn').text($(this).text());
		// 메뉴 닫기
		$('.search_page .sort_list').removeClass('on');
	});
	
	$('.search_page .pagination .num_btn').on('click', function () {
		$(this).addClass('active').siblings().removeClass('active');
	});

	// search_page 끝--------

	// hotel_view_page 시작 --------
	$('.hotel_view_page .tab_menu li').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('active').siblings().removeClass('active');
	});

	$('.hotel_view_page .info_top .right .btn_wrap .wish_btn').on(
		'click',
		function(e) {
			e.preventDefault();
			$(this).toggleClass('active');
		}
	);

	// 스크롤 방향 판단으로 tab_menu 변경
	var prevSt = 0;

	$(window)
		.on('scroll', function() {
			var nextSt = $(this).scrollTop();

			if (prevSt < nextSt) {
				$('.hotel_view_page .tab_menu').addClass('hidden');
				$('.room_page .tab_menu').addClass('hidden');
			} else {
				$('.hotel_view_page .tab_menu').removeClass('hidden');
				$('.room_page .tab_menu').removeClass('hidden');
			}

			prevSt = nextSt;
		})
		.trigger('scroll');

	// hotel_view_page 끝 --------

	// mypage 시작-----------

	// 탭 메뉴
	$('.mypage .tab_menu li').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('active').siblings().removeClass('active');

		var idx = $(this).index();

		$('.mypage .contents').eq(idx).addClass('active').siblings().removeClass('active');
	});

	// 개인 정보 탭 메뉴
	$('.mypage .personal_tab_menu li').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('active').siblings().removeClass('active');

		var idx = $(this).index();

		$('.mypage .personnal_contents .tab_wrap').eq(idx).addClass('active').siblings().removeClass('active');
	});
	// 여행 정보 탭 메뉴
	$('.mypage .trip_tab_menu li').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('active').siblings().removeClass('active');

		var idx = $(this).index();

		$('.mypage .trip_contents .tab_wrap').eq(idx).addClass('active').siblings().removeClass('active');
	});

	// 국가 선택 메뉴 열고 닫기
	$('.mypage .country_select .select_btn').on('click', function() {
		$(this).siblings().toggleClass('on');
	});

	$('.mypage .country_select .select_list .select_item').on('click', function() {
		$('.mypage .country_select .select_btn').text($(this).text());

		$('.mypage .country_select .select_list').removeClass('on');
	});

	$('.mypage .connection_wrap .con_btn').text('연결');
	$('.mypage .connection_wrap .con_btn.active').text('연결 완료');

	// 마이페이지 모달
	$('.mypage .my_info_wrap .user_profile').on('click', function() {
		$('.mypage .modal_1').fadeIn();
		$('.mypage .modal_bg').fadeIn();

		// body 스크롤 방지
		$('body').css({ 'overflow': 'hidden', 'height': '100%' });

		$('.mypage .modal_1 .upload_btn').on('click', function() {
			$('.mypage .modal_1').css({ 'display': 'none' }).next().css({ 'display': 'block' });
		});
	});

	$('.mypage .modal_2 .back_btn').on('click', function() {
		$('.mypage .modal_2').css({ 'display': 'none' }).prev().css({ 'display': 'block' });
	});

	// 모달 닫기
	$('.mypage .modal_box .close_btn').on('click', function() {
		$('.mypage .modal_box').fadeOut();
		$('.mypage .modal_bg').fadeOut();

		// body 스크롤 방지 해제
		$('body').css({ 'overflow': 'auto', 'height': '100%' });
	});

	// mypage 끝--------

	// event_page 시작----

	var hotelSlider = new Swiper('.event_page .swiper-container', {
		loop: true,
		slidesPerView: 3,
		spaceBetween: 15,
		spped: 1000,
		autoplay: {
			delay: 6000,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
	});

	// 이벤트 페이지 탭 메뉴
	$('.event_page .quick_menu li').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('active').siblings().removeClass('active');
	});

	// 스크롤 시 탭 메뉴 고정
	$(window)
		.scroll(function() {
			var st = $(document).scrollTop();

			if (st >= 2500) {
				$('.event_page .quick_menu').addClass('fixed');
			} else {
				$('.event_page .quick_menu').removeClass('fixed');
			}
		})
		.trigger('scroll');

	// room_page 시작-------------------

	// 객실 옵션 상세 모달
	$('.room_page .q_btn').on('click', function() {
		$('.room_page .option_modal').fadeIn();
		$('.room_page .option_modal_bg').fadeIn();

		// body 스크롤 방지
		$('body').css({ 'overflow': 'hidden', 'height': '100%' });
	});

	// 모달 닫기
	$('.room_page .option_modal .close_btn').on('click', function() {
		$('.room_page .option_modal').fadeOut();
		$('.room_page .option_modal_bg').fadeOut();

		// body 스크롤 방지 해제
		$('body').css({ 'overflow': 'auto', 'height': '100%' });
	});

	$('.room_page .tab_menu li').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('active').siblings().removeClass('active');
	});

	// room_page 끝------------------------

	// admin_page  시작----------------------
	
	  $('.admin_page .snb li').on('click', function () {
	    $(this).addClass('active').siblings().removeClass('active');
	    
	    $('.admin_page .member_wrap .filter_wrap .filter_btn').text($('.m_basic_op').text());
	    $('.admin_page .reserve_wrap .filter_wrap .filter_btn').text($('.r_basic_op').text());
	    $('.admin_page .hotel_wrap .filter_wrap .filter_btn').text($('.h_basic_op').text());
	
	    var idx = $(this).index();
	
	    $('.admin_page .contents').eq(idx).addClass('active').siblings().removeClass('active');
	  });
	
	  $('.admin_page .filter_btn').on('click', function () {
	    $(this).next().toggleClass('on');
	  });
	
	  $('.admin_page .filter_wrap .filter_list li').on('click', function () {
	    $('.admin_page .filter_btn').text($(this).text());
	
	    $('.admin_page .filter_btn').next().removeClass('on');
	  });

	
	// admin_page 끝--------------------------
	
	// payment_page 시작--------------
	
	// payment_page 전화번호 입력칸 focus 이벤트
	  $('.payment_page .user_info .phone_wrap select, .payment_page .user_info .phone_wrap input').on('focus', function () {
	    $(this).parent().css({'outline': '2px solid #000'});
	  }).on('focusout', function () {
	    $(this).parent().css({'outline': 'none'});
	  });
	  
	  $('.payment_page .country_select .select_btn').on('click', function() {
		$(this).siblings().toggleClass('on');
	});

	$('.payment_page .country_select .select_list .select_item').on('click', function() {
		$('.payment_page .country_select .select_btn').text($(this).text());

		$('.payment_page .country_select .select_list').removeClass('on');
	});
	  
	// payment_page 끝---------------------------
});


// 상세페이지 스크롤 이동
function goToScroll(name) {
	var location = document.querySelector('.' + name).offsetTop;

	window.scrollTo({ top: location - 140, behavior: 'smooth' });
}

// admin_page 새창열림
function memberOpen () {
  window.open('/memberDetail.do', '_blank', 'width=1280, height=800'); 
  return false;
}
function hotelOpen () {
  window.open('hotel_detail.html', '_blank', 'width=1280, height=800'); 
  return false;
}

// payment_page 전화번호 띄어쓰기
function oninputPhone(target) {
  target.value = target.value
      .replace(/[^0-9]/g, '')
      .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1 $2 $3`);
}

// admin_page 전화번호
function oninputPhoneDash(target) {
  target.value = target.value
      .replace(/[^0-9]/g, '')
      .replace(/^(\d{2})(\d{4})(\d{4})$/, `$1-$2-$3`);
}


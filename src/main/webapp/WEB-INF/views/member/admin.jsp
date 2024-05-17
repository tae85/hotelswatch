<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/common.css?v=<?php echo time(); ?>">
  <link rel="stylesheet" href="css/main.css?v=<?php echo time(); ?>" />
  <link rel="stylesheet" href="css/admin.css?v=<?php echo time(); ?>">
  <link rel="stylesheet" href="css/jquery-ui.min.css" />
  <link rel="stylesheet" href="css/swiper.min.css" />
  <script src="js/jquery-3.7.1.min.js"></script>
  <script src="js/jquery-ui.min.js"></script>
  <script src="js/swiper.min.js"></script>
  <script src="js/ui-common.js"></script>
  <script src="js/sub.js"></script>
  <title>관리자</title>
</head>
<body>
  <div id="wrap" class="admin_page">
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
    <nav class="snb_wrap">
      <ul class="snb">
        <li class="active"><a href="#">회원</a></li>
        <li><a href="#">예약</a></li>
        <li><a href="#">호텔</a></li>
      </ul>
    </nav>
    <main id="container" class="sub_container">
      <div class="member_wrap contents active">
        <div class="inner">
          <h2 class="admin_tit">회원 관리</h2>
          <div class="member_top">
            <form class="search_wrap">
              <div class="filter_wrap">
                <button type="button" class="filter_btn">이름</button>
                <ul class="filter_list">
                  <li class="item m_basic_op">이름</li>
                  <li class="item">닉네임</li>
                  <li class="item">전화번호</li>
                  <li class="item">이메일</li>
                </ul>
              </div>
              <input type="text" class="search_field" />
              <button type="submit" class="search_btn"><span class="blind">검색</span></button>
            </form>
            <button type="button" class="add_btn">멤버 추가</button>
          </div>
          <table class="member_list">
            <thead>
              <tr>
                <th width="10%">No</th>
                <th width="10%">이름</th>
                <th width="10%">닉네임</th>
                <th width="10%">생년월일</th>
                <th width="15%">전화번호</th>
                <th width="15%">이메일</th>
                <th width="15%">SNS(구글)</th>
                <th width="15%">SNS(네이버)</th>
                <th width="15%">SNS(애플)</th>
                <th width="10%">가입일</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>2</td>
                <td><a href="#" onclick="memberOpen()">호랑이</a></td>
                <td>마늘을좋아해</td>
                <td>1000-12-31</td>
                <td>010-0000-0000</td>
                <td>tiger@naver.com</td>
                <td>-</td>
                <td>tiger@naver.com</td>
                <td>-</td>
                <td>2024-05-12</td>
              </tr>
              <tr>
                <td>1</td>
                <td><a href="#" onclick="memberOpen()">거북이</a></td>
                <td>달리기킹왕짱</td>
                <td>999-01-01</td>
                <td>010-1111-1111</td>
                <td>turtleking@gmail.com</td>
                <td>turtleking@gmail.com</td>
                <td>-</td>
                <td>-</td>
                <td>2024-05-01</td>
              </tr>
            </tbody>
          </table>
          <div class="paging">
            <button type="button" class="prev_btn paging_btn">이전</button>
            <button type="button" class="paging_btn active">1</button>
            <button type="button" class="paging_btn">2</button>
            <button type="button" class="paging_btn">3</button>
            <button type="button" class="paging_btn">4</button>
            <button type="button" class="paging_btn">5</button>
            <button type="button" class="next_btn paging_btn">다음</button>
          </div>
        </div>
      </div>
      <div class="reserve_wrap contents">
        <div class="inner">
          <h2 class="admin_tit">예약 관리</h2>
          <div class="member_top">
            <form class="search_wrap">
              <div class="filter_wrap">
                <button type="button" class="filter_btn">이름</button>
                <ul class="filter_list">
                  <li class="item r_basic_op">이름</li>
                  <li class="item">닉네임</li>
                  <li class="item">전화번호</li>
                  <li class="item">호텔</li>
                </ul>
              </div>
              <input type="text" class="search_field" />
              <button type="submit" class="search_btn"><span class="blind">검색</span></button>
            </form>
          </div>
          <table class="member_list">
            <thead>
              <tr>
                <th width="10%">No</th>
                <th width="10%">이름</th>
                <th width="10%">닉네임</th>
                <th width="10%">생년월일</th>
                <th width="15%">전화번호</th>
                <th width="15%">이메일</th>
                <th width="15%">호텔</th>
                <th width="15%">예약일</th>
                <th width="10%">체크인</th>
                <th width="10%">체크아웃</th>
                <th width="10%">결제</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>4</td>
                <td><a href="#" onclick="memberOpen()">돈키호테</a></td>
                <td>방랑기사</td>
                <td>1605-05-05</td>
                <td>010-9999-9999</td>
                <td>donquixote@gmail.com</td>
                <td><a href="#" onclick="hotelOpen()">시그니엘 부산</a></td>
                <td>2024-04-30</td>
                <td>2024-05-22</td>
                <td>2024-05-23</td>
                <td>N</td>
              </tr>
              <tr>
                <td>3</td>
                <td><a href="#" onclick="memberOpen()">호랑이</a></td>
                <td>마늘을좋아해</td>
                <td>1000-12-31</td>
                <td>010-0000-0000</td>
                <td>tiger@naver.com</td>
                <td><a href="#" onclick="hotelOpen()">조선 주막</a></td>
                <td>2024-04-20</td>
                <td>2024-05-01</td>
                <td>2024-05-03</td>
                <td>Y</td>
              </tr>
              <tr>
                <td>2</td>
                <td><a href="#" onclick="memberOpen()">파랑새</a></td>
                <td>보석상</td>
                <td>1010-07-07</td>
                <td>010-3333-3333</td>
                <td>bluebird@naver.com</td>
                <td><a href="#" onclick="hotelOpen()">나무둥지</a></td>
                <td>2024-04-17</td>
                <td>2024-05-03</td>
                <td>2024-05-05</td>
                <td>Y</td>
              </tr>
              <tr>
                <td>1</td>
                <td><a href="#" onclick="memberOpen()">토토</a></td>
                <td>로또1등기원</td>
                <td>777-07-07</td>
                <td>010-7777-7777</td>
                <td>jebal@gamil.com</td>
                <td><a href="#" onclick="hotelOpen()">서울 콘레드 호텔</a></td>
                <td>2024-03-30</td>
                <td>2024-07-07</td>
                <td>2024-07-07</td>
                <td>Y</td>
              </tr>
            </tbody>
          </table>
          <div class="paging">
            <button type="button" class="prev_btn paging_btn">이전</button>
            <button type="button" class="paging_btn active">1</button>
            <button type="button" class="paging_btn">2</button>
            <button type="button" class="paging_btn">3</button>
            <button type="button" class="paging_btn">4</button>
            <button type="button" class="paging_btn">5</button>
            <button type="button" class="next_btn paging_btn">다음</button>
          </div>
        </div>
      </div>
      <div class="hotel_wrap contents">
        <div class="inner">
          <h2 class="admin_tit">호텔 관리</h2>
          <div class="member_top">
            <form class="search_wrap">
              <div class="filter_wrap">
                <button type="button" class="filter_btn">호텔명</button>
                <ul class="filter_list">
                  <li class="item h_basic_op">호텔명</li>
                  <li class="item">주소</li>
                </ul>
              </div>
              <input type="text" class="search_field" />
              <button type="submit" class="search_btn"><span class="blind">검색</span></button>
            </form>
            <button type="button" class="add_btn">호텔 추가</button>
          </div>
          <table class="member_list">
            <thead>
              <tr>
                <th width="10%">No</th>
                <th width="30%">호텔명</th>
                <th width="25%">주소</th>
                <th width="10%">전화번호</th>
                <th width="5%">스탠다드룸</th>
                <th width="5%">디럭스룸</th>
                <th width="5%">슈페리어룸</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>3</td>
                <td><a href="#" onclick="hotelOpen()">서울신라호텔</a></td>
                <td>서울 종로구 동호로</td>
                <td>02-123-4567</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
              </tr>
              <tr>
                <td>2</td>
                <td><a href="#" onclick="hotelOpen()">그랜드 인터컨티넨탈 서울 피트니스</a></td>
                <td>서울시 강남구 테헤란로</td>
                <td>02-123-4567</td>
                <td>6</td>
                <td>7</td>
                <td>8</td>
              </tr>
              <tr>
                <td>1</td>
                <td><a href="#" onclick="hotelOpen()">그랜드 워커힐 서울</a></td>
                <td>서울시 광진구 워커힐로</td>
                <td>02-123-4567</td>
                <td>10</td>
                <td>20</td>
                <td>30</td>
              </tr>
            </tbody>
          </table>
          <div class="paging">
            <button type="button" class="prev_btn paging_btn">이전</button>
            <button type="button" class="paging_btn active">1</button>
            <button type="button" class="paging_btn">2</button>
            <button type="button" class="paging_btn">3</button>
            <button type="button" class="paging_btn">4</button>
            <button type="button" class="paging_btn">5</button>
            <button type="button" class="next_btn paging_btn">다음</button>
          </div>
        </div>
      </div>
    </main>
  </div>
</body>
</html>
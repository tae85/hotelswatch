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
  <link rel="stylesheet" href="css/admin.css?v=<?php echo time(); ?>">
  <link rel="stylesheet" href="css/jquery-ui.min.css" />
  <link rel="stylesheet" href="css/swiper.min.css" />
  <script src="js/jquery-3.7.1.min.js"></script>
  <script src="js/jquery-ui.min.js"></script>
  <script src="js/swiper.min.js"></script>
  <script src="js/sub.js"></script>
  <title>관리자</title>
</head>
<body>
  <div id="wrap" class="member_detail_page">
    <main id="container" class="sub_container">
      <div class="inner">
        <div class="member_info">
          <div class="info_top">
            <div class="top">
              <img src="images/ebanner06.png" alt="프로필사진" class="profile_img" />
              <table class="info_tb">
                <tr>
                  <th scope="col">이름</th>
                  <td>
                    <input type="text" value="호랑이" readonly />
                  </td>
                </tr>
                <tr>
                  <th scope="col">닉네임</th>
                  <td>
                    <input type="text" value="마늘을좋아해" readonly />
                  </td>
                </tr>
                <tr>
                  <th scope="col">생년월일</th>
                  <td>1000-12-31</td>
                </tr>
                <tr>
                  <th scope="col">가입일</th>
                  <td>2024-05-12</td>
                </tr>
                <tr>
                  <th scope="col">관리자</th>
                  <td>
                    <form>
                      <input type="radio" name="admin" value="basic_user" id="basic_user" checked onclick="return false" />
                      <label for="basic_user">일반회원</label>
                      <input type="radio" name="admin" value="admin_user" id="admin_user" onclick="return false" />
                      <label for="admin_user">관리자</label>
                    </form>
                  </td>
                </tr>
              </table>
              <div class="btn_wrap">
                <button type="button" class="edit_btn">멤버 수정</button>
                <button type="button" class="del_btn">멤버 삭제</button>
              </div>
            </div>
            <div class="bottom">
              <table class="acc_tb">
                <tr>
                  <th scope="col">이메일</th>
                  <td>
                    <input type="text" value="tiger@naver.com" readonly />
                  </td>
                </tr>
                <tr>
                  <th scope="col">SNS(구글)</th>
                  <td>
                    <input type="text" value="-" readonly />
                  </td>
                </tr>
                <tr>
                  <th scope="col">SNS(네이버)</th>
                  <td>
                    <input type="text" value="tiger@naver.com" readonly />
                  </td>
                </tr>
                <tr>
                  <th scope="col">SNS(애플)</th>
                  <td>
                    <input type="text" value="-" readonly />
                  </td>
                </tr>
              </table>
            </div>
            <button type="button" class="save_btn">저장</button>
          </div>
          <div class="info_bottom">
            <table class="reserve_tb">
              <thead>
                <tr>
                  <th>No</th>
                  <th>예약일</th>
                  <th>호텔명</th>
                  <th>체크인</th>
                  <th>체크아웃</th>
                  <th>결제</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>3</td>
                  <td>2024-05-21</td>
                  <td>콘레드 서울 호텔</td>
                  <td>2024-05-23</td>
                  <td>2024-05-27</td>
                  <td>Y</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>2024-04-21</td>
                  <td>콘레드 서울 호텔</td>
                  <td>2024-04-23</td>
                  <td>2024-04-27</td>
                  <td>Y</td>
                </tr>
                <tr>
                  <td>1</td>
                  <td>2024-03-21</td>
                  <td>콘레드 서울 호텔</td>
                  <td>2024-03-23</td>
                  <td>2024-03-27</td>
                  <td>Y</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
</body>
</html>
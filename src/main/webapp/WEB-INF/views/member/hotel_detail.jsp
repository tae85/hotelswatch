<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div id="wrap" class="hotel_detail_page">
    <main id="container" class="sub_container">
      <div class="inner">
        <div class="hotel_info">
          <img src="images/ebanner04.png" alt="호텔사진" />
          <table class="hotel_tb">
            <tr>
              <th scope="col">호텔명</th>
              <td>
                <input type="text" value="서울 신라 호텔" readonly />
              </td>
            </tr>
            <tr>
              <th scope="col">나라</th>
              <td>
                <input type="text" value="대한민국" readonly />
              </td>
            </tr>
            <tr>
              <th scope="col">도시</th>
              <td>
                <input type="text" value="서울시" readonly />
              </td>
            </tr>
            <tr>
              <th scope="col">구</th>
              <td>
                <input type="text" value="중구" readonly />
              </td>
            </tr>
            <tr>
              <th scope="col">스트릿</th>
              <td>
                <input type="text" value="동호로" readonly />
              </td>
            </tr>
            <tr>
              <th scope="col">전화번호</th>
              <td>
                <input type="text" value="02-1234-5678" readonly oninput="oninputPhoneDash(this)" maxlength="13" id="phoneNumber" />
              </td>
            </tr>
            <tr>
              <th scope="col">이메일</th>
              <td>
                <input type="text" value="theshillaseoul@hotel.com" readonly />
              </td>
            </tr>
          </table>
          <div class="btn_wrap">
            <button type="button" class="add_btn">객실 추가</button>
            <button type="button" class="edit_btn">정보 수정</button>
          </div>
        </div>
        <div class="room_info">
          <strong>Room Type</strong>
          <div class="standard room">
            <img src="images/s4.jpg" alt="스탠다드룸" />
            <table class="room_tb">
              <tr>
                <th scope="col">객실타입</th>
                <td>
                  <input type="text" value="스탠다드룸" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">기준인원</th>
                <td>
                  <input type="text" value="2" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">갯수</th>
                <td>
                  <input type="text" value="3" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">가격</th>
                <td>
                  <input type="text" value="100,000" readonly />
                </td>
              </tr>
            </table>
            <button type="button" class="del_btn">객실 삭제</button>
          </div>
          <div class="deluxe room">
            <img src="images/s4.jpg" alt="디럭스룸" />
            <table class="room_tb">
              <tr>
                <th scope="col">객실타입</th>
                <td>
                  <input type="text" value="디럭스룸" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">기준인원</th>
                <td>
                  <input type="text" value="3" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">갯수</th>
                <td>
                  <input type="text" value="4" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">가격</th>
                <td>
                  <input type="text" value="200,000" readonly />
                </td>
              </tr>
            </table>
            <button type="button" class="del_btn">객실 삭제</button>
          </div>
          <div class="superior room">
            <img src="images/s4.jpg" alt="슈페리어룸" />
            <table class="room_tb">
              <tr>
                <th scope="col">객실타입</th>
                <td>
                  <input type="text" value="슈페리어룸" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">기준인원</th>
                <td>
                  <input type="text" value="4" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">갯수</th>
                <td>
                  <input type="text" value="5" readonly />
                </td>
              </tr>
              <tr>
                <th scope="col">가격</th>
                <td>
                  <input type="text" value="300,000" readonly />
                </td>
              </tr>
            </table>
            <button type="button" class="del_btn">객실 삭제</button>
          </div>
        </div>
        <div class="btn_wrap">
          <button type="button" class="save_btn">저장하기</button>
          <button type="button" class="back_btn">돌아가기</button>
        </div>
      </div>
    </main>
  </div>
</body>
</html>
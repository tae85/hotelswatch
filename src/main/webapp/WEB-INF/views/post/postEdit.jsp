<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정</title>
<script>
function validateForm(f) {
	if(f.title.value == '') {
		alert("제목을 입력해주세요.");
		f.title.focus();
		return false;
	}
	if(f.content.value == '') {
		alert("내용을 입력해주세요.");
		f.content.focus();
		return false;
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
	
	<h2>게시판 수정(Mybatis)</h2>
	<form name="postEditFrm" method="post"
		action="./postEdit.do" onsubmit="return validateForm(this);">
	<!-- 수정할 게시물의 일련번호를 전송해야 하므로 hidden 박스가 하나 필요하다. -->
	<input type="hid-den" name="post_idx" value="${postDTO.post_idx }" />
	<input type="hid-den" name="type" value="${postDTO.type }" />
	<table border="1" width="90%">
	    <tr>
	        <td>작성자</td>
	        <td>
	            <input type="text" name="name" style="width:150px;" 
	            	value="${postDTO.name }" readonly />
	        </td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td>
	            <input type="text" name="title" style="width:90%;" 
	            	value="${postDTO.title }"/>
	        </td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td>
	            <textarea name="content" style="width:90%;
	            	height:100px;">${postDTO.content }</textarea>
	        </td>
	    </tr>
	    <!-- <tr>
	        <td>비밀번호</td>
	        <td>
	            <input type="password" name="pass" style="width:100px;" />
	        </td>
	    </tr> -->
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">작성 완료</button>
	            <button type="reset">RESET</button>
	            <button type="button" 
	            	onclick="location.href='./postLists.do?route=${route}';">
	                목록 바로가기
	            </button>
	        </td>
	    </tr>
	</table>    
	</form>
</body>
</html>
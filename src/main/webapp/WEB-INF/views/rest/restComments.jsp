<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Rest API 만들어보기</h2>
	<style>
	fieldset{width:400px;}
	</style>
	
	<fieldset>
		<legend>idx 받기</legend>
		<form action="restIdx.do">
			<input type="submit" value="요청하기" />
		</form>
	</fieldset>
	
	<fieldset>
		<legend>호텔 후기 보기</legend>
		<form action="restCommentsList.do">
			일련번호 : <input type="number" name="hotel_idx" />
			<input type="submit" value="요청하기" />
		</form>
	</fieldset>
	
	<fieldset>
		<legend>[퀴즈]작성하기</legend>
		<form method="post" action="restCommentsWrite.do">
			호텔idx<input type="number" name="hotel_idx"/><br/>
			아이디:<input type="text" name="idx" /><br/>
			평점:<input type="number" name="grade" /><br/>
			내용: <textarea name="comments" cols="30" rows="10"></textarea><br/>
			<input type="submit" value="요청하기" />
		</form>
	</fieldset>
	
</body>
</html>

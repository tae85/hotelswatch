<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Multi File Upload</title>
</head>
<script>
function validateForm(form) {
	if(form.title.value=="") {
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
}
</script>
<body>
<h2>파일업로드</h2>
<form name="postWriteForm" method="post" enctype="multipart/form-data"
		action="postWriteProcess.do" onsubmit="return validateForm(this);">
	<input type="hidden" name="idx" value="2"></input><br/>
	<select name="type">
		<option value="e">이벤트</option>
		<option value="n">공지사항</option>
	</select><br/>
	제목 : <input type="text" name="title" /><br/>
	내용 : <input type="text" name="content" /><br/>
	썸네일 이미지 : <input type="file" name="fileList" /><br/>
	내용 이미지 : <input type="file" name="fileList" /><br/>
	<input type="submit" value="전송하기" />
</form>
</body>
</html>
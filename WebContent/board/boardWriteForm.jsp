<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>게시글 등록</title>
<script src="<%=request.getContextPath()%>/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<style type="text/css">
	* {font-size: 9pt;}
	p {width: 600px; text-align: right;}
	table tbody tr th {background-color: gray;}
</style>
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 등록 폼 체크
	function boardWriteCheck() {
		var form = document.boardWriteForm;
		if (form.subject.value == '') {
			alert('제목을 입력하세요.');
			form.subject.focus();
			return false;
		}
		

		if( $("#addFile").val() != "" ){
			var ext = $('#addFile').val().split('.').pop().toLowerCase();
		    if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				 alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				 return false;
		    }
		}
		
		return true;
		
		
	}
</script>
</head>
<body>
	<form name="boardWriteForm" action="boardProcess.jsp" method="post" onsubmit="return boardWriteCheck();" 
	enctype="multipart/form-data">
	
	<input type="hidden" name="mode" value="W" />
	<table border="1" summary="게시판 등록 폼">
		<caption>게시판 등록 폼</caption>
		<colgroup>
			<col width="100" />
			<col width="500" />
		</colgroup>
		<tbody>
			<tr>
				<th align="center">제목</th>
				<td><input type="text" name="subject" size="80" maxlength="100" /></td>
			</tr>
			<%--<tr>
				<th align="center">작성자</th>
				<td><input type="text" name="writer" maxlength="20" /></td>
			</tr> --%>
			<tr>
				<th align="center">첨부파일</th>
				<td><input type="file" name="addFile" id="addFile" maxlength="20" /></td>
			</tr>
			<tr>
				<th align="center">비밀글</th>
				<td>
					<input type="radio" name="isSecret" value="Y"></input>예
					<input type="radio" name="isSecret" value="N" checked="true"></input>아니오</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="contents" cols="80" rows="10"></textarea>
					<!-- <script>
					CKEDITOR.replace('contents');
					</script> -->
				</td>
			</tr>
		</tbody>
	</table>
	<p>
		<input type="button" value="목록" onclick="goUrl('boardList.jsp');" />
		<input type="submit" value="글쓰기" />
	</p>
	</form>
</body>
</html>



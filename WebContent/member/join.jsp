<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
//request.setCharacterEncoding("UTF-8");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<title>Insert title here</title>
<script>
function iddupleCheck(){
	$.ajax({
		type : "POST",
		url : "idDupleCheck.jsp",
		data : {
			userid : $("#userid").val()
		},
		success : function (response){
			console.log(response);
			if(response.trim() == 'Y'){
				alert('사용할 수 있는 아이디입니다.');
				$("#dupleCheck").val('Y');
			}else{
				alert('사용할 수 없는 아이디입니다. ');
				$("#dupleCheck").val('N');
			}
		}
	});
}

function goLogin(){
	location.href= "<%=request.getContextPath()%>" + "/index.jsp";
}

function doJoin(){
	// 값 체크 
	if($("#name").val() == ''){
		alert('이름을 입력해 주세요.');
		return ;
	}
	
	if($("#userid").val() == ''){
		alert('아이디를 입력해 주세요.');
		return ;
	}
	
	if($("#passwd").val() == ''){
		alert('비밀번호를 입력해 주세요.');
		return ;
	}
	
	if($("#dupleCheck").val() == 'N'){
		alert("아이디 중복 체크를 해주세요.");
		return ;
	}
	
	$("#joinForm").submit();
}

</script>
</head>
<body>
	<div style="margin:auto; width:500px">
		<h1>회원가입페이지 </h1>
		<form name="joinForm" id="joinForm" method="post" action="doJoin.jsp" >
			<input type="hidden" name="dupleCheck" id="dupleCheck" value="N" />
			이름 : <input type="text" name="name" id="name" value="" /> <br/> 
			아이디 : <input type="text" id="userid" name="userid" value="" /> 
				<input type="button" value="중복체크" onclick="javascript:iddupleCheck();" /><br/>
			비밀번호 : <input type="password" id="passwd" name="passwd" value="" /> <br/>
			<input type="button" value="가입" onclick="doJoin();" />
			<input type="button" value="로그인 화면으로" onclick="goLogin();" />
		</form>
	
	</div>
</body>
</html>

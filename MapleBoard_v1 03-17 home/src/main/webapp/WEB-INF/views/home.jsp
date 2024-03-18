<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="${cp}/resources/maplescript.js"></script>
	<title>Home</title>
</head>
<body>
<h1>
</h1>
<hr>
	<form>
	이름:<input type="text" id="name">
	<br>
	프리셋:<input type="text" id="preset">
	<br>
	<input type="button" id="maincontent" value="Click Me">
	</form>
	<div id="datas"></div>
<h1>
	<a href="${cp}/mapleboard/mapleapi?id=순두부찌게&preset=3">test api3</a>				
</h1>
	<script>
	  $(document).ready(function() {
	        $("#maincontent").click(function() {
	            var name = $("#name").val(); // 클릭 시에 입력한 이름을 가져옴
	            var preset = $("#preset").val(); // 클릭 시에 입력한 프리셋을 가져옴
	            $.ajax({ // 에이젝스를 불러옴
	                url: "${cp}/mapleboard/equip", //url 지정 (경로)컨트롤러 타게 해주는아이
	                method: "GET", //방식 겟방식으로
	                data: {id:name, preset:preset}, //파라미터값 지정
	                dataType: "html",//형식지정 html형식으로 할꺼야!
	                success: function(response) {
	                    $("#datas").html(response); // id="datas" << 여기에 값 넣어줘!
	                },
	                error: function(xhr, status, error) {
	                    console.error(error); //에러
	                }
	            });
	        });
	    });
	</script>
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
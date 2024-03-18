<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
정보 표시 기준날짜
<script>
let origindate = `${maple.date}`;
let returndate = origindate.substring(0, 10);
document.write(returndate);
</script>
<br>
<div>
닉네임:${maple.character_name}
</div>
<br>
레벨:${maple.character_level}
<br>
경험치:[${maple.character_exp_rate}]%
<br>
<hr>
기본스탯
<hr>
	<c:forEach var="statview" items="${stat}">
		${statview.stat_name}:
		${statview.stat_value}
		<br>
	</c:forEach>
	<hr>
	하이퍼스탯
	<hr>
	<c:forEach var="hyperview" items="${hyper}">
		${hyperview.stat_type}
		${hyperview.stat_point}
		${hyperview.stat_level}
		${hyperview.stat_increase}
		<br>
	</c:forEach>
	<hr>
	성향
	<br>
	카리스마:${propensity.charisma_level}
	<br>
	감성:${propensity.sensibility_level}
	<br>
	통찰력:${propensity.insight_level}
	<br>
	의지:${propensity.willingness_level}
	<br>
	손재주:${propensity.handicraft_level}
	<br>
	매력:${propensity.charm_level}
	<br>
	<c:forEach var="abilityview" items="${ability}">
		${abilityview.ability_preset_no}
		${abilityview.ability_preset_value}
		${abilityview.ability_preset_grade}
		<br>
	</c:forEach>
	<img src="${maple.character_image}" alt="캐릭터이미지">
</body>
</html>
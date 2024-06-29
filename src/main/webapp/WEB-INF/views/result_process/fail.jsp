<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert("${msg}");
	if("${isClose}" == "true"){
		window.opener.location.reload();
		window.close();
	}
	if("${targetURL}" == ""){
		history.back();
	} else{
		location.href="${targetURL}";
	}
	
// <c:choose>
// 	<c:when test="${empty targetURL}">
// 		history.back();
// 	</c:when>
// 	<c:otherwise>
// 		location.href="${targetURL}";
// 	</c:otherwise>
// </c:choose>

</script>




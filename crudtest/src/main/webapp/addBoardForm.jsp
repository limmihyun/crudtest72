<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시글추가</h1>
	<form action="<%=request.getContextPath()%>/addBoardAction.jsp">
		<table border="1">
			<tr>
				<th>글제목</th>
				<td>
					<input type="text" name = "boardTitle">
				</td>
			</tr>
			<tr>
				<th>글내용</th>
				<td>
					<input type="text" name = "boardContent">
				</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>
					<input type="text" name = "boardWriter">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="text" name = "boardpw">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">추가</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
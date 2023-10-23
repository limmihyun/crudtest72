<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="vo.Board" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	int beginRow = 0;
	int rowPerPage = 10;
	String sql = "SELECT board_no as boardNo, board_title as boardTitle, board_content as boardContent, board_writer as boardWriter, board_pw as boardpw, createdate,updatedate FROM board";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, rowPerPage);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Board> list = new ArrayList<Board>();
	while(rs.next()){
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.boardTitle = rs.getString("boardTitle");
		b.boardContent = rs.getString("boardContent");
		b.boardWriter = rs.getString("boardWriter");
		b.boardpw = rs.getString("boardpw");
		b.createdate = rs.getString("createdate");
		b.updatedate = rs.getString("updatedate");
		list.add(b);
	}
	
	rs.close();
	stmt.close();
	conn.close();
%>

	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>게시판 리스트</h1>
	<div>
		<a href="<%=request.getContextPath()%>/addBoardForm.jsp">게시판추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>board_no</th>
				<th>board_title</th>
				<th>board_content</th>
				<th>board_writer</th>
				<th>board_pw</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
				<th>상세</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b: list){
			%>
					<tr>
						
						<td><%=b.boardNo%></td>
						<td><%=b.boardTitle%></td>
						<td><%=b.boardContent%></td>
						<td><%=b.boardWriter%></td>
						<td><%=b.boardpw%></td>
						<td><%=b.createdate%></td>
						<td><%=b.updatedate%></td>
						<td>
							<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=b.boardNo%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/deleteBoardAction.jsp?boardNo=<%=b.boardNo%>">삭제</a>
						</td>	
						<td>
							<a href="<%=request.getContextPath()%>/boardOne.jsp?boardNo=<%=b.boardNo%>">상세</a>
						</td>	
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>
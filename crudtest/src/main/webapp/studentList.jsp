<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="vo.Student" %>
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
	
	String sql = "SELECT student_no AS studentNo, student_name AS studentName, student_gender AS studentGender, student_birth AS studentBirth, createdate, updatedate FROM student";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	// <-- 모델 레이어
	// 자원해제? 자원을 뷰에서 사용하는데? 해제전에 resultSet -> ArrayList로 변형카피
	// DB Emp테이블 행의 집합(ResultSet)을 -> JAVA Emp클래스타입의 집합(ArrayList)으로 
	ArrayList<Student> list = new ArrayList<Student>();
	while(rs.next()){
		Student s = new Student(); // 결과행의 수만큼 Emp객체 필요
		s.studentNo = rs.getInt("studentNo");
		s.studentName = rs.getString("studentName");
		s.studentGender = rs.getString("studentGender");
		s.studentBirth = rs.getString("studentBirth");
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");
		list.add(s);
	}
	
	
	// 뷰 레이어
	
%>

	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>학생 리스트</h1>
	<div>
		<a href="<%=request.getContextPath()%>/addStudentForm.jsp">학생추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>student_no</th>
				<th>student_name</th>
				<th>student_gender</th>
				<th>student_birth</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Student s : list){
			%>
					<tr>
						<td><%=s.studentNo%></td>
						<td><%=s.studentName%></td>
						<td><%=s.studentGender%></td>
						<td><%=s.studentBirth%></td>
						<td><%=s.createdate%></td>
						<td><%=s.updatedate%></td>
						<td>
							<a href="<%=request.getContextPath()%>/updateStudentForm.jsp?studentNo=<%=s.studentNo%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/deleteStudentAction.jsp?studentNo=<%=s.studentNo%>">삭제</a>
						</td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>
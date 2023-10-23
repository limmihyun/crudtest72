<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	String studentName = request.getParameter("studentName");
	String studentGender = request.getParameter("studentGender");
	String studentBirth = request.getParameter("studentBirth");
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "INSERT INTO student(student_name, student_gender, student_birth, createdate, updatedate) VALUES(?,?,?, NOW(), NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, studentName);
	stmt.setString(2, studentGender);
	stmt.setString(3, studentBirth);
	System.out.println(stmt+" <-- stmt");
	int row = stmt.executeUpdate();
	if(row == 1){
		System.out.println("입력성공");
	}else{
		System.out.println("입력실패");
	}
	// db관련 프로세스 END -> DB자원을 해제 -> 모델 레이어
	
	stmt.close();
	conn.close();
	
	//리다이렉션<-- 컨트롤러 레이어
	response.sendRedirect(request.getContextPath()+"/studentList.jsp");
%>
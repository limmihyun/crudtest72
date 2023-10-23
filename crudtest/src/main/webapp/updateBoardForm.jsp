
<%@page import="vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>

<%
   int boardNo = Integer.parseInt(request.getParameter("boardNo"));
   Class.forName("org.mariadb.jdbc.Driver");
   
   String url = "jdbc:mariadb://localhost:3306/gdj72";
   String dbuser = "root";
   String dbpw = "java1234";
   
   Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
   String sql = "SELECT board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter,createdate, updatedate FROM board WHERE board_no = ?";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, boardNo);
   ResultSet rs = stmt.executeQuery();
   
   Board b = null;
   if(rs.next()) {
      b = new Board();
      b.boardNo = rs.getInt("boardNo");
      b.boardTitle = rs.getString("boardTitle");
      b.boardContent = rs.getString("boardContent");
      b.boardWriter = rs.getString("boardWriter");
      b.createdate = rs.getString("createdate");
      b.updatedate = rs.getString("updatedate");
   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>Board 수정</h1>
   <form action="<%=request.getContextPath()%>/updateBoardAction.jsp">
      <table border="1">
         <tr>
            <td>board_no</td>
            <td>
               <input type="number" name="boardNo" value="<%=b.boardNo%>" readonly="readonly">
            </td>
         </tr>
         <tr>
            <td>board_title</td>
            <td>
               <input type="text" name="boardTitle" value="<%=b.boardTitle%>">
            </td>
         </tr>
         <tr>
            <td>board_Content</td>
            <td>
          		<textarea name="boardContent"><%=b.boardContent%></textarea>
          	</td>
         </tr>
         <tr>
            <td>board_Writer</td>
            <td><input type="text" name="boardWriter" value="<%=b.boardWriter%>"></td>
         </tr>
         <tr>
            <td>createdate</td>
            <td><%=b.createdate%></td>
         </tr>
         <tr>
            <td>updatedate</td>
            <td><%=b.updatedate%></td>
         </tr>
         <tr>
            <td colspan="2"><button type="submit">수정</button></td>
         </tr>
      </table>
   </form>
</body>
</html>
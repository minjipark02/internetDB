<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import = "org.example.db_5.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="users" class="org.example.db_5.User" scope="page"></jsp:useBean>
<jsp:setProperty name="users" property="userID"/>
<jsp:setProperty name="users" property="userPassword"/>
<jsp:setProperty name="users" property="userName"/>
<jsp:setProperty name="users" property="userEmail"/>

<head>
    <meta http-equiv="Content-Type" content="text/html; c harset=UTF-8">
    <title>JSP BBS</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
    }
    if (userID != null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인되었습니다.')");
        script.println("location.href = 'main.jsp'");    // 메인 페이지로 이동
        script.println("</script>");
    }
    if (users.getUserID() == null || users.getUserPassword() == null || users.getUserName() == null
            || users.getUserEmail() == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('모든 문항을 입력해주세요.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
    }else{
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(users);
        if (result == -1){ // 회원가입 실패시
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
            script.println("</script>");
        }else{ // 회원가입 성공시
            session.setAttribute("userID", users.getUserID()); // 추가
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");    // 메인 페이지로 이동
            script.println("</script>");
        }
    }
%>

</body>
</html>
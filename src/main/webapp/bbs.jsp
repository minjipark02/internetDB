<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.example.db_5.BbsDAO" %>
<%@ page import="org.example.db_5.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- 반응형 웹에 사용하는 메타태그 -->
    <link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
    <title>JSP 게시판 웹 사이트</title>
    <style type="text/css">
        a, a:hover {
            color: #000000;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
    }
    int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
%>
<nav class="navbar navbar-default">
    <div class="navbar-header"> <!-- 홈페이지의 로고 -->
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
            <span class="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li> <!-- 메인 페이지 -->
            <li class="active"><a href="bbs.jsp">게시판</a></li>
        </ul>
        <% if (userID == null) { %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button"
                   aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <% } else { %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button"
                   aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="logoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
        <% } %>
    </div>
</nav>

<div class="container">
    <div>
        <table class="table table-stripped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #eeeeee; text-align: center;">번호</th>
                <th style="background-color: #eeeeee; text-align: center;">제목</th>
                <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                <th style="background-color: #eeeeee; text-align: center;">작성일</th>
            </tr>
            </thead>
            <tbody>
            <%
                BbsDAO bbsDAO = new BbsDAO();
                ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                for (Bbs bbs : list) {
            %>
            <tr>
                <td><%= bbs.getBbsID() %></td>
                <td><a href="view.jsp?bbsID=<%= bbs.getBbsID() %>"><%= bbs.getBbsTitle() %></a></td>
                <td><%= bbs.getUserID() %></td>
                <td><%= bbs.getBbsDate() %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
            if(pageNumber != 1){
        %>
        <a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
        <%
            }
            if(bbsDAO.nextPage(pageNumber)){
        %>
        <a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-right">다음</a>
        <%
            }
        %>
        <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>

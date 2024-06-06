package org.example.db_5;

import java.sql.*;

public class UserDAO {
    private Connection conn; // db 접근 객체
    private PreparedStatement pstmt;
    private ResultSet rs; // db 결과를 담는 객체

    public UserDAO() { // dao 생성자에서 db connection
        try {
            String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle 서버의 XE DB 접근 경로
            String dbID = "internetDB"; // 계정
            String dbPassword = "internet"; // 비밀번호
            Class.forName("oracle.jdbc.driver.OracleDriver"); // Oracle에 접속을 도와주는 라이브러리
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 로그인 기능
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM users WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // SQL Injection 공격 방어 수단 : 1번째 물음표에 userID 입력
            rs = pstmt.executeQuery(); // 쿼리 실행
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) // rs.getString(1) : select된 첫번째 컬럼
                    return 1; // 로그인 성공
                else
                    return 0; // 비밀번호 틀림
            }
            return -1; // 아이디 없음
        } catch (Exception e) {
            e.printStackTrace(); // 예외의 스택 트레이스를 출력
        }
        return -2; // DB 오류
    }
    //회원가입기능
    public int join(User user) {
        String SQL = "INSERT INTO users VALUES(?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserEmail());
            return pstmt.executeUpdate(); // 0이상 값이 return된 경우 성공
        }catch(Exception e) {
            e.printStackTrace();

        }
        return -1; //DB 오류
    }
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Mark List - Three Tier JSP Database Application</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, sans-serif; }
        body { background: #082654; color: #fff; padding: 30px 20px; }
        .container { max-width: 1000px; margin: 0 auto; background: rgba(255,255,255,0.06); border: 1.5px solid #3b82f6; border-radius: 16px; padding: 28px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        h1 { color: #f6c000; text-align: center; margin-bottom: 6px; font-size: 26px; }
        p.sub { text-align: center; color: #93c5fd; margin-bottom: 24px; font-size: 14px; }
        .search-box { display: flex; justify-content: center; gap: 10px; margin-bottom: 24px; }
        .search-box input { padding: 9px 14px; border-radius: 6px; border: 1px solid #3b82f6; font-size: 14px; width: 220px; }
        .btn { padding: 9px 18px; background: #1d72f2; color: #fff; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #2563eb; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 14px; text-align: center; }
        th { background: #062354; color: #facc15; padding: 12px; border: 1px solid rgba(59,130,246,0.3); }
        td { padding: 11px; border: 1px solid rgba(59,130,246,0.2); background: rgba(6,35,84,0.4); }
        tr:hover td { background: rgba(29,114,242,0.15); }
        .badge-pass { color: #86efac; font-weight: bold; }
        .badge-fail { color: #f87171; font-weight: bold; }
        .nav-back { text-align: center; margin-top: 24px; }
        .nav-back a { color: #94a3b8; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>

<div class="container">
    <h1>Student Mark List (Database Server)</h1>
    <p class="sub">Three-Tier Architecture: Browser (Tier 1) &rarr; JSP Engine (Tier 2) &rarr; MySQL Database (Tier 3)</p>

    <!-- Filter by Roll Number -->
    <form method="GET" action="marklist.jsp" class="search-box">
        <input type="text" name="searchRoll" placeholder="Enter Roll No (e.g. CS101)" value="<%= request.getParameter("searchRoll") != null ? request.getParameter("searchRoll") : "" %>">
        <button type="submit" class="btn">Search</button>
        <a href="marklist.jsp" class="btn" style="background: #475569;">Show All</a>
    </form>

    <table>
        <thead>
            <tr>
                <th>Roll No</th>
                <th>Student Name</th>
                <th>Dept</th>
                <th>Sub 1</th>
                <th>Sub 2</th>
                <th>Sub 3</th>
                <th>Sub 4</th>
                <th>Sub 5</th>
                <th>Total (/500)</th>
                <th>Percentage</th>
                <th>Result</th>
                <th>Grade</th>
            </tr>
        </thead>
        <tbody>
<%
    String searchRoll = request.getParameter("searchRoll");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Tier 3 Connection: MySQL Database
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/student_db?useSSL=false&allowPublicKeyRetrieval=true";
        conn = DriverManager.getConnection(dbUrl, "root", "root"); // adjust db user/password

        String sql;
        if (searchRoll != null && !searchRoll.trim().isEmpty()) {
            sql = "SELECT s.roll_no, s.student_name, s.department, m.subject_1, m.subject_2, m.subject_3, m.subject_4, m.subject_5 " +
                  "FROM students s JOIN marks m ON s.roll_no = m.roll_no WHERE s.roll_no = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, searchRoll.trim());
        } else {
            sql = "SELECT s.roll_no, s.student_name, s.department, m.subject_1, m.subject_2, m.subject_3, m.subject_4, m.subject_5 " +
                  "FROM students s JOIN marks m ON s.roll_no = m.roll_no ORDER BY s.roll_no ASC";
            ps = conn.prepareStatement(sql);
        }

        rs = ps.executeQuery();
        boolean hasRecords = false;

        while (rs.next()) {
            hasRecords = true;
            String roll = rs.getString("roll_no");
            String name = rs.getString("student_name");
            String dept = rs.getString("department");
            int m1 = rs.getInt("subject_1");
            int m2 = rs.getInt("subject_2");
            int m3 = rs.getInt("subject_3");
            int m4 = rs.getInt("subject_4");
            int m5 = rs.getInt("subject_5");

            // Tier 2 Business Logic: Calculations
            int total = m1 + m2 + m3 + m4 + m5;
            double percentage = total / 5.0;
            boolean isPass = (m1 >= 50 && m2 >= 50 && m3 >= 50 && m4 >= 50 && m5 >= 50);

            String grade;
            if (!isPass) grade = "RA";
            else if (percentage >= 85) grade = "Distinction";
            else if (percentage >= 70) grade = "First Class";
            else if (percentage >= 60) grade = "Second Class";
            else grade = "Third Class";
%>
            <tr>
                <td><strong><%= roll %></strong></td>
                <td><%= name %></td>
                <td><%= dept %></td>
                <td><%= m1 %></td>
                <td><%= m2 %></td>
                <td><%= m3 %></td>
                <td><%= m4 %></td>
                <td><%= m5 %></td>
                <td><strong><%= total %></strong></td>
                <td><%= String.format("%.2f%%", percentage) %></td>
                <td class="<%= isPass ? "badge-pass" : "badge-fail" %>"><%= isPass ? "PASS" : "FAIL" %></td>
                <td><strong><%= grade %></strong></td>
            </tr>
<%
        }
        if (!hasRecords) {
%>
            <tr><td colspan="12" style="padding: 20px; color: #f87171;">No mark records found in database!</td></tr>
<%
        }
    } catch (Exception e) {
%>
            <tr><td colspan="12" style="padding: 20px; color: #facc15;">Note: Database offline or loading demo mode. (<%= e.getMessage() %>)</td></tr>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception e){}
        if (ps != null) try { ps.close(); } catch(Exception e){}
        if (conn != null) try { conn.close(); } catch(Exception e){}
    }
%>
        </tbody>
    </table>

    <div class="nav-back">
        <a href="index.html">&larr; Back to Dashboard</a>
    </div>
</div>

</body>
</html>

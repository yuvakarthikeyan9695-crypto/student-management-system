<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Examination System - JSP Three-Tier</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, sans-serif; }
        body { background: #082654; color: #fff; padding: 30px 20px; }
        .container { max-width: 800px; margin: 0 auto; background: rgba(255,255,255,0.06); border: 1.5px solid #3b82f6; border-radius: 16px; padding: 32px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        h1 { color: #f6c000; text-align: center; margin-bottom: 6px; font-size: 26px; }
        p.sub { text-align: center; color: #93c5fd; margin-bottom: 24px; font-size: 14px; }
        .question-card { background: rgba(6,35,84,0.5); border: 1px solid rgba(59,130,246,0.3); border-radius: 10px; padding: 18px; margin-bottom: 18px; text-align: left; }
        .question-title { font-size: 15px; font-weight: 600; color: #facc15; margin-bottom: 10px; }
        .option { display: block; margin: 8px 0; font-size: 14px; cursor: pointer; color: #e2e8f0; }
        .option input { margin-right: 8px; }
        .btn-submit { display: block; width: 100%; padding: 13px; background: #1d72f2; color: #fff; font-size: 16px; font-weight: 700; border: none; border-radius: 8px; cursor: pointer; transition: 0.2s; margin-top: 20px; }
        .btn-submit:hover { background: #2563eb; }
        .result-box { background: rgba(22,101,52,0.3); border: 1.5px solid #22c55e; border-radius: 12px; padding: 24px; text-align: center; margin-bottom: 24px; }
        .result-score { font-size: 32px; font-weight: 800; color: #facc15; margin: 10px 0; }
        .back-link { display: inline-block; margin-top: 20px; color: #94a3b8; text-decoration: none; }
    </style>
</head>
<body>

<div class="container">
    <h1>Online Examination System</h1>
    <p class="sub">Three-Tier Architecture: JSP &rarr; Java Business Logic &rarr; MySQL Database Server</p>

<%
    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        // Tier 2: Evaluating submitted answers
        String roll = request.getParameter("rollNumber");
        if (roll == null || roll.trim().isEmpty()) roll = "CS101";

        int score = 0;
        int totalQuestions = 4;

        // Correct Answers Key: Q1=B, Q2=A, Q3=C, Q4=B
        if ("B".equals(request.getParameter("q1"))) score++;
        if ("A".equals(request.getParameter("q2"))) score++;
        if ("C".equals(request.getParameter("q3"))) score++;
        if ("B".equals(request.getParameter("q4"))) score++;

        double percentage = (score / (double) totalQuestions) * 100.0;
        boolean passed = percentage >= 50.0;

        // Tier 3: Database Storage into MySQL
        Connection conn = null;
        PreparedStatement ps = null;
        String dbMessage = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/student_db?useSSL=false&allowPublicKeyRetrieval=true";
            conn = DriverManager.getConnection(dbUrl, "root", "root");

            String sql = "INSERT INTO exam_results (roll_no, subject_name, score, total_questions, percentage) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, roll);
            ps.setString(2, "Java & Web Tech");
            ps.setInt(3, score);
            ps.setInt(4, totalQuestions);
            ps.setDouble(5, percentage);
            ps.executeUpdate();
            dbMessage = "Result successfully recorded into MySQL Database Server!";
        } catch (Exception e) {
            dbMessage = "Result evaluated (Database connection demo mode: " + e.getMessage() + ")";
        } finally {
            if (ps != null) try { ps.close(); } catch(Exception e){}
            if (conn != null) try { conn.close(); } catch(Exception e){}
        }
%>
        <!-- Result Display -->
        <div class="result-box">
            <h2>Examination Completed!</h2>
            <p>Student Roll No: <strong><%= roll %></strong></p>
            <div class="result-score"><%= score %> / <%= totalQuestions %> (<%= String.format("%.1f%%", percentage) %>)</div>
            <p style="font-size: 18px; font-weight: bold; color: <%= passed ? "#86efac" : "#f87171" %>;">
                Status: <%= passed ? "PASSED (Congratulations!)" : "FAILED (Needs Improvement)" %>
            </p>
            <p style="color: #cbd5e1; font-size: 13px; margin-top: 10px;"><%= dbMessage %></p>
            <a href="exam.jsp" class="btn-submit" style="display:inline-block; width:auto; padding:10px 24px; text-decoration:none;">Retake Examination</a>
        </div>
<%
    } else {
%>
        <!-- Tier 1: Examination Questionnaire Form -->
        <form method="POST" action="exam.jsp">
            <div style="margin-bottom: 20px; text-align: left;">
                <label style="font-weight: 600; color: #facc15; font-size: 14px;">Enter Student Roll Number:</label>
                <input type="text" name="rollNumber" value="CS101" required style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #3b82f6; margin-top: 6px; font-size: 14px;">
            </div>

            <!-- Question 1 -->
            <div class="question-card">
                <div class="question-title">1. Which protocol is primarily used to browse web pages?</div>
                <label class="option"><input type="radio" name="q1" value="A"> A) FTP</label>
                <label class="option"><input type="radio" name="q1" value="B"> B) HTTP / HTTPS</label>
                <label class="option"><input type="radio" name="q1" value="C"> C) SMTP</label>
                <label class="option"><input type="radio" name="q1" value="D"> D) SNMP</label>
            </div>

            <!-- Question 2 -->
            <div class="question-card">
                <div class="question-title">2. In Java Servlet lifecycle, which method executes only once when loaded?</div>
                <label class="option"><input type="radio" name="q2" value="A"> A) init()</label>
                <label class="option"><input type="radio" name="q2" value="B"> B) service()</label>
                <label class="option"><input type="radio" name="q2" value="C"> C) doGet()</label>
                <label class="option"><input type="radio" name="q2" value="D"> D) destroy()</label>
            </div>

            <!-- Question 3 -->
            <div class="question-card">
                <div class="question-title">3. Which technology is used to define and validate the structure and rules of an XML document?</div>
                <label class="option"><input type="radio" name="q3" value="A"> A) CSS</label>
                <label class="option"><input type="radio" name="q3" value="B"> B) JavaScript</label>
                <label class="option"><input type="radio" name="q3" value="C"> C) XML Schema (XSD)</label>
                <label class="option"><input type="radio" name="q3" value="D"> D) JSON</label>
            </div>

            <!-- Question 4 -->
            <div class="question-card">
                <div class="question-title">4. Which object is used in Servlets for Session Tracking across multiple client requests?</div>
                <label class="option"><input type="radio" name="q4" value="A"> A) HttpServletRequest</label>
                <label class="option"><input type="radio" name="q4" value="B"> B) HttpSession</label>
                <label class="option"><input type="radio" name="q4" value="C"> C) ServletConfig</label>
                <label class="option"><input type="radio" name="q4" value="D"> D) ServletContext</label>
            </div>

            <button type="submit" class="btn-submit">Submit Exam & Evaluate Score</button>
        </form>
<%
    }
%>

    <div style="text-align: center;">
        <a href="index.html" class="back-link">&larr; Back to Dashboard</a>
    </div>
</div>

</body>
</html>

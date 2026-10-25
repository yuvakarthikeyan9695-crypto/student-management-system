# 🎓 Web Technology Lab Programs Guide
## Student Management System & Java Web Lab Integration

---

### 📋 Overview of Added Lab Programs

| S.No | Syllabus Topic | File(s) Created | Purpose & Architecture |
|---|---|---|---|
| **1.i** | **Invoke Servlets from HTML Forms** | [src/RegisterServlet.java](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/src/RegisterServlet.java)<br>[servlet_demo.html](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/servlet_demo.html)<br>[WEB-INF/web.xml](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/WEB-INF/web.xml) | HTML form posts data via HTTP POST to `RegisterServlet`. Uses `request.getParameter()` and writes HTML dynamic response. |
| **1.ii** | **Session Tracking using Servlets** | [src/SessionTrackingServlet.java](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/src/SessionTrackingServlet.java)<br>[servlet_demo.html](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/servlet_demo.html) | Uses `HttpSession` (`request.getSession(true)`), tracks visit count (page hits), session creation time, session ID, and handles session invalidation (`session.invalidate()`). |
| **2.i** | **Three-Tier Online Examination (JSP + DB)** | [exam.jsp](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/exam.jsp)<br>[exam.html](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/exam.html)<br>[database.sql](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/database.sql) | **Tier 1:** Exam form UI.<br>**Tier 2:** JSP scriptlet calculates score & percentage.<br>**Tier 3:** JDBC connects to MySQL and saves result in `exam_results` table. |
| **2.ii** | **Displaying Student Mark List (JSP + DB)** | [marklist.jsp](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/marklist.jsp)<br>[marks.html](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/marks.html)<br>[database.sql](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/database.sql) | **Tier 1:** Client search & display.<br>**Tier 2:** JSP calculates total, %, pass/fail, and grades.<br>**Tier 3:** MySQL `student_db` storing student records & subject marks. |
| **3** | **XML &bull; Schema (XSD) &bull; XSLT/XSL** | [students.xml](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/students.xml)<br>[student_schema.xsd](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/student_schema.xsd)<br>[student_style.xsl](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/student_style.xsl)<br>[xml_view.html](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/xml_view.html) | `students.xml` contains structured mark data. `student_schema.xsd` validates tags & constraints. `student_style.xsl` transforms XML into a styled marksheet table. |

---

### 🚀 How to Run & Test Everything:

#### 1. Instant Browser Testing (Zero Server Setup):
- Simply double-click **[run.bat](file:///c:/Users/balaa/OneDrive/Documents/NEW%20PROJECT/run.bat)**.
- On the dashboard, click:
  - 📝 **Online Exam** &rarr; conducts interactive exam with timer and instant report card.
  - 📄 **XML & XSLT** &rarr; live tabs to preview transformed XML, raw XSD schema, and XSL stylesheet.
  - 🧪 **Servlets & Session** &rarr; test form submission and session hit counter.
  - 📊 **Marks Records** &rarr; view standard marks, with buttons for Database and XML views.

#### 2. Running on Apache Tomcat (College Lab Evaluation):
1. Copy the project folder into Tomcat's `webapps/` folder (e.g. `tomcat/webapps/student-management/`).
2. Start Tomcat (`bin/startup.bat`).
3. Compile Servlets if needed:
   ```cmd
   javac -cp ".;%CATALINA_HOME%\lib\servlet-api.jar" -d WEB-INF/classes src/*.java
   ```
4. Access in browser:
   `http://localhost:8080/student-management/index.html`

#### 3. MySQL Database Setup (for Three-Tier JSP):
1. Open MySQL Command Line or phpMyAdmin.
2. Run the script:
   ```sql
   source C:/Users/balaa/OneDrive/Documents/NEW PROJECT/database.sql;
   ```
3. Open `http://localhost:8080/student-management/marklist.jsp` to see live records pulled from MySQL!

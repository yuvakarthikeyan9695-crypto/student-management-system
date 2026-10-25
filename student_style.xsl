<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
<head>
    <title>Student Mark List - XML &amp; XSLT Transformation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Arial, sans-serif;
            background: #082654;
            color: #ffffff;
            padding: 30px 20px;
            text-align: center;
        }
        .container {
            max-width: 950px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.06);
            border: 1.5px solid #3b82f6;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        h1 {
            color: #f6c000;
            margin-bottom: 6px;
            font-size: 26px;
        }
        p.subtitle {
            color: #93c5fd;
            font-size: 14px;
            margin-bottom: 24px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 14px;
        }
        th {
            background-color: #062354;
            color: #facc15;
            padding: 12px;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }
        td {
            padding: 10px;
            border: 1px solid rgba(59, 130, 246, 0.2);
            background: rgba(6, 35, 84, 0.4);
            color: #e2e8f0;
        }
        tr:hover td {
            background: rgba(29, 114, 242, 0.15);
        }
        .pass-tag {
            color: #86efac;
            font-weight: bold;
        }
        .fail-tag {
            color: #f87171;
            font-weight: bold;
        }
        .btn-back {
            display: inline-block;
            margin-top: 24px;
            padding: 10px 20px;
            background: #1d72f2;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Student Mark List (XML &amp; XSLT)</h1>
    <p class="subtitle">Transformed from XML using Extensible Stylesheet Language Transformations (XSLT)</p>

    <table>
        <thead>
            <tr>
                <th>Roll No</th>
                <th>Student Name</th>
                <th>Department</th>
                <th>Networks</th>
                <th>OS</th>
                <th>Web Tech</th>
                <th>DBMS</th>
                <th>Total (/400)</th>
                <th>Percentage</th>
                <th>Result</th>
            </tr>
        </thead>
        <tbody>
            <xsl:for-each select="students/student">
            <tr>
                <td><strong><xsl:value-of select="rollNo"/></strong></td>
                <td><xsl:value-of select="name"/></td>
                <td><xsl:value-of select="department"/></td>
                <td><xsl:value-of select="marks/subject[1]"/></td>
                <td><xsl:value-of select="marks/subject[2]"/></td>
                <td><xsl:value-of select="marks/subject[3]"/></td>
                <td><xsl:value-of select="marks/subject[4]"/></td>
                <td><strong><xsl:value-of select="total"/></strong></td>
                <td><xsl:value-of select="percentage"/>%</td>
                <td>
                    <xsl:choose>
                        <xsl:when test="result='PASS'">
                            <span class="pass-tag">PASS</span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="fail-tag">FAIL</span>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
            </xsl:for-each>
        </tbody>
    </table>

    <br/>
    <a href="index.html" class="btn-back">&#8592; Back to Dashboard</a>
</div>

</body>
</html>
</xsl:template>
</xsl:stylesheet>

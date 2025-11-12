<%-- HCI사이언스전공 20231601 최혜선 --%>
<%-- Chrome에 최적화 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
	<title>calendar</title>
	<style>
		table {
                border: 1px solid black;
                border-collapse: collapse;
                margin: 0 auto;
            }
            
        td {
            border: 1px solid black;
            width: 100px;
            height: 40px;
            text-align: center;
        }

		.sun { color: red; }
		
		.sat { color: blue; }
		
		.date {
			text-align: right;
			font-weight: bold;
		}
	</style>
</head>
<body>
	<%
		String sYear = request.getParameter("YEAR");
		String sMonth = request.getParameter("MONTH");
		
		Calendar today = Calendar.getInstance();	
		int year, month;
		
		if (sYear == null || sMonth == null) {
			year = today.get(Calendar.YEAR);
			month = today.get(Calendar.MONTH) + 1;
		} else {
			year = Integer.parseInt(sYear);
			month = Integer.parseInt(sMonth);
		}
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, 1);

		int startDay = cal.get(Calendar.DAY_OF_WEEK);
		int end = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	%>
	
	<p class="date"><%=today.get(Calendar.YEAR)%>-<%=today.get(Calendar.MONTH)+1%>-<%=today.get(Calendar.DATE)%></p>
	
	<div>
		<a href="calendar.jsp?YEAR=<%=year - 1%>&MONTH=<%=month%>">◀</a>
		<span style="font-size:20px; font-weight:bold;"><%=year%>년</span>
		<a href="calendar.jsp?YEAR=<%=year + 1%>&MONTH=<%=month%>">▶</a>
	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
		<%
			if (month > 1)
				out.print("<a href='calendar.jsp?YEAR=" + year + "&MONTH=" + (month - 1) + "'>◀</a>");
			else
				out.print("◀");
	
			out.print("<span style='font-size:20px; font-weight:bold;'>&nbsp;" + month + "월&nbsp;</span>");
	
			if (month < 12)
				out.print("<a href='calendar.jsp?YEAR=" + year + "&MONTH=" + (month + 1) + "'>▶</a>");
			else
				out.print("▶");
		%>
	</div>
	
	<table>
		<tr>
			<td class="sun">일</td>
			<td>월</td>
			<td>화</td>
			<td>수</td>
			<td>목</td>
			<td>금</td>
			<td class="sat">토</td>
		</tr>
	
	<%
		int count = 0;
		out.println("<tr>");
		for (int i = 1; i < startDay; i++) {
			out.println("<td>&nbsp;</td>");
			count++;
		}
		
		for (int day = 1; day <= end; day++) {
			int weekend = (count % 7) + 1;
			out.println("<td>" + parseDay(weekend, day) + "</td>");
			count++;
			
			if (count % 7 == 0 && day != end)
				out.println("</tr><tr>");
		}
		
		while (count % 7 != 0) {
			out.println("<td>&nbsp;</td>");
			count++;
		}
		out.println("</tr>");
	%>	
	</table>

	<%! 
		public String parseDay(int weekend, int day) {
		if (weekend == 1)
			return "<font color='red'>" + day + "</font>";
		else if (weekend == 7)
			return "<font color='blue'>" + day + "</font>";
		else
			return String.valueOf(day);
	}
	%>

</body>
</html>

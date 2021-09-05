package jdbc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.DB_Connection;

/**
 * Servlet implementation class ReserverARoom
 */
@WebServlet("/ReserverARoom")
public class ReserverARoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReserverARoom() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
        	String current_user_val = request.getParameter("current_user");
            String CheckIn_val = request.getParameter("CheckIn");
            String CheckOut_val = request.getParameter("CheckOut");
            String Adults_val = request.getParameter("Adults");
            String Kids_val = request.getParameter("Kids");
            
                DB_Connection obj_DB_Connection = new DB_Connection();
                Connection connection = obj_DB_Connection.get_connection();
                PreparedStatement ps = null;

                String sql = "insert into rooms (CheckIn, CheckOut, Adults,Kids,Status,RoomNo,RequestMadeBy) values(?,?,?,?,?,?,?)";
                Class.forName("com.mysql.jdbc.Driver");
                
                ps = connection.prepareStatement(sql);
                ps.setString(1, CheckIn_val);
                ps.setString(2, CheckOut_val);
                ps.setString(3, Adults_val);
                ps.setString(4, Kids_val);
                ps.setString(5, "0");
                ps.setString(6, null);
                ps.setString(7, current_user_val);
                
                ps.executeUpdate();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Request Success !');");
                out.println("location='user/home.jsp';");
                out.println("</script>");


        } catch (SQLException ex) {
            out.println(ex);
        } catch (ClassNotFoundException ex) {
            out.println(ex);
        }
	}

}

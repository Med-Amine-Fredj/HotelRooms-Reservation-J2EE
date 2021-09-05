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
 * Servlet implementation class ConfirmRoomByManager
 */
@WebServlet("/ConfirmRoomByManager")
public class ConfirmRequestByManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmRequestByManager() {
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
        	String req_id_val = request.getParameter("req_id");
        	String room_number_val = request.getParameter("room_number");
            
                DB_Connection obj_DB_Connection = new DB_Connection();
                Connection connection = obj_DB_Connection.get_connection();
                PreparedStatement ps = null;
                
                String sql = "UPDATE rooms SET Status = ?, RoomNo= ? WHERE id = ? ";
                Class.forName("com.mysql.jdbc.Driver");
                
                ps = connection.prepareStatement(sql);
                ps.setString(1, "1");
                ps.setString(2, room_number_val);
                ps.setString(3, req_id_val);

                
                ps.executeUpdate();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Request Confirmed !');");
                out.println("location='manager/allrequests.jsp';");
                out.println("</script>");


        } catch (SQLException ex) {
            out.println(ex);
        } catch (ClassNotFoundException ex) {
            out.println(ex);
        }
	}

}

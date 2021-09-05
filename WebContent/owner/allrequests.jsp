<%@page import="common.DB_Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>

<!DOCTYPE html>
<html>
<title>LuXe</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="../images/logo.png">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}

.btn {
  border: 2px solid black;
  background-color: white;
  color: black;
  padding: 8px 16px;
  font-size: 15px;
  cursor: pointer;
  transition: 0.25s;
  border-radius: 20px;
}

.success {
  border-color: #4CAF50;
  color: green;
}

.success:hover {
  background-color: #4CAF50;
  color: white;
}

.danger {
  border-color: #f44336;
  color: red;
}

.danger:hover {
  background: #f44336;
  color: white;
}

input{
		border: none;
        border-bottom: 1px solid darkgray;
        background: transparent;
        outline: none;
        height: 40px;
        color: darkgray;
        font-size: 16px;
        transition: 0.25s;
        margin-left: 20px;
        margin-bottom: 20px;
}
.ConfirmedLbl{
  background-color: MediumSeaGreen;
  color: white;
  padding: 8px 16px;
  font-size: 15px;
  text-align: center;
  margin-left: 20px;
  margin-right: 20px;
}
.notfound{
		top: 50%;
        left: 50%;
        position: absolute;
        transform: translate(-50%, -50%);
        box-sizing: border-box;
        padding: 70px 30px;
}
</style>
<body class="w3-light-grey">

<!-- Navigation Bar -->
<div class="w3-bar w3-white w3-large">
  <a href="home.jsp" class="w3-bar-item w3-button  w3-mobile"><img src="../images/logo.png" style="width: 25px;height: 25px;"></a>
  <a href="allrequests.jsp" class="w3-bar-item w3-button w3-blue w3-mobile">All Requests</a>
  <a href="rooms.jsp" class="w3-bar-item w3-button w3-mobile">Rooms</a>
  <a href="about.jsp" class="w3-bar-item w3-button w3-mobile">About</a>
  <a href="contact.jsp" class="w3-bar-item w3-button w3-mobile">Contact</a>
  <a href="../logout.jsp" id="user_name_div" title="logout" class="w3-bar-item w3-button w3-right w3-light-grey w3-mobile"><%= session.getAttribute( "LogedInOwnerName" ) %></a>
  <script type="text/javascript">
    var pp = document.getElementById('user_name_div').innerText;
    if(pp == "null"){
      window.location.href = "../login.jsp";
    }
  </script>
</div>

<!-- page content -->
<div style="width: 100%; min-height: 750px;">
		<div class="w3-container w3-margin-top" id="rooms">
			<h3>All Requests</h3>
			
			<div class="w3-row-padding w3-padding-16">
				<%
					try {
						Statement statement = null;
						ResultSet resultSet = null;
						String Countrow="";
						
						DB_Connection obj_DB_Connection = new DB_Connection();
						Connection connection = obj_DB_Connection.get_connection();
						statement = connection.createStatement();
						String sql = "SELECT COUNT(id) FROM rooms";
						resultSet = statement.executeQuery(sql);
						while (resultSet.next()) {
							Countrow = resultSet.getString(1);
							if(Countrow.equals("0")){
								%>
								<div class="notfound">
								<center><img alt="ntfound" src="../images/ntfound.png">
								<h4>No Requests found</h4>
								</div>

								<%
							}
							else{
								%>
								<form action="../DeleteAllRequestByOwner" method="post">
								<button type="submit" class="btn danger" style="margin: 20px">Delete All</button>
								</form>
								<%
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				%>


				<%
					try {
						Statement statement = null;
						ResultSet resultSet = null;

						DB_Connection obj_DB_Connection = new DB_Connection();
						Connection connection = obj_DB_Connection.get_connection();
						statement = connection.createStatement();
						String sql = "SELECT * FROM rooms ORDER BY dateNtime ASC";

						resultSet = statement.executeQuery(sql);
						while (resultSet.next()) {
				%>

				<div class="w3-third w3-margin-bottom">
					<div class="w3-container w3-white">
						<table>
							<tr>
								<td><h3>Requested At :</h3></td>
								<td><label
									style="font-family: monospace; color: gray; border: 2px solid gray; padding: 8px;">
										<%=resultSet.getString("dateNtime")%></label></td>
							</tr>
						</table>

						<ul>
							<li>Adults : <b><%=resultSet.getString("Adults")%></b></li>
							<li>Kids : <b><%=resultSet.getString("Kids")%></b></li>
							<li>CheckIn Date : <b><%=resultSet.getString("CheckIn")%></b></li>
							<li>CheckOut Date : <b><%=resultSet.getString("CheckOut")%></b></li>
							<li>Request Made By : <b><%=resultSet.getString("RequestMadeBy")%></b></li>
						</ul>

						<table>
							<tr>
								<%
									if (resultSet.getString("Status").equals("1")) {
								%>
								<td>
									<p class="ConfirmedLbl">Confirmed</p>
								</td>
								<%
									} else {
								%>

								<td>
									<form action="../ConfirmRoomByOwner" method="post">
										<input type="number" value="" name="room_number"
											placeholder="Room number" required="required"> <input
											style="display: none;" type="text" name="req_id"
											value='<%=resultSet.getString("id")%>'>
										<button type="submit" class="btn success"
											style="margin: 20px;">Confirm</button>
									</form>
								</td>
								<%
									}
								%>
								<td>
									<form action="../DeleteRequestByOwner" method="post">
										<input style="display: none;" type="text" name="req_id"
											value='<%=resultSet.getString("id")%>'>
										<button type="submit" class="btn danger" >Delete</button>
									</form>
								</td>
							</tr>
						</table>


					</div>
				</div>

				<%
					}
					%>

					<%
					} catch (Exception e) {
						e.printStackTrace();
					}
				%>

			</div>

		</div>
	</div>

<!-- Footer -->
<footer class="w3-padding-16 w3-black w3-center w3-margin-top">
  <h5>Find Us On</h5>
  <div class="w3-xlarge w3-padding-16">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
</footer>


</body>
</html>

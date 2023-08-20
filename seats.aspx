<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seats.aspx.cs" Inherits="ViewMax.seats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="seats.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <header>
        <h2>VIEWMAX</h2>
    </header>
    <div class="back">
        <div class="i" onclick="history.back()"><i class="arrow left"></i></div>
        <div class="tit">SELECT YOR SEAT/s</div>
    </div>
    <form id="form1" runat="server">
        <div class="cine-holder">
            <div class="cine">
                <div class="screen">
                    <img src="screen.png"/>
                </div>
                <div class="seats">
                    <div class="seats-cont">

                        <%//-----Creation of the rows------
                            int row_name = 64;//row names are declared
                            for (int i = 0; i < rows; i++)
                            {
                                row_name++; //we increment the row names
                                %>
                        <!--The seats rows are created------->
                        <div class="seat-row" id="<%= (char)row_name%>">
                            <%for (int j = 1; j < columns; j++)
                                {%>

                            <!---SEATS SPACE of row <%=(char)row_name%> IS CREATED--->
                            <div class="seat-space" id="<%=(char)row_name%><%=j%>">
                                <div class="seat" onclick="AddToArray(this)">

                                </div>
                            </div>
                            <%} %>
                        </div>
                        <%} %>

                    </div>
                </div>
                <div id="Yseats">
                    <h4>Your Seats:</h4>
                    <span id="Yseat"></span>
                    <asp:HiddenField ID="MySeats" runat="server" />
                    <asp:HiddenField ID="arr_MySeats" runat="server" />
                </div>
                <div class="next">
                    <asp:LinkButton ID="lsa" runat="server" OnClick="lsa_Click"><span>Proceed to Checkout</span></asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="seats_length" runat="server" Value="new" />
        <asp:HiddenField ID="B_seats_length" runat="server" Value="new" />
    </form>

</body>
    <script>
        let arrds = [];
        arrds = <%=created_seats%>;
        console.log(arrds[0]);

        const seat = document.createElement("div");
        seat.classList.add("seat");
        const seatspace = document.querySelectorAll(".seat-space");

        const seat_row = document.querySelectorAll(".seat-row");

        // LOOP THROUGH THE ROWS N NMBER OF TIMES
        for (let i = 0; i < seat_row.length; i++) {

            let seat_row_id = seat_row[i].id;
            let seat_space = document.getElementById(seat_row_id).children;
            let seat_no = 0;

            // LOOP THROUGH THE SEAT SPACES
            for (let j = 0; j < seat_space.length; j++) {

                let seat_space_id = seat_space[j].id;
                let seat = document.getElementById(seat_space_id).children;

                if (exists(arrds, seat_space_id) === true) {
                    seat_no++;
                    seat_name = seat_row_id + seat_no;
                    seat[0].innerHTML = seat_name;
                    seat[0].id = seat_name;
                }
                else {
                    seat[0].style.display = "none";
                }

                console.log(seat_space[j].id);
            }
        }

        var bookedSeats = <%=booked_seats%>;
        var selectedSeats = [];
        var Cseats = document.querySelectorAll(".seat");

        for (let i = 0; i < Cseats.length; i++) {
            let Cseats_id = Cseats[i].id;

            for (let j = 0; j < bookedSeats.length; j++) {
                if (bookedSeats[j].includes(Cseats_id)) {
                    Cseats[i].classList.add("booked");
                    Cseats[i].onclick = false;
                }
            }
        }

        function AddToArray(elem) {
            
            let itdo = selectedSeats.includes(elem.id);

            if (itdo !== true) {
                if (selectedSeats.length !== <%=no_of_seats%>) {
                    selectedSeats.push(elem.id);
                    console.log(selectedSeats);
                    elem.classList.add("selected");
                } else {
                    alert("You have selected the maximum number of seats");
                }
                
            } else {
                elem.classList.remove("selected");
                const ind = selectedSeats.indexOf(elem.id);
                selectedSeats.splice(ind, 1);
            }
            document.getElementById("Yseat").innerHTML = selectedSeats;
            document.getElementById("MySeats").value = selectedSeats;
            var bPs = selectedSeats.concat(bookedSeats);
            document.getElementById("arr_MySeats").value = "['" + bPs.join("','") + "']";

            var hValue = document.getElementById("seats_length");
            var hbValue = document.getElementById("B_seats_length");
            hValue.value = selectedSeats.length;
            hbValue.value = bPs.length;
        }

        ///THIS FUNCTION CHECKS IF A SEAT SPACE HAS A SEAT
        function exists(arr, search) {
            return arr.some(row => row.includes(search));
        }

    </script>
</html>

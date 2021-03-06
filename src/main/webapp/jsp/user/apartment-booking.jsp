<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ct" uri="http://martyniuk.by" %>
<fmt:setLocale value="${locale}" scope="session"/>
<fmt:setBundle basename="text" var="bndl"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Hotel Europe</title>

    <!-- CSS  -->
    <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
    <link href="css/app-style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
    <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>

</head>

<body>

<jsp:include page="../header.jsp"/>

<main>


    <div class="container">
        <div class="row"></div>
        <div class="row">
            <div class="container col s4">
                <h5 class="row center">${apartmentClass.type}</h5>
                <div class="row"></div>
                <div class="row">${apartmentClass.description}</div>
                <div class="row"><strong><fmt:message key="apartment.cost.per.person"
                                                      bundle="${bndl}"/>:</strong> ${apartmentClass.costPerPerson} $
                </div>
                <div class="row"><strong><fmt:message key="apartment.cost.per.night"
                                                      bundle="${bndl}"/>:</strong> ${apartmentClass.costPerNight} $
                </div>
                <div class="row"><strong><fmt:message key="apartment.rooms.amount"
                                                      bundle="${bndl}"/>:</strong> ${apartmentClass.roomsAmount}</div>
                <div class="row"><strong><fmt:message key="apartment.max.capacity"
                                                      bundle="${bndl}"/>:</strong> ${apartmentClass.maxCapacity}
                    <fmt:message key="reservation.person" bundle="${bndl}"/></div>
            </div>
            <img class="materialboxed col s8" src="${apartmentClass.imagePath}">
        </div>
        <div class="divider"></div>

        <ct:showMessage color="red" key="bookingError"/>
        <ct:showMessage color="green" key="bookingMessage"/>

        <c:choose>
            <c:when test="${not empty user}">
                <div class="row"></div>
                <form class="col s12" name="book" action="booking" method="POST">
                    <input type="hidden" name="action" value="book_apartment">
                    <input type="hidden" name="apartmentClassId" value="${apartmentClass.id}">
                    <div class="row">
                        <div class="input-field col s4 m4">
                            <label for="checkInDate"><fmt:message key="reservation.check.in.date"
                                                                  bundle="${bndl}"/>:</label>
                            <input name="checkInDate" id="checkInDate" type="text" class="datepicker" required>
                        </div>
                        <div class="input-field col s4 m4">
                            <label for="checkOutDate"><fmt:message key="reservation.check.out.date"
                                                                   bundle="${bndl}"/>:</label>
                            <input name="checkOutDate" id="checkOutDate" type="text" class="datepicker" required>
                        </div>
                        <div class="input-field col s4 m4">
                            <label for="personAmount"><fmt:message key="reservation.person.amount"
                                                                   bundle="${bndl}"/>:</label>
                            <input name="personAmount" id="personAmount" type="text" pattern="[1-9]" class="validate"
                                   required maxlength="1">
                        </div>
                    </div>
                    <div class="row">
                        <button class="col s6 m2 offset-s3 offset-m5 btn amber accent-4 waves-effect waves-light center"
                                type="submit">
                            <fmt:message key="reservation.book" bundle="${bndl}"/>
                        </button>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <div class="row"></div>
                <div class="row center"><fmt:message key="reservation.authorization" bundle="${bndl}"/></div>
            </c:otherwise>
        </c:choose>
    </div>
</main>


<jsp:include page="../footer.jsp"/>

</body>


<!--  Scripts-->
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/materialize.js"></script>
<script src="js/init.js"></script>


<script>
    $('.modal').modal({
            dismissible: true, // Modal can be dismissed by clicking outside of the modal
            opacity: .5, // Opacity of modal background
            inDuration: 300, // Transition in duration
            outDuration: 200, // Transition out duration
            startingTop: '4%', // Starting top style attribute
            endingTop: '10%', // Ending top style attribute
        }
    );
</script>

<script>
    $(window).on("load", function () {
        if ($('#loginError').length == 1) {
            $('#modal').modal('open');
        }
    });
</script>

<script>
    $('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 15, // Creates a dropdown of 15 years to control year,
        today: 'Today',
        clear: 'Clear',
        close: 'Ok',
        closeOnSelect: false // Close upon selecting a date,
    });

    function checkInDate() {
        if ($('#checkInDate').val() == '') {
            $('#checkInDate').addClass('invalid')
            return false;
        } else {
            $('#checkInDate').removeClass('invalid')
            return true;
        }
    }

    function checkOutDate() {
        if ($('#checkOutDate').val() == '') {
            $('#checkOutDate').addClass('invalid')
            return false;
        } else {
            $('#checkOutDate').removeClass('invalid')
            return true;
        }
    }

    $('form').submit(function () {
        return checkInDate() && checkOutDate();
    });

    $('#checkInDate').change(function () {
        checkInDate();

    });

    $('#checkOutDate').change(function () {
        checkOutDate();
    });


</script>

</html>
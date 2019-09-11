
import "bootstrap";
import "jquery";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import { calendarDesk } from 'packs/components/calendar_desk';
import { calendarBooking } from 'packs/components/calendar_booking';
import { calendarMyReservation } from 'packs/components/calendar_booking_my_reservations';

if (document.getElementById("calendar_desk")) {
  calendarDesk();
};

if (document.getElementById("bookings_my_reservations")) {
  calendarMyReservation()();
};

if (document.getElementById("bookings_my_reservations")) {
  calendarMyReservation()();
};

if (document.getElementById("bookings_admin")) {
   calendarBooking();
  var links = document.querySelectorAll(".pagination a");
  links.forEach((item) => { item.setAttribute("data-remote", "true")});
}





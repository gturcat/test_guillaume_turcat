
import "bootstrap";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import { calendarDesk } from 'packs/components/calendar_desk';
import { calendarBooking } from 'packs/components/calendar_booking';

if (document.getElementById("desks_show")) {
  calendarDesk();
};

if (document.getElementById("bookings_index")) {
  calendarBooking();
};








// import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import "bootstrap";
import "jquery";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import { calendarDesk } from 'packs/components/calendar_desk';
import { calendarFilterDesk } from 'packs/components/calendar_filter_desk';
import { calendarBooking } from 'packs/components/calendar_booking';
import { calendarMyReservation } from 'packs/components/calendar_booking_my_reservations';

import { initMapbox } from 'plugins/init_mapbox';
import { initMaping } from 'plugins/init_google_map';
import { initAutocomplete, initAutocomplete_search } from 'plugins/init_autocomplete';
import { resetFilter } from 'plugins/init_autocomplete';

import { requestChannel } from 'channels/request';

if (document.getElementById("admin").dataset.admin){
  requestChannel();
}

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

if (document.getElementById("desks_index")) {
  calendarFilterDesk();
  // uncomment to work with mapbox
  // initMapbox();
  // uncomment to work with google map
  initMaping();
  initAutocomplete_search();
  var resetBtn = document.getElementById('reset-btn');
  resetBtn.addEventListener("click", (event) => {
    document.getElementById('search_start_date').value = "";
    document.getElementById('search_end_date').value = "";
  });
};

if (document.getElementById("desks_edit")) {
  initAutocomplete();
};



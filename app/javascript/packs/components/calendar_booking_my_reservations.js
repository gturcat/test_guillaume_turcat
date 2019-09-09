import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

function calendarMyReservation() {
   document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendar');
      // const deskId = document.getElementById('desk-details');
      // const id = deskId.dataset.id;
      // document.getElementById("bookbtn").disabled = true;
      var press = false;
      var calendar = new Calendar(calendarEl, {
        height: 450,
        aspectRatio: 3,
        events: `/bookings/my_reservations.json`,
        plugins: [ interactionPlugin, dayGridPlugin ],
        selectOverlap: false,
        selectable: false,
      });

      calendar.render();
    });
  }


export { calendarMyReservation }

import "bootstrap";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';



document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  const deskId = document.getElementById('desk-details');
  const id = deskId.dataset.id;

  var calendar = new Calendar(calendarEl, {
    events: `/desks/${id}/bookings.json`,
    plugins: [ interactionPlugin, dayGridPlugin ],
    selectOverlap: false,
    selectable: true,
    dateClick: function(info) {
      console.log(info.dateStr);
    },
    select: function(info) {
      console.log(info.startStr + ' to ' + info.endStr);
    }
  });

  calendar.render();
});




import "bootstrap";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

function dayDiff(date1, date2)
  {
    date1 = new Date(date1);
    date2 = new Date(date2);
    var diff = date2 - date1 ;
    diff = Math.floor(diff / (1000 * 86400) ) ;
    return diff;
  }

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  const deskId = document.getElementById('desk-details');
  const id = deskId.dataset.id;

  var calendar = new Calendar(calendarEl, {
    height: 450,
    aspectRatio: 3,
    events: `/desks/${id}/bookings.json`,
    plugins: [ interactionPlugin, dayGridPlugin ],
    selectOverlap: false,
    selectable: true,
    select: function(info) {
      console.log(info.startStr + ' to ' + info.endStr);
      const days = dayDiff(info.startStr, info.endStr)
      document.getElementById('booking_start_date').value = info.startStr;
      document.getElementById('booking_end_date').value = info.endStr;
      document.getElementById('user-choice-start-date').textContent = '';
      document.getElementById('user-choice-end-date').textContent = '';
      document.getElementById('days').textContent = '';
      document.getElementById('user-choice-start-date').textContent +=  info.startStr;
      document.getElementById('user-choice-end-date').textContent += info.endStr;
      document.getElementById('days').textContent += days;

    }
  });

  calendar.render();
});




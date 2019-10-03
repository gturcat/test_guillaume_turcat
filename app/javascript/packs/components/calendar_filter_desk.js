import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

import { addDays } from 'packs/components/display_date';

function calendarFilterDesk() {
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var press = false;
    var calendar = new Calendar(calendarEl, {
      height: 300,
      aspectRatio: 1,
      plugins: [ interactionPlugin, dayGridPlugin ],
      selectable: true,
      select: function(info) {
        var today = new Date();
        var date1 = new Date(info.startStr);
        var date2 = new Date(info.endStr);
        date2 = addDays(date2, -1)
        document.getElementById('search_start_date').value = date1;
        console.log(document.getElementById('search_start_date').value)
        document.getElementById('search_end_date').value = date2;
      }
    });
    calendar.render();
  });
}

export { calendarFilterDesk }

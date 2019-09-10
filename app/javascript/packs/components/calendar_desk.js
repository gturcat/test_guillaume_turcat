import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

import { display, addDays } from 'packs/components/display_date';

function calendarDesk() {
    const emptyInfo = () => {
    const userChoiceStartDate = document.getElementById('user-choice-start-date');
    const userChoiceEndDate = document.getElementById('user-choice-end-date');
    const displayDays = document.getElementById('days')
    userChoiceStartDate.textContent = '';
    userChoiceEndDate.textContent = '';
    displayDays.textContent ='';
    document.getElementById('booking_start_date').value = '';
    document.getElementById('booking_end_date').value = '';
    document.getElementById("bookbtn").disabled = true;
  }

  const reset = document.getElementById("reset");
  reset.addEventListener('click', (event) => {
    emptyInfo();
  });

    document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendar_desk');
      const deskId = document.getElementById('desk-details');
      const id = deskId.dataset.id;
      document.getElementById("bookbtn").disabled = true;
      var press = false;
      var calendar = new Calendar(calendarEl, {
        height: 450,
        aspectRatio: 3,
        events: `/desks/${id}/bookings.json`,
        plugins: [ interactionPlugin, dayGridPlugin ],
        selectOverlap: false,
        selectable: true,
        select: function(info) {
          var today = new Date();
          if (info.start > today) {
          document.getElementById("bookbtn").disabled = false;
          var date1 = new Date(info.startStr);
          var date2 = new Date(info.endStr);
          date2 = addDays(date2, -1)
          document.getElementById('booking_start_date').value = date1;
          document.getElementById('booking_end_date').value = date2;
          display(info);
          }
          else {
          document.getElementById("bookbtn").disabled = true;
          }
        },
      });

      calendar.render();
    });
  }

  export { calendarDesk }


import "bootstrap";
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import { display } from 'packs/components/display_date';


const emptyInfo = () => {
  const userChoiceStartDate = document.getElementById('user-choice-start-date');
  const userChoiceEndDate = document.getElementById('user-choice-end-date');
  const displayDays = document.getElementById('days')
  userChoiceStartDate.textContent = '';
  userChoiceEndDate.textContent = '';
  displayDays.textContent ='';
  document.getElementById("bookbtn").disabled = true;
}

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  const deskId = document.getElementById('desk-details');
  const id = deskId.dataset.id;
  document.getElementById("bookbtn").disabled = true;
  var calendar = new Calendar(calendarEl, {
    height: 450,
    aspectRatio: 3,
    events: `/desks/${id}/bookings.json`,
    plugins: [ interactionPlugin, dayGridPlugin ],
    selectOverlap: false,
    selectable: true,
    unselect: function( jsEvent, view ){
      emptyInfo();
    },
    select: function(info) {
      var today = new Date();
      if (info.start > today) {
      document.getElementById("bookbtn").disabled = false;
      document.getElementById('booking_start_date').value = info.startStr;
      document.getElementById('booking_end_date').value = info.endStr;
      display(info);
      }
      else {
      document.getElementById("bookbtn").disabled = true;
      }
    },
  });

  calendar.render();
});





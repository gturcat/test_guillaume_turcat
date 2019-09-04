const dayDiff = (date1, date2) => {
    date1 = new Date(date1);
    date2 = new Date(date2);
    var diff = date2 - date1 ;
    diff = Math.floor(diff / (1000 * 86400) ) ;
    return diff;
  }

function addDays(date, days) {
  var result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
}

function displayDate(date){
  var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
  date = date.toLocaleDateString('fr-CA', options);
  return date
}

const display = (info) => {

  const userChoiceStartDate = document.getElementById('user-choice-start-date');
  const userChoiceEndDate = document.getElementById('user-choice-end-date');
  const displayDays = document.getElementById('days')
  userChoiceStartDate.textContent = '';
  userChoiceEndDate.textContent = '';
  displayDays.textContent =''
  var date1 = new Date(info.startStr);
  var date2 = new Date(info.endStr);
  date2 = addDays(date2, -1)
  userChoiceStartDate.textContent += displayDate(date1);
  userChoiceEndDate.textContent += displayDate(date2);
  const days = dayDiff(info.startStr, info.endStr)
  document.getElementById('days').textContent += days;
}


export { display };

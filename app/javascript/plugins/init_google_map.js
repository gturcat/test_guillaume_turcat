
const fitMapToMarkers = (map, markers) => {
  const bounds = new google.maps.LatLngBounds();
  for(var i = 0; i < markers.length; i++){
    bounds.extend(markers[i]);
   }
  map.fitBounds(bounds);
};

const addMarkers = (map) => {
  const mapElement = document.getElementById('map');
  const markers = JSON.parse(mapElement.dataset.markers);
  markers.forEach((marker) => {
  new google.maps.Marker({position: marker, map: map});
  });
  fitMapToMarkers(map, markers);
}

function initMaping() {
  // The location of Aix en provence
  var aix = {lat: 43.5, lng: 5.5};
  // The map,
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 10, center: aix});
  // The marker, positioned at france
  addMarkers(map);

}

export { initMaping };


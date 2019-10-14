function initMap() {
  // The location of Aix en provence
  var aix = {lat: 43, lng: 5};
  const mapElement = document.getElementById('map');
  const markers = JSON.parse(mapElement.dataset.markers);
  // The map, centered at Uluru
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 4, center: aix});
  // The marker, positioned at france

  markers.forEach((marker) => {
    new google.maps.Marker({position: marker, map: map});
  });

}

export { initMap };

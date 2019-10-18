const requestChannel = () => {

  App.cable.subscriptions.create (
    {
      channel: 'RequestChannel'
    },
    {
    received: function(nbreRequest) {
      console.log(nbreRequest.request);
      document.getElementById("admin").dataset.badge = nbreRequest.request;
      }
    }
  );
}

export { requestChannel }

class Trip {
  static all = []

  constructor({ id, name }) {
    this.name = name
    this.id = id
    Trip.all.push(this)
  }

  static create(tripName) {
    API.createTrip(tripName)
    .then(json => {
      if (json['errors']) {
        alert(json['errors'][0])
      } else {
        this.load(json)
        Loadable.loadTrips()
      }
    })
  }

  static show(tripId) {
    Day.clearDaysDiv()
    API.getTripData(tripId)
    .then(json => this.load(json))
  }

  static load(data) {
    const trip = new Trip(data)
    trip.setHTML()
    Togglable.toggleTripDiv()

    for (let day of data['days']) {
      Day.load(day)
    }
  }

  setHTML() {
    const tripNameHeader = document.querySelector('#trip-name')
    const tripDataDiv = document.querySelector('#trip-data')

    tripNameHeader.innerHTML = this.name
    tripDataDiv.dataset.tripId = this.id
  }
}
import Sortable from 'stimulus-sortable'

// Connects to data-controller="episode"
export default class extends Sortable {
  static values = { movie: Number }

  onUpdate(event) {
    super.onUpdate(event)
    const newIndex = event.newIndex
    const id = event.item.id
    const movieId = this.movieValue
    console.log("csrf token: ", document.querySelector('[name="csrf-token"]').content)
    fetch(`/admin/movies/${movieId}/episodes/${id}/move`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ position: newIndex, id: id })
    })
  }
}

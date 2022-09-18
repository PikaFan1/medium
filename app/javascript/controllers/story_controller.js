import { Controller } from "@hotwired/stimulus"
import { axios } from 'axios'

export default class extends Controller {
  static targets = ['loveCount']
  addLove(event) {
    event.preventDefault()
    let slug = event.currentTarget.dataset.slug

    // console.log('go')
    // this.loveCountTarget.innerHTML = 'kk'
    axios.post(`/stories/${slug}/love`)
         .then(function(response){
          console.log(response.data)
         })
         .catch(function(error){
          console.log(error)
         })
  }
}
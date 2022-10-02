import { Controller } from "@hotwired/stimulus"
import { axios } from 'axios'

export default class extends Controller {
  static targets = ['loveCount']
  addLove(event) {
    event.preventDefault()
    let slug = event.currentTarget.dataset.slug
    console.log(slug)
    let target = this.loveCountTarget

    // this.loveCountTarget.innerHTML = 'kk'
    axios.post(`/stories/${slug}/love`)
         .then(function(response){
          console.log(response)
          console.log('123')

          let status = response.data.status
          switch(status){
            case 'sign_in_first':
              alert ('你必須先登入')
              break
            default:
              target.innerHTML = status
          }
         })
         .catch(function(error){
          console.log(error)
         })
  }
}
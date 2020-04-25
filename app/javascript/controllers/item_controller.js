// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

  
import { Controller } from "stimulus"
import ax from "axios"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["icon"]

  initialize() {
    this.clicked = false;
  }
  
  heart(e) {
    e.preventDefault();

    

    const csrfToken = document.querySelector('[name=csrf-token]').content
    ax.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken
    // 解決找不到Token的問題，從頁面抓Token給他。

    // Rails.ajax({
    //   url: `/api/v1/items/${item_id}/favorite`,
    //   type: 'POST'
    //   success: resp => {
    //     console.log(resp);
    //   },
    //   error: err => {
    //     console.log(err);
    //   }
    // })
    // rails的寫法，可處理token問題。
    
    let item_id = document.querySelector('#item_id').value;
    // console.log('hi')

    

    ax.post(`/api/v1/items/${item_id}/favorite`)
      .then(resp => {
        if (resp.data.status === "favorited"){
          this.iconTarget.classList.remove('far');
          this.iconTarget.classList.add('fas');
        } else {
          this.iconTarget.classList.remove('fas');
          this.iconTarget.classList.add('far');
        }
        
      })
      .catch( err => {
        console.log(err);
    })


    // request

    // if (this.clicked) {
    //   this.iconTarget.classList.remove('fas')  // s = solid
    //   this.iconTarget.classList.add('far')     // r = regular
    //   this.clicked = false
    // } else {
    //   this.iconTarget.classList.remove('far')
    //   this.iconTarget.classList.add('fas')
    //   this.clicked = true
    // }
  }
}

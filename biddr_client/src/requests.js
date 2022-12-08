const baseURL = "http://localhost:3000/api/v1"

export const Auction = {
    index(){
      return fetch(`${baseURL}/auctions`)
     
      .then(response => {
        return response.json();
      })
    },

    create(params){
      return fetch(`${baseURL}/auctions`, {
        method: 'POST',
        credentials: 'include',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify(params)
      }).then(res => res.json())
    },
    
    show(id){
      return fetch(`${baseURL}/auctions/${id}`).then(res => res.json())
    }
}

export const Bid = {
    create(auction_id, params){
        return fetch(`${baseURL}/auctions/${auction_id}/bids`, {
            method: 'POST',
            credentials: 'include',
            headers: {
            'Content-type': 'application/json'
            },
            body: JSON.stringify(params)
        }).then(res => res.json())
    }  
}

export const Session = {
    create(params) {
      return fetch(`${baseURL}/session`, {
        method: 'POST',
        credentials: 'include',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify(params)
      }).then(res => res.json())
    },
    destroy() {
      return fetch(`${baseURL}/session`, {
        method: 'DELETE',
        credentials: 'include'
      }).then(res => res.json())
    },
    current() {
        return fetch(`${baseURL}/current_user`, {
          method: 'GET',
          credentials: 'include',
        })
        .then(res => res.json())
      },
    
}

export const User = {
  create(params){
    return fetch(`${baseURL}/users`, {
      method: 'POST',
      credentials:'include',
      headers: {
        'Content-type': 'application/json'
      },
      body: JSON.stringify({user: params})
    }).then(res => res.json())
  }
}







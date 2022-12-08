const NewBidForm = (props) => {

    const {errors, submitForm, currentAuction, currentUser} = props

    const getDataAndSubmit = (event) => {
        event.preventDefault()
        const formData = new FormData(event.currentTarget)
        submitForm(
            {
                bid_price: formData.get("bid_price"),
                auction_id: currentAuction,
                user_id: currentUser
            }
        )
        event.currentTarget.reset()
    }

    return(
        <form onSubmit={getDataAndSubmit}>
            <div>
                <label htmlFor="bid_price">Bid</label>
                <br />
                <input type="text" name="bid_price"/>
            </div>
            <div>
                <input type="submit" value="Submit" />
            </div>

        </form>   
    )
}

export default NewBidForm
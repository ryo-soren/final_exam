const NewAuctionForm = (props) => {

    const {errors, submitForm} = props

    const getDataAndSubmit = (event) => {
        event.preventDefault()
        const formData = new FormData(event.currentTarget)
        submitForm(
            {
                title: formData.get("title"),
                description: formData.get("description"),
                reserve_price: formData.get("reserve_price"),
                closing_date: formData.get("closing_date"),
            }
        )
        event.currentTarget.reset()
    }

    return(
        <form onSubmit={getDataAndSubmit}>
                {errors.length > 0 ? (
                        <div>
                            <h4>Invalid Entry</h4>
                            <p>{errors}</p>
                        </div>
                    ) : (
                        null
                    )
                }
            <div>
                <label htmlFor="title">Title</label>
                <br />
                <input type="text" name="title"/>
            </div>
            <div>
                <label htmlFor="description">description</label>
                <br />
                <input type="text" name="description"/>
            </div>
            <div>
                <label htmlFor="reserve_price">Reserve Price</label>
                <br />
                <input type="text" name="reserve_price"/>
            </div>
            <div>
                <label htmlFor="closing_date">Closing Date</label>
                <br />
                <input type="text" name="closing_date" placeholder="format: YYYY-MM-DD"/>
            </div>
            <div>
                <input type="submit" value="Submit" />
            </div>

        </form>   
    )
}

export default NewAuctionForm
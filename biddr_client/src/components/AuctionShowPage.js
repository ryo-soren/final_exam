import React from "react";
import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { useNavigate } from 'react-router-dom'
import { Auction } from "../requests";
import { Bid } from "../requests";
import NewBidForm from "./NewBidForm"


export function withRouter(Children) {
    return (props) => {
        const match = { params: useParams() };
        return <Children {...props} match={match} />;
    };
}

const AuctionShowPage = (props) => {
    const [auction, setAuction] = useState({})
    const [errors, setErrors] = useState([])

    let {id, title, description, reserve_price, seller_name, closing_date, created_at, bids} = auction
    const navigate = useNavigate()
    const {currentUser} = props

    const createNewBid = (params) => {
        Bid.create(id, params).then((bid) => {
            console.log(auction);
            if (bid.errors) {
                setErrors("Please make a valid entry")
            } else {
                Auction.show(props.match.params.id).then((updatedAuction) => {
                    setAuction(updatedAuction)
                })
                console.log(auction);
                navigate(`/auctions/${id}`)
            }
        })
    }

    useEffect(() => {
        Auction.show(props.match.params.id).then((fetchedAuction) => {
            setAuction(fetchedAuction)
        })
    }, [])

    return(
        <>
            <div>
                <h2>{title}</h2>
                <div>
                    <p>{description}</p>
                </div>
                <div>
                    <p><strong>${reserve_price}</strong></p>
                </div>
                <div>
                    <p><small>Posted: {created_at} By: {seller_name}</small></p>
                </div>
                <div>
                    <p><small>Closing: {closing_date}</small></p>
                </div>
            </div>
            {
                currentUser?(
                    <>
                    <NewBidForm currentAuction={id} errrors={errors} submitForm={(params) => createNewBid(params)}/>
                    </>
    
                ):(
                    null
                )
            }

            {
                bids?(
                    bids.map((bid, i) => {
                        return(
                            <div key={i}>
                                <hr></hr>
                                <div>
                                    <h3>${bid.bid_price}</h3>
                                </div>
                                <div>
                                    <div><small>By {bid.bidder}</small></div>
                                </div>
                            </div>                          
                        )
                    })
                ):(null)
            }
        
        </>

    )
}

export default withRouter(AuctionShowPage)
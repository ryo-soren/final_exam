import React from "react";
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { Auction } from "../requests";

export default function AuctionIndexPage(){
    const [auctions, setAuctions] = useState([])

    useEffect(() => {
        Auction.index().then((auctionsData) => {
            setAuctions(auctionsData)
        })
    }, [])

    return(
        <>
            {
                auctions.map((a, i) => {
                    return(
                        <div key={i}>
                        <Link to={`/auctions/${a.id}`}>{a.title}</Link>{" "}
                            <div>
                                <p>{a.description}</p>
                            </div>
                            <div>
                                <p><strong>${a.reserve_price}</strong></p>
                            </div>
                            <div>
                                <p><small>By: {a.seller}</small></p>
                            </div>
                        </div>   
                    )
                })
            }
        </>
    )
}
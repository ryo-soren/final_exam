import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Auction } from "../requests";
import NewAuctionForm from "./NewAuctionForm";

export default function NewAuctionPage(){
    const [errors, setErrors] = useState([])

    const navigate = useNavigate()

    const createNewAuction = (params) => {
        Auction.create(params).then((auction) => {
            if (auction.errors) {
                setErrors("Please make a valid entry")
            } else {
                console.log(auction);
                navigate(`/auctions/${auction.id}`)
            }
        })
    }

    return(
        <div>
            <NewAuctionForm errors={errors} submitForm={(params) => createNewAuction(params)} />
        </div>
    )
}
import { NavLink } from "react-router-dom";
import { Session } from "../requests";

const NavBar = (props) => {
    
    const {currentUser, onSignOut, name} = props

    const signOut = () => {
        Session.destroy().then(() => {
            onSignOut()
        })
    }

    return(
            <nav>
                <NavLink to='/'>Home</NavLink>
                |
                <NavLink to='/auctions'>auctions</NavLink>
                |
                {
                    currentUser?(
                        <>
                        <NavLink to='/auctions/new'>New Auction</NavLink>
                        <span>|</span>
                        <span>Hello {name}</span>
                        <span>|</span>
                        <button onClick={signOut}>Sign Out</button>
                        </>
                    ):(
                        <>
                            <NavLink to='/sign_in'>Sign In</NavLink>
                            <span>|</span>
                            <NavLink to='/sign_up'>Sign Up</NavLink>
                        </>
                    )
                }
            </nav>
        )
}

export default NavBar
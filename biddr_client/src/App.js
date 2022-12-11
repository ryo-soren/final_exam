import { Route, Routes } from "react-router-dom";
import {useState, useEffect} from "react"
import { Session } from "./requests";
import NavBar from "./components/NavBar";
import HomePage from "./components/HomePage";
import AuctionIndexPage from "./components/AuctionIndexPage";
import AuctionShowPage from "./components/AuctionShowPage";
import SignInPage from "./components/SignInPage";
import SignUpPage from "./components/SignUpPage";
import NewAuctionPage from "./components/NewAuctionPage";
import AuthRoutes from "./components/AuthRoutes";

function App() {
  const [user, setUser] = useState(null);

  useEffect(() => {
      getCurrentUser();
  }, [])

  const getCurrentUser = () => {
      Session.current().then((user) => {
          console.log(user);
          if(user?.id){
              setUser(user)
          }
      })
  }

  const onSignOut = () => {
      setUser(null)
  }

  return (
    <>
      <NavBar
        onSignOut = {onSignOut}
        currentUser = {user}
        name = {user?.name}
      />

      <Routes>
        <Route exact path="/" element={
          <HomePage/> 
        }/>

        <Route exact path="/auctions" element={
          <AuctionIndexPage/>
        }/>

        <Route path="/auctions/:id" element={
          <AuctionShowPage
            currentUser={user}
          />
        }/>

        <Route exact path="/sign_in" element={
          <SignInPage
            onSignIn={
              getCurrentUser
            }
          />
        }/>

        <Route element={<AuthRoutes isAuthenticated={!!user}/>}>
          <Route exact path="/auctions/new" element={<NewAuctionPage/>} />
        </Route>
        
        <Route exact path="/sign_up" element={
          <SignUpPage
            onCreate = {
              getCurrentUser
            }
          />
        } />
        

      </Routes>
    </>

  );
}

export default App;

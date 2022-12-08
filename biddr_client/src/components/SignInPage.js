import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Session } from "../requests";

function SignInPage(props) {
    const {onSignIn} = props;

    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [errors, setErrors] = useState([])

    const navigate = useNavigate()

    const handleSubmit = (event) => {
        event.preventDefault()
        const params = {
            email: email,
            password: password,
        };

        Session.create(params).then((data) => {
            if (data.status === 404) {
                setErrors("Wrong email or password")
            } else if (data.id){
                onSignIn()
                navigate("/auctions")
            }
        })
    }

    return(
        <main>
            <form onSubmit={handleSubmit}>
                {errors.length > 0 ? (
                        <div>
                            <h4>Failed to Sign In</h4>
                            <p>{errors}</p>
                        </div>
                    ) : (
                        null
                    )
                }
                <div>
                    <label htmlFor="email">Email</label>
                    <input type="text" name="email" id="email" onChange={event => {
                        setEmail(event.currentTarget.value)
                    }}/>
                </div>

                <div>
                    <label htmlFor="password">Password</label>
                    <input type="password" name="password" id="password" onChange={event => {
                        setPassword(event.currentTarget.value)
                    }}/>
                </div>

                <input type="submit" value="sign in"/>
            </form>
        </main>
    )
}

export default SignInPage
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { User } from "../requests";

function SignUpPage(props) {
    const {onCreate} = props;

    const [name, setName] = useState('')
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [password_confirmation, setPassword_confirmation] = useState('')
    const [errors, setErrors] = useState([])

    const navigate = useNavigate()

    const handleSubmit = (event) => {
        event.preventDefault()
        const params = {
            name: name,
            email: email,
            password: password,
            password_confirmation: password_confirmation
        };

        User.create(params).then((data) => {
            if (data.status === 404) {
                setErrors("Please make a valid entry")
            } else if (data.id){
                onCreate()
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
                    <label htmlFor="name">Name</label>
                    <input type="text" name="name" id="name" onChange={event => {
                        setName(event.currentTarget.value)
                    }}/>
                </div>

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

                <div>
                    <label htmlFor="password_confirmation">Password Confirmation</label>
                    <input type="password" name="password_confirmation" id="password_confirmation" onChange={event => {
                        setPassword_confirmation(event.currentTarget.value)
                    }}/>
                </div>

                <input type="submit" value="sign in"/>
            </form>
        </main>
    )
}

export default SignUpPage
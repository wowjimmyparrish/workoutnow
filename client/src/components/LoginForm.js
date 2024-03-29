import React, { useState, useContext } from "react";
import { UserContext } from "../context/user";
import { useHistory } from "react-router-dom";

function LoginForm({ setUserWorkouts, setUserReviews }) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [errors, setErrors] = useState([]);
  const { setUser } = useContext(UserContext);

  const history = useHistory();

  function handleSubmit(e) {
    e.preventDefault();
    fetch("/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ username, password }),
    }).then((r) => {
      if (r.ok) {
        r.json().then((user) => {
          setUserWorkouts(user.created_workouts);
          setUserReviews(user.reviews);
          setUser(user);
          history.push("/");
        });
      } else {
        r.json().then((errorData) => setErrors(errorData.error));
      }
    });
  }
  return (
    <form
      className="d-flex justify-content-center flex-column align-items-center"
      onSubmit={handleSubmit}
    >
      <h5 className="text-white">Username</h5>
      <input
        className="m-1"
        type="text"
        id="username"
        autoComplete="off"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
      />
      <h5 className="text-white">Password</h5>
      <input
        className="m-1"
        type="password"
        id="password"
        autoComplete="current-password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />

      <button className="btn btn-primary m-2" type="submit">
        Login
      </button>
      <p style={{ color: "red" }}>{errors}</p>
    </form>
  );
}

export default LoginForm;

import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Blogs from "../components/Blogs";

export default function index()
{
	const [userData, setUserData] = useState({ login: "" });
	const url = "/api/v1/auth/data";
	fetch(url).then((response) => {
		if(response.ok) {
			return response.json();
		}
		throw new Error("Network response was not ok.");
	}).then((response) => setUserData(response));
		// get user data here
		// then pass it in as 'props' into the components
	return (<>
	    <h1>{userData.login}</h1>
		<Router>
			<Routes>
				<Route path="/" element = {<Home />} />
				<Route path="/blogs" element={<Blogs />} />
			</Routes>
		</Router>
	</>);
}

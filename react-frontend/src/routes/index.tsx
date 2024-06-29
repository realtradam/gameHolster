import { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../pages/Home";
import Layout from "../components/Layout";
import CloseWindow from "../pages/CloseWindow";

export type UserType = { name: string };

export default function Index()
{

	const [userData, setUserData] = useState<UserType>({ name: '' });
	useEffect(() => {
		const update_login_status = () => {
			//localStorage.removeItem("logged in trigger");
			const url = `${import.meta.env.VITE_API_TITLE}/api/v1/auth/data`;
			try { fetch(url, {
				credentials: "include"
			}).then((response) => {
				if(response.ok) {
					return response.json();
				}
				//throw new Error("Network response was not ok.");
			}).then((response) => response && setUserData(response.user_data)).catch((err) => { console.log(err); });}
			catch(err) { console.log(err); }
		};
		window.addEventListener('storage', update_login_status );
		update_login_status();
		return () => { window.removeEventListener('storage', update_login_status); };
	}, []);

	return (<>
				<Router>
					<Routes>
						<Route path="/" element = {<Layout userData={userData} setUserData={setUserData}/>}>
							<Route index element={<Home />} />
							<Route path="/closewindow" element={<CloseWindow />} />
						</Route>
					</Routes>
				</Router>
			</>);
}

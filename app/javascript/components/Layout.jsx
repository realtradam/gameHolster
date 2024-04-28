import React from "react";
import { Outlet, Link } from "react-router-dom";

export default function Layout ({userData}) 
{
	//console.log(userData);
	//const [userData, setUserData] = useState({ login: "" });
	return (
	<>
		<div className="flex flex-row h-screen bg-slate-800 text-slate-100">
		<nav className="flex flex-row h-full w-64 p-4 gap-4 items-center">
			<div className="h-full flex flex-col">
				<div>Logged in as: {userData.login}</div>
				<div className="text-4xl py-12">Adam Malczewski</div>
				<div className="flex flex-row justify-center w-full block grow">
				<div className="block grow">	
               	 <ul className="navbar-nav">
						<li className="text-center">
							<Link
							to="/"
							className="hover:text-slate-100/50 underline"
							role="button"
							>
								Home
							</Link>
						</li>
						<li className="text-center">
							<Link
							to="/blogs"
							className="hover:text-slate-100/50 underline"
							role="button"
							>
								Blog
							</Link>
						</li>
						<li className="text-center">
							<Link
							to="/games"
							className="hover:text-slate-100/50 underline"
							role="button"
							>
								Games
							</Link>
						</li>
					</ul>
				</div>
			</div>
			</div>
			<div className="h-3/4 w-0.5 bg-slate-500 block rounded-full">
			</div>
		</nav>
	<Outlet />
		</div>
</>
	)
};

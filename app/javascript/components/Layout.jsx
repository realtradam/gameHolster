import React from "react";
import { Outlet, Link } from "react-router-dom";
import Button from "./Button";
export default function Layout ({userData}) 
{
	console.log(userData);
	//const [userData, setUserData] = useState({ name: "" });
	return (
	<>
		<div id="page" className="star flex flex-row min-h-screen bg-amber-400 text-stone-950 bg-star bg-repeat bg-[length:170px_170px]">
			<div id="sidebar" className="flex flex-row h-screen fixed w-64 items-center bg-stone-800">
				<nav id="sidebar-content" className=" text-stone-50 p-6 w-full h-screen">
					{ userData.name ? <div> Logged in as: {userData.name} </div> : <a href="https://github.com/login/oauth/authorize?client_id=74468ad0847e527262d9"> Login with Github </a> }
					<div className="text-4xl py-12">Adam Malczewski</div>
					<div className="flex flex-col items-center gap-1 w-full">
							<Button link={ <Link to="/" className="text-stone-50 bg-transparent" role="button">Home</Link> }/>
							<Button link={ <Link to="/blogs" className="text-stone-50 bg-transparent" role="button">Blog</Link> }/>
							<Button link={ <Link to="/games" className="text-stone-50 bg-transparent" role="button">Games</Link> }/>
							<Button link={ <div className="text-stone-50 bg-transparent w-36 h-16 flex justify-center items-center">
								<a id="contact" href="mailto:adam@malcz.com" className="w-36 h-16 relative text-center whitespace-nowrap flex p-4">
								<span className="contact pt-1 pl-[27px]">Contact</span>
								<span className="contact pt-[7px] left-0 pl-3 text-sm">Adam@Malcz.com</span>
								</a>	
								</div> }/>
					</div>
				</nav>
				<div id="sawtooth-wrap" className="sawtooth-left-wrap h-full">
					<div id="sawtooth" className="sawtooth-left w-4 h-full bg-amber-400"></div>
				</div>
			</div>
			<div id="fake-sidebar" className="w-64 invisible"></div>
			<div id="radial-wrap" className="flex-grow">
				<div id="content" className=""></div>
			</div>
		</div>

		<div style={{display: 'none'}} className="">
		<nav className="">
			<div className="h-full flex flex-col bg-stone-900 text-stone-50">
		{ userData.name ? <div> Logged in as: {userData.name} </div> : <a href="https://github.com/login/oauth/authorize?client_id=74468ad0847e527262d9"> Login with Github </a> } 
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
			<div className="sawtooth-right w-6 h-full block bg-zinc-800">
			</div>
		</nav>
	<Outlet />
		</div>
		</>
	)
};

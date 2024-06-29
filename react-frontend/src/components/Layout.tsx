import { Dispatch, useState } from 'react';
import { Outlet, Link, useNavigate } from "react-router-dom";
import { IconButton, Button, ButtonGroup } from 'rsuite';
import { Icon } from '@rsuite/icons';
import { FaUser } from "react-icons/fa6";
import { FaGamepad } from "react-icons/fa";
import { GiCowboyHolster } from "react-icons/gi";
import { GrAdd } from "react-icons/gr";
import { FaChevronRight } from "react-icons/fa";
import { FaChevronLeft } from "react-icons/fa";
import { UserType } from "../routes/index";

export type userData = { name: string };


export default function Layout(prop : { userData: userData, setUserData : Dispatch<UserType> })
{
	const navigate = useNavigate();

	const loginLink = () => {
		window.open(`https://github.com/login/oauth/authorize?client_id=${import.meta.env.VITE_GITHUB_CLIENTID}`);
	};

	const logoutLink = () => {
		fetch(`${import.meta.env.VITE_API_TITLE}/api/v1/auth/logout`, { credentials: "include" }).then(function() {
			prop.setUserData({name: ""})
			navigate('/');
		});
	};


	const loggedout_element = <IconButton onClick={loginLink} appearance="primary" color="green" icon={<Icon as={FaUser}/>}>Log In</IconButton>;
	const loggedin_element = <ButtonGroup className="flex"><Button appearance="ghost" color="red" style={{width:"100%"}}>{prop.userData.name}</Button><Button onClick={logoutLink} appearance="subtle" style={{paddingLeft:"1.4em", paddingRight:"1.4em"}}>Log Out</Button></ButtonGroup>;

	const [sidebarOpen, setSidebarOpen] = useState(false);
	const [sidebarClosed, setSidebarClosed] = useState(false);
	const [sidebarInit, setSidebarInit] = useState(true);
	const handleSidebarOpen = () => {
		if(sidebarInit) {
			setSidebarOpen(true);
			setSidebarInit(false);
		}
		else {
			setSidebarOpen(!sidebarOpen);
			setSidebarClosed(!sidebarClosed);
		}
	};
	const handleSidebarClickaway = () => {
		if(!sidebarInit)
			{
				setSidebarOpen(false);
				setSidebarClosed(true);
			}
	};

	return(
		<>
			<div onClick={handleSidebarOpen} className={`${sidebarOpen ? 'sidebarOpen' : ''} ${sidebarClosed ? 'sidebarClosed' : ''} ${sidebarInit ? 'sidebarInit' : ''} sidebar-animation flex items-center justify-center md:hidden fixed shadow-xl ml-[19rem] m-4 h-12 w-12 text-stone-50 bg-red-800 rounded-[5px] z-[5]`}>
				<div className={`${sidebarClosed || sidebarInit ? '' : 'hidden'} flex items-center justify-center`}>
					<Icon as={FaChevronRight}/>
				</div>
				<div className={`${sidebarOpen ? '' : 'hidden'} flex items-center justify-center`}>
					<Icon as={FaChevronLeft}/>
				</div>
			</div>
			<div className="w-screen h-screen flex border-none">
				<div className={`md:block hidden flex flex-col h-full overflow-y-auto overflow-x-hidden w-72 shrink-0 bg-stone-100`}>
				</div>
				<div className={`${sidebarOpen ? 'sidebarOpen' : ''} ${sidebarClosed ? 'sidebarClosed' : ''} ${sidebarInit ? 'sidebarInit' : ''} z-[5] sidebar-animation flex flex-col h-screen overflow-y-auto overflow-x-hidden w-72 shrink-0 bg-stone-100 fixed`}>
					<div className="flex flex-col bg-stone-800">
						<div className="m-4 mb-0 flex flex-col flex-grow">
							{ prop.userData.name ? loggedin_element : loggedout_element }
						</div>
					</div>
						<Link to="/" role="button">
					<div className="border-green-500 p-2 text-red-700 bg-stone-800">
							<Icon as={GiCowboyHolster} style={{width:"100%", height:"100%"}}/>
					</div>
					<div className="border-green-500 p-2 mb-2 text-white font-title text-2xl text-center bg-stone-800 rounded-b-xl">
						Game Holster
					</div>
						</Link>
					<div className="flex flex-col px-4 gap-2">
						<Link to="/games" role="button">
							<IconButton style={{width: '100%'}} appearance="subtle" size="lg" icon={<Icon as={FaGamepad}/>}>Browse Games</IconButton>
						</Link>
						<IconButton appearance="subtle" size="lg" icon={<Icon as={GrAdd}/>}>Upload Game</IconButton>
					</div>
				</div>
				<div className="w-full">
					<Outlet/>
				</div>
			</div>
		</>
	);
}

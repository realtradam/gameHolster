import { Dispatch } from 'react';
import { Outlet, useNavigate } from "react-router-dom";
import { IconButton, Button, ButtonGroup } from 'rsuite';
import { Icon } from '@rsuite/icons';
import { FaUser } from "react-icons/fa6";
import { FaGamepad } from "react-icons/fa";
import { GiCowboyHolster } from "react-icons/gi";
import { GrAdd } from "react-icons/gr";
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
	const loggedin_element = <ButtonGroup className="flex"><Button appearance="ghost" style={{width:"100%"}}>{prop.userData.name}</Button><Button onClick={logoutLink} appearance="subtle" style={{paddingLeft:"1.4em", paddingRight:"1.4em"}}>Log Out</Button></ButtonGroup>;

	console.log(prop);

	return(
		<>
			<div className="w-screen h-screen flex border-none">
				<div className="flex flex-col h-screen overflow-y-auto overflow-x-hidden w-72 bg-stone-100">
					<div className="flex flex-col bg-stone-800">
					<div className="m-4 mb-0 flex flex-col flex-grow">
						{ prop.userData.name ? loggedin_element : loggedout_element }
					</div>
					</div>
					<div className="border-green-500 p-2 mb-2 text-red-700 bg-stone-800 rounded-b-xl"><Icon as={GiCowboyHolster} style={{width:"100%", height:"100%"}}/></div>
					<div className="flex flex-col px-4 gap-2">
						<IconButton appearance="subtle" size="lg" icon={<Icon as={FaGamepad}/>}>Browse Games</IconButton>
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

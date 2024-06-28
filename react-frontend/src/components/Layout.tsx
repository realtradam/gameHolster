import { Outlet } from "react-router-dom";
import { IconButton, Button, ButtonGroup } from 'rsuite';
import { Icon } from '@rsuite/icons';
import { FaUser } from "react-icons/fa6";
import { FaGamepad } from "react-icons/fa";
import { GiCowboyHolster } from "react-icons/gi";
import { GrAdd } from "react-icons/gr";

export type userData = { userData: { name: string } };

						//{ userData.name ? <div className="flex items-end gap-2 pb-2"> <div className="text-xs"> Logged in as: </div> <div>{userData.name}</div> </div> : <a href="" onClick={loginLink} className="pb-2"> Login with Github </a> }


export default function Layout({userData} : userData)
{
	const loginLink = () => {
		window.open(`https://github.com/login/oauth/authorize?client_id=${import.meta.env.VITE_GITHUB_CLIENTID}`);
	};


	const loggedout_element = <IconButton onClick={loginLink} appearance="primary" color="green" icon={<Icon as={FaUser}/>}>Log In</IconButton>;
	const loggedin_element = <ButtonGroup className="flex"><Button appearance="ghost" style={{width:"100%"}}>{userData.name}</Button><Button appearance="subtle" style={{paddingLeft:"1.4em", paddingRight:"1.4em"}}>Log Out</Button></ButtonGroup>;

	return(
		<>
			<div className="w-screen h-screen flex border-none">
				<div className="flex flex-col h-screen overflow-y-auto overflow-x-hidden w-72 bg-stone-100">
					<div className="flex flex-col bg-stone-800">
					<div className="m-4 mb-0 flex flex-col flex-grow">
						{ userData.name ? loggedin_element : loggedout_element }
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

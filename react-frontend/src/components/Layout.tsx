import { Outlet } from "react-router-dom";

export default function Layout()
{
	return(
		<>
			<div>sidebar</div>
			<Outlet/>
		</>
	);
}

import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { GameType } from "../components/GameCard";

export default function Games () {
	const { path_game, path_user } = useParams();
	const [gameData, setGameData] = useState<GameType>();

	useEffect(() => {
		const url = `${import.meta.env.VITE_API_TITLE}/api/v1/games/${path_user}/${path_game}`;
		fetch(url).then((response) => {
			if (response.ok) {
				return response.json();
			}
			throw new Error("Network response was not ok.");
		}).then((response) => setGameData(response)); //.catch(() => navigate("/"));
	}, [path_game, path_user]);

	return(
		<>
		<h1>blah</h1>
		</>
	);

}

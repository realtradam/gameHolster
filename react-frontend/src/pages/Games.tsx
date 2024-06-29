import { useState, useEffect } from "react";
import GameCard from "../components/GameCard";

export default function Games () {
	const [games, setGames] = useState<GameType[]>([]);

	useEffect(() => {
		const url = `${import.meta.env.VITE_API_TITLE}/api/v1/games`;
		fetch(url).then((response) => {
			if (response.ok) {
				return response.json();
			}
			throw new Error("Network response was not ok.");
		}).then((response) => setGames(response)); //.catch(() => navigate("/"));
	}, []);

	const allGames = games.map((game) => (
		<GameCard link={`/game/${game.user.user_name}/${game.titleSlug}`} game={game} key={game.id}/>
	));

	return (
		<>
			<div className="w-full flex flex-wrap gap-12 justify-center">
			{ allGames }
			</div>
		</>
	);
}

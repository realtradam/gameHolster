import React, { useState, useEffect } from "react";
//import { Link } from "react-router-dom";
import GameCard from "./GameCard";

//export default () => (
export default function Games () {
	const [games, setGames] = useState([]);
	useEffect(() => {
		const url = "/api/v1/games/index";
		fetch(url).then((response) => {
			if (response.ok) {
				return response.json();
			}
			throw new Error("Network response was not ok.");
		}).then((response) => setGames(response)).catch(() => navigate("/"));
	}, []);
	const allGames = games.map((games, index) => (
		<div>{ blog }</div>
	));
	var handleSubmit = (e) => {
		e.preventDefault() //stops submit from happening

		const formData = new FormData()
		formData.append('game[title]', e.target.title.value)
		formData.append('game[game_file]', e.target.game_file.files[0], e.target.game_file.value)

		for (var pair of formData.entries()) {
			console.log(pair[0] + ', ' + pair[1])
		};

		fetch('http://127.0.0.1:3000/api/v1/games', {
			method: 'post',
			body: formData,
		});
	}
	return(
		<>
		<div>
		<div className="flex flex-col gap-16 max-w-6xl shrink">
			<div className="title font-bold text-6xl font-title">Games</div>
			<div className="">
				<div className="jumbotron jumbotron-fluid bg-transparent">
					<div className="container secondary-color">
				<form onSubmit={handleSubmit} action="/upload" method="post" className="flex flex-col gap-4">
				<div>
				<label>Title</label>
				<input type="text" name="title" />
				</div>
				<div>
				<label>File</label>
				<input type="file" name="game_file" />
				</div>
				<button type="submit" className="w-32 bg-stone-900 text-stone-50 rounded">submit</button>
				</form>
				</div>
		</div>
			</div>
			{ allGames }
			<div className="flex flex-row flex-wrap gap-20 justify-around">
				<GameCard />
				<GameCard />
				<GameCard />
				<GameCard />
				<GameCard />
				<GameCard />
			</div>
		</div>
		</div>
		</>
	);
};

import React, { } from "react";
//import { Link } from "react-router-dom";
import GameCard from "./GameCard";

//export default () => (
export default function Home () {
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
			<div className="title font-bold text-6xl font-title">Get To Know Me a Little</div>
			<div className="">
				<div className="jumbotron jumbotron-fluid bg-transparent">
					<div className="container secondary-color">
						<h1 className="text-2xl">Debug!</h1>
						<p className="">
Ea optio vitae culpa voluptatem consectetur. Ab quisquam sed ipsum. Perspiciatis minus odit quas qui consequuntur dicta reiciendis a. Nihil minima sed aliquam.
		</p>
						<hr className="my-4" />
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

import React from "react";
//import { Link } from "react-router-dom";

export default function GameCard ({ link = "./", width = "72" }) 
{
	return (
		<>
		<a href={ link } className="block w-min pt-10 px-1" target="_blank">
			<div className="gameCard">
				<div className="gameCardWrapper">
					<img src="https://ggayane.github.io/css-experiments/cards/dark_rider-cover.jpg" className="gameCardCoverImg" />
				</div>
					<img src="https://ggayane.github.io/css-experiments/cards/dark_rider-title.png" className="gameTitleImg p-5%" />
					<img src="https://ggayane.github.io/css-experiments/cards/dark_rider-character.webp" className="gameCharacterImg" />
			</div>
		</a>
		</>
	)
};

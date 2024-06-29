import { Link } from "react-router-dom";

export type ImageRendering = "auto" | "crisp-edges" | "pixelated";
export type Tag = {
	id: number,
	tag_type: string,
	name: string,
};
export type BasicUser = { id: number, user_name: string };
export type GameType = {
	id: number,
	title: string,
	titleSlug: string,
	description: string,
	github_link: string,
	img_rendering: ImageRendering,
	status: string,
	order: number,
	created_at: string,
	updated_at: string,
	tags: Tag[],
	card_img: string,
	char_img: string,
	title_img: string,
	user: BasicUser,
};
export type GameCardProps = { link: string, game: GameType };

export default function GameCard ({ link, game }: GameCardProps)
{
	return (
		<>
		<Link to={ link } role="button" className="block w-min pt-10 px-1">
			<div className="gameCard">
				<div className="gameCardWrapper">
					<img style={{imageRendering: game.img_rendering}} src={`${import.meta.env.VITE_API_TITLE}/api/v1/games_img/realtradam/${game.titleSlug}.png?type=card`} className="gameCardCoverImg" />
				</div>
					<img style={{imageRendering: game.img_rendering}} src={`${import.meta.env.VITE_API_TITLE}/api/v1/games_img/realtradam/${game.titleSlug}.png?type=title`} className="gameTitleImg p-5%" />
					<img style={{imageRendering: game.img_rendering}} src={`${import.meta.env.VITE_API_TITLE}/api/v1/games_img/realtradam/${game.titleSlug}.png?type=char`} className="gameCharacterImg" />
			</div>
		</Link>
		</>
	);
}

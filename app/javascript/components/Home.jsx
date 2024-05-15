import React, { } from "react";
import { Link } from "react-router-dom";

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
	  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Games!</h1>
        <p className="lead">
			All the games I have worked on that run on the web!
        </p>
        <hr className="my-4" />
        <Link
          to="/games"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Games
        </Link>
      </div>
	<form onSubmit={handleSubmit} action="/upload" method="post">
		<label>Title</label>
		<input type="text" name="title" />
		<label>File</label>
		<input type="file" name="game_file" />

		<button type="submit">submit</button>
	</form>
    </div>
  </div>
	  </>
);
};

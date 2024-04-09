import React from "react";
import { Link } from "react-router-dom";

export default () => (
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
        <Link
          to="/blogs"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Blogs
        </Link>
      </div>
    </div>
  </div>
);

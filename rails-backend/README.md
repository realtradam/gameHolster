# Game Holster

Game holster is a full-stack Ruby on Rails and React application for uploading and serving web games made with common game engines such as Unity, Godot, Raylib, and more.

Currently implemented features in the backend are:
- User authentication: users can log in using GitHub OAuth
- Game Upload: Once a user is logged in they can upload a game which will then belong to them
- Game Serving: Games can be played by users. The games are served under a different domain in order to make XSS attacks impossible in-case a user uploads compromised files.

The front-end is temporarily my [personal website](https://malcz.com/games) which is made using React. However I am working on a new React frontend in order to have this application be completely standalone and more accessible.

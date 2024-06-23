# [Bubbles, Behind](https://github.com/realtradam/TOJam2023)

## Controls

### Keyboard
- WASD - Movement

### Controller
Left Joystick - Movement

## Tech Stack
C and a home-made custom game engine with BGFX

## Description

This game was made in 3 days with the collaboration of my friend [Arnold](https://github.com/arngo). We set out to build a game with my woefully unprepared prototype game engine and managed to stick the landing!

I really enjoy the story on this project because halfway through the project the game engine unexpected brought up a massive bug which made the game entirely unplayable. Luckily through my knowledge of rendering and how I had built up my engine I was able to pinpoint the issue and resolve it before the tight deadline.

The second interesting thing that happened was a bug which would randomly crash the game after an indeterminate amount of time. This bug had been discovered mere minutes before the deadline however we were able to cover up the bug to players of the game in a very clever way. We set up a bash script which would run in a loop and this script would sleep for a couple seconds and then launch the game. Why would we have a delay to relaunch the game? We set up a full screen window on the PC of an image saying "Game Over". Whenever the game would crash this image would immediately become visible, the players would see it and incorrectly assume they had "died" in the game and then the game would relaunch. The game would launch also in fullscreen so it would go on top of this image. And so no one was aware at all of any bug or crash happening. Hilarious.

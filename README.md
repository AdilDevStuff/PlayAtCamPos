# PlayAtCamPos
A godot 4.X addon that enables you to play the game at editor camera's current position in 3D.

https://github.com/AdilDevStuff/PlayAtCamPos/assets/94475453/80978472-c3d5-4cfd-a9e8-fa93ba938eec

# How it works?
Its a pretty simple addon. If you have used roblox studio before, there's a button called `Play Here` which plays the game at camera's current position. This plugin basically brings that button in godot. In simple words, it sets the player's position to the editor's camera position and then launch the current scene.

# How To Use:
- Make sure plugin is enabled in the Project Settings > Plugins
- Add any group to your target, for example `player`
- Go anywhere in the scene and press `Play Here` button on top right corner of the screen.
- By default, it just follows the position of the editor's viewport camera
- You can enable the `follow_rotation` option from Settings window right next to the player button to make it follow rotation as well.

# Limitations:
- ~Currently this works only with Characterbody3D as the player. Maybe i will let the user set the player's type in the future. Currently, it searches for the `CharacterBody3D` class in the last edited scene and changes its position to editor's 3D viewport camera.~ **(NOW POSSIBLE)**
- It just copies the position of the main viewport camera, so if there are 4 views open, it will copy the first (main) viewport camera's position or rotation.
- ~There should be only one `CharacterBody3D` in the scene to make it work currently. I will find a way to make it work with given target in future (Prob. with groups).~ **(NOW POSSIBLE)**

# How To Install
1. Download the `PlayAtCamPos` folder from releases.
2. Copy the folder to `res://addons` in your godot project. The directory should look like this -> `res://addons/PlayAtCamPos`
3. Go to `Project settings` -> `Plugins` and enable the plugin there 
4. Done!

Any contributions will be highly appreciated!

**Available with
MIT License**

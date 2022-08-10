# Godot DollyCam
 A simple dolly cam class for Godot

# How to use
 Simply place the DollyCam.gd script anywwhere in your Godot Project and then instance a Dolly node
 
 You can create the track in which the camera will move in the same way as you'd create any other 3D Path.
 
# Properties:
 Camera Path: Path to the node that will follow the dolly. If none is provided, then it will create a new default Camera node and set it as the current camera
 
 Target Path: Path to the node that the Dolly will attempt to follow.
 
 Look At Target: If it is set to true, then the Camera will always point directly towards the Target node
 
 Frozen: If it is set to true, then the Dolly will not move
 
 Interpolation Speed: Speed at which the Camera's transform will be interpolated towards the Dolly. If set to 0, it will be instant.
 
 Camera Position Offset: Offset that will be added to the Camera's translation.
 
 Camera Rotation Degrees: Angle by which to rotate the camera (in degrees).

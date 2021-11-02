# maria_third_person

An improved third-person GZDoom mod based on [Cacodemon345's Zscript Chasecam](https://forum.zdoom.org/viewtopic.php?f=43&t=63361) and [Precise Crosshair](https://github.com/mmaulwurff/precise-crosshair).

It also uses a blender-modified version of the [Silent Hill 2 Maria Model](https://sketchfab.com/3d-models/maria-silent-hill-2-9ce11e427ba649cd95a8428a0add59cf), exported with [Nash Muhandes' md3 exporter](https://github.com/nashmuhandes/io_export_gzdoom_md3/tree/neo_blender).

### Instructions

* Download this repo as a .zip.
* Don't extract it.
* Just run gzdoom with the -file command-line argument or use the mod launcher of your preference, just put maria_third_person.zip last in the load order.

### Features
(Not available in other third-person mods)

* You can switch back to the first-person using the "DEL" key.
* You can change the camera distance using "<" and ">".
* You can access the front-view using the mouse scroll button.
* You can use my maria.blend, MODELDEF and zscript as a reference for using your own model.

### Notes

The chasecam is not the same as the default chase CVar (Preference), avoid turning it on and off, as it can lead to conflicts.

### Future

I'll keep working to improve the overall third-person experience with 3D models using this repo,
maybe I'll add some setup options on the menu.
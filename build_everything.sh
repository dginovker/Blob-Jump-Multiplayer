# Build the server
~/Downloads/Godot_v4.5-beta2_linux.x86_64 --headless --export-debug "Linux"

# Build the webclient
rm build.zip
rm build/index.html ; ~/Downloads/Godot_v4.5-beta2_linux.x86_64 --headless --export-debug "Web" ./build/index.html ; 

# Package the build for itch.io
zip -r build.zip build 

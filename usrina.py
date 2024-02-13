from ursina import *

# create a window
app = Ursina()


player = Entity(model='cube', color=color.orange, scale_y=2)

# create a function called 'update'.
# this will automatically get called by the engine every frame.
def update():
    player.x += held_keys['d'] * time.dt
    player.x -= held_keys['a'] * time.dt

#called on keypress
def input(key):
    if key == 'space':
        player.y += 1
        invoke(setattr, player, 'y', player.y-1, delay=.25)


# start running the game
app.run()
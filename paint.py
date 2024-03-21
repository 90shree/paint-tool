import tkinter as tk
from tkinter import colorchooser

def paint(event):
    x1, y1 = (event.x - brush_size), (event.y - brush_size)
    x2, y2 = (event.x + brush_size), (event.y + brush_size)
    canvas.create_oval(x1, y1, x2, y2, fill=brush_color, outline=brush_color)

def choose_color():
    global brush_color
    brush_color = colorchooser.askcolor(color=brush_color)[1]

def change_brush_size(size):
    global brush_size
    brush_size = int(size)

def clear_canvas():
    canvas.delete("all")

def decrease_brush_size(event):
    global brush_size
    if brush_size > 1:
        brush_size -= 1
        size_scale.set(brush_size)

def increase_brush_size(event):
    global brush_size
    if brush_size < 50:
        brush_size += 1
        size_scale.set(brush_size)

root = tk.Tk()
root.title("paint tool")

brush_size = 3
brush_color = "black"

canvas = tk.Canvas(root, bg="white", width=600, height=400)
canvas.pack(pady=20)

color_button = tk.Button(root, text="Color", command=choose_color)
color_button.pack(side=tk.LEFT)

clear_button = tk.Button(root, text="Clear", command=clear_canvas)
clear_button.pack(side=tk.RIGHT)

size_label = tk.Label(root, text="Brush size:")
size_label.pack(side=tk.LEFT)
size_scale = tk.Scale(root, from_=1, to=50, orient=tk.HORIZONTAL, command=change_brush_size)
size_scale.pack(side=tk.LEFT)

canvas.bind("<B1-Motion>", paint)

root.bind("<KeyPress-minus>", decrease_brush_size)
root.bind("<KeyPress-plus>", increase_brush_size)

root.mainloop()

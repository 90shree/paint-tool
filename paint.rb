require 'tk'
require 'tkextlib/tile'

class SimplePaint
  def initialize
    @color = 'black'
    @brush_size = 2
    create_main_window
    create_canvas
    create_color_wheel
    create_brush_size_slider
    Tk.mainloop
  end

  private

  def create_main_window
    @root = TkRoot.new do
      title "Simple Paint Program"
      minsize(400, 500)
    end
  end

  def create_canvas
    @canvas = TkCanvas.new(@root) do
      width 400
      height 400
      background 'white'
      pack(padx: 10, pady: [10, 0])
    end

    @canvas.bind('B1-Motion', proc { |e| draw(e.x, e.y) })
  end

  def draw(x, y)
    TkcOval.new(@canvas, x, y, x + @brush_size, y + @brush_size, outline: @color, fill: @color)
  end

  def create_color_wheel
    color_frame = Tk::Tile::Frame.new(@root) { padding "3 3 12 12" }.grid(column: 0, row: 0, sticky: 'nsew')
    TkGrid.columnconfigure @root, 0, weight: 1
    TkGrid.rowconfigure @root, 0, weight: 1

    color_wheel = Tk::Tile::ColorChooser.new(color_frame) { command(proc { |color| change_color(color) }) }.grid(column: 0, row: 0)
  end

  def change_color(color)
    @color = color
  end

  def create_brush_size_slider
    brush_frame = Tk::Tile::Frame.new(@root) { padding "3 3 12 12" }.grid(column: 0, row: 1, sticky: 'ew')
    TkGrid.columnconfigure @root, 0, weight: 1
    TkGrid.rowconfigure @root, 1, weight: 1

    brush_label = Tk::Tile::Label.new(brush_frame) { text 'Brush Size:' }.grid(column: 0, row: 0, sticky: 'w')

    brush_slider = Tk::Tile::Scale.new(brush_frame) do
      from 1
      to 20
      orient 'horizontal'
      command(proc { |size| change_brush_size(size.to_i) })
    end.grid(column: 1, row: 0)
    brush_slider.set(@brush_size)
  end

  def change_brush_size(size)
    @brush_size = size
  end
end

SimplePaint.new

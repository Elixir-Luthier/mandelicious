defmodule Mandel.Graph do

  require Record
  Record.defrecordp :wx, Record.extract(:wx, from_lib: "wx/include/wx.hrl")

  @colors [{0,0,0,255}, {16,16,16,255}, {32,32,32,255}, {64,64,64,255}, {128,128,128,255}, {255,255,255,255}]
  @title "Mandel"

  def start(points, width, height, num_colors) do
    wx = :wx.new()
    frame = :wxFrame.new(wx, -1, @title, [{:size, {width, height}}])
    panel = :wxPanel.new(frame)
    pens = setup_colors(gen_colors(num_colors))
    #pens = setup_colors(@colors)

    on_paint = fn(_event, _object) ->
        paint = :wxPaintDC.new(panel)
        #:wxDC.setPen(paint, pen)
        #:wxPen.setColour(pen, {0,0,255,255})
        drawpoints(paint, pens, {points, length(hd(points)), length(points)})
        :wxPaintDC.destroy(paint)
    end

    :wxFrame.connect(panel, :paint, [{:callback, on_paint}])
    :wxFrame.connect(panel, :close_window)

    :wxFrame.center(frame)
    :wxFrame.show(frame)
  end

  def drawpoints(paint, pens, {points, width, height}) do
    for x<-0..width - 1 do
      for y<-0..height - 1 do

        :wxDC.setPen(paint, color(pens, Enum.at(Enum.at(points,y),x)))
        :wxDC.drawPoint(paint,{x,y})
      end
    end
  end

  def setup_colors(colors) do
    pen_colors = Enum.into(1..length(colors), [], fn(_) -> :wxPen.new() end)

    for p<-0..length(pen_colors)-1 do
      :wxPen.setColour(Enum.at(pen_colors, p), Enum.at(colors,p))
    end

    pen_colors
  end


  def color(pens, iter) do
    index = rem(iter, length(@colors))
    Enum.at(pens, index)
  end

  def gen_colors(n) do
    delta = 255/n
    Enum.reduce(0..n-1, [], fn(r, acc)->
       acc ++ [{4*round(r*delta),2*round(r*delta), 3*round(r*delta), :random.uniform(255)}]
    end)
  end
end

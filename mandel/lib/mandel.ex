defmodule Mandel do
  @moduledoc """
  Documentation for Mandel.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Mandel.hello
      :world

  """
  def graph(width \\ 1000, height \\ 1000, colors \\ 6, iter \\ 500, point \\ {-2.50, 2.50, -2.25, 2.25}) do
set = Mandel.Calc.set2(point, {width, height}, iter)
|> Mandel.Calc.raw_iter

Mandel.Graph.start(set, width, height, colors)
  end
end

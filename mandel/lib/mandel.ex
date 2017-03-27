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
  def graph(colors \\ 6, iter \\ 500) do
set = Mandel.Calc.set2({-2.50, 2.50, -2.25, 2.25}, {500,500}, iter)
|> Mandel.Calc.raw_iter

Mandel.Graph.start(set, 500, 500, colors)
  end
end

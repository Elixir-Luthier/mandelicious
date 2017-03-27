defmodule Mandel.Calc do

  @moduledoc """
  Documentation for Mandel.Calc

  This module will calculate a mandelbrot set using a brute-force iteration.

  Given a {xmin, xmax, ymin, ymax}, {width, height}, max_iter

  a list of width x height is returned with the bail-out iteration count or zero if it diverged

  """

  @doc """
    set2({xmin, xmax, ymin, ymax}, {width, height}, max_iter)

    To calculate a  100x100 Mandelbrot set, use the following arguments

    set = Mandel.Calc.set2({-2.0, 0.5, -1.25, 1.25}, {100,100}, 80)
  """
  def set2({xmin, xmax, ymin, ymax}, {width, height}, max_iter) do

    r1 = linspace(xmin, xmax, width)
    r2 = linspace(ymin, ymax, height)

    Enum.reduce(0..width - 1, [], fn(i, acc_i) ->
      [Enum.reduce(0..height - 1, [], fn(j, acc_j) -> acc_j ++ [brot2(Enum.at(r1, i), Enum.at(r2, j), max_iter)] end)] ++ acc_i
    end)
  end

  defp brot2(creal, cimag, max_iter) do
    real = creal
    imag = cimag
    Enum.reduce_while(1..max_iter, {0, {real, imag}}, fn(n, {_i, {real, imag}}) ->
        real2 = real*real
        imag2 = imag*imag
        if real2 + imag2 > 4.0 do
            {:halt, {n, {real2, imag2}}}
        else
          imag = 2* real*imag + cimag
          real = real2 - imag2 + creal
            if n == max_iter do
              {:halt, {0, {real, imag}}}
            else
              {:cont, {n, {real, imag}}}
            end
        end
      end)
  end

    @doc """

      raw_iter(set) returns the m x n lists of interations without the re,im compoments

    """
    def raw_iter(set) do
      Enum.reduce(0..length(set)-1, [], fn(i, acc) ->
          acc ++ [raw_row(Enum.at(set, i))]
      end)
    end

  def max_iter(set) do
    for i<- 0..length(set) - 1 do
       row_iter_max(Enum.at(set, i))
    end
    |> Enum.max
  end


  defp raw_row(row) do
    Enum.reduce(0..length(row)-1, [], fn(i, acc) ->
      acc ++ [elem(Enum.at(row,i),0)]
    end)
  end

  defp linspace(min, max, width) do

    delta = (max - min)/width
    Enum.reduce(0..width-1, [], fn(x, acc) ->
       acc ++ [ min + x * delta]
    end
    )
  end

  defp row_iter_max(r) do
    Enum.reduce(r,[], fn({i,{_,_}}, acc )-> [i] ++ acc  end) |> Enum.max
  end

end

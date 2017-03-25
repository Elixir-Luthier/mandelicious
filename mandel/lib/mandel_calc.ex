defmodule Mandel.Calc do

  def brot2(creal, cimag, max_iter) do
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

  def set2({xmin, xmax, ymin, ymax}, {width, height}, max_iter) do

    r1 = linspace(xmin, xmax, width)
    r2 = linspace(ymin, ymax, height)

    Enum.reduce(0..width - 1, [], fn(i, acc_i) ->
      [Enum.reduce(0..height - 1, [], fn(j, acc_j) -> acc_j ++ [brot2(Enum.at(r1, i), Enum.at(r2, j), max_iter)] end)] ++ acc_i
    end)
  end

  def linspace(min, max, width) do

    delta = (max - min)/width
    Enum.reduce(0..width-1, [], fn(x, acc) ->
       acc ++ [ x * delta]
    end
    )
  end
end

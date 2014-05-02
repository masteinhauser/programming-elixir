defmodule MyList do
  def mapsum([], _) do
    0
  end

  def mapsum([head | tail], fun) do
    fun.(head) + mapsum(tail, fun)
  end

  def max([ max ]), do: max
  def max([ max | [head|tail] ]) when max >= head, do: max([ max | tail ])
  def max([ max | [head|tail] ]) when max < head, do: max([ head | tail ])

  def caesar([head | tail], rot), do: _caesar([head | tail], rot)

  defp _caesar([], _rot) do
    []
  end

  defp _caesar([head | tail], rot) when head + rot <= ?z do
    [ head+rot | _caesar(tail, rot)]
  end

  defp _caesar([head | tail], rot) do
    [ head+rot-26 | _caesar(tail, rot)]
  end
end

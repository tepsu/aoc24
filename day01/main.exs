defmodule Day01 do
  def parse_distances(line) do
    line
    |> String.split("   ")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def to_left_and_right_list(filename \\ "day01.input") do
    File.stream!(filename)
    |> Stream.map(&Day01.parse_distances/1)
    |> Enum.reduce({[], []}, fn {n1, n2}, {l1, l2} ->
      {[n1 | l1], [n2 | l2]}
    end)
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        {left_list, right_list} = to_left_and_right_list()

        occurrences =
          Enum.reduce(right_list, %{}, fn num, acc ->
            Map.update(acc, num, 1, &(&1 + 1))
          end)

        Enum.reduce(left_list, 0, fn num, acc ->
          occ = Map.get(occurrences, num, 0)
          acc + num * occ
        end)
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result}")
  end

  def run_part1 do
    {time, result} =
      :timer.tc(fn ->
        {left_list, right_list} = to_left_and_right_list()

        sorted_left_list = Enum.sort(left_list)
        sorted_right_list = Enum.sort(right_list)

        Enum.zip(sorted_left_list, sorted_right_list)
        |> Enum.map(fn {a, b} -> abs(a - b) end)
        |> Enum.sum()
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end
end

Day01.run_part1()
Day01.run_part2()

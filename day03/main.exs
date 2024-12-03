# IEx.configure(inspect: [charlists: :as_lists])

defmodule Day03 do
  def parse_line(line) do
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, line)
  end

  def mul_captures([_, capture_one, capture_two]) do
    String.to_integer(capture_one) * String.to_integer(capture_two)
  end

  def run_part1 do
    {time, result} =
      :timer.tc(fn ->
        File.read!("day03.input")
        |> String.trim()
        # |> IO.inspect(label: "Trimmed line")
        |> Day03.parse_line()
        # |> IO.inspect(label: "Parsed line")
        |> Enum.map(&Day03.mul_captures/1)
        # |> IO.inspect(label: "Multiples")
        |> Enum.sum()
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        File.stream!("day03.sample")
        |> Stream.map(&Day03.parse_line/1)
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result}")
  end
end

Day03.run_part1()
# Day03.run_part2()

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
        |> Day03.parse_line()
        |> Enum.map(&Day03.mul_captures/1)
        |> Enum.sum()
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end

  def process_dos(dos) do
    dos
    |> String.split("don't()")
    |> hd()
    |> IO.inspect(label: "hd")
    |> Day03.parse_line()
    |> IO.inspect(label: "parse line")
    |> Enum.map(&Day03.mul_captures/1)
    |> IO.inspect(label: "mul_captures", charlists: :as_lists)
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        File.read!("day03.input")
        |> String.split("do()", trim: true)
        |> IO.inspect(label: "Split")
        |> Enum.flat_map(&Day03.process_dos/1)
        |> IO.inspect(label: "process_dos", charlists: :as_lists)
        |> Enum.sum()
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result}")
  end
end

Day03.run_part1()
Day03.run_part2()

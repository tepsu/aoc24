defmodule Day02 do
  def parse_line(line) do
    line
    |> String.split(" ")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def within_margin?(a, b) do
    diff = abs(a - b)
    diff in 1..3
  end

  def is_safe(report) do
    {all_asc, all_desc, all_within_margin} =
      report
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce({true, true, true}, fn
        # NOTE: [a,b] here is coming from chunk_every, as the first argument for .reduce
        # {asc, desc, within} is the accumulator for .reduce
        [a, b], {asc, desc, within} ->
          {asc && a < b, desc && a > b, within && within_margin?(a, b)}
      end)

    is_safe = (all_asc || all_desc) && all_within_margin
    is_safe
  end

  def valid_pair?(a, b) do
    (a < b or a > b) and within_margin?(a, b)
  end

  def run_part1 do
    {time, result} =
      :timer.tc(fn ->
        File.stream!("day02.input")
        |> Stream.map(&Day02.parse_line/1)
        |> Stream.filter(&Day02.is_safe/1)
        |> Enum.to_list()
        |> Enum.count()
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        File.stream!("day02.input")
        |> Stream.map(fn report_line ->
          report_line
          |> parse_line()
          |> then(fn report ->
            report
            |> Stream.with_index()
            |> Stream.map(fn {_num, index} ->
              report
              |> List.delete_at(index)
              |> is_safe()
            end)
            |> Enum.any?()
          end)
        end)
        |> Enum.frequencies()
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result[true]}")
  end
end

# Day02.run_part1()
Day02.run_part2()

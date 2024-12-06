defmodule Day04 do
  def xmas_or_samx?(string, dir, row, col) do
    case string do
      "XMAS" ->
        IO.inspect("XMAS hit when going #{dir}, from #{row + 1}, #{col + 1}")
        1

      # "SAMX" ->
      #   IO.inspect("SAMX hit when going #{dir}, from #{row + 1}, #{col + 1}")
      #   1

      _ ->
        0
    end
  end

  def matches(list, {y, x}) do
    list
    |> Enum.with_index(fn r, row ->
      r
      |> Enum.with_index(fn _, col ->
        match(list, y, x, row, col, "XMAS")
      end)
    end)
  end

  def match(_list, _y, _x, _row, _col, <<>>) do
    # IO.inspect("NO MORE MATCHES XD")
    true
  end

  def match(list, y, x, row, col, <<next_char_to_match, rest::binary>>) do
    # IO.inspect(row, label: "row")

    line = Enum.at(list, row)
    # IO.inspect(line, label: "line")

    if line != nil && col >= 0 and Enum.at(line, col) == <<next_char_to_match>> do
      match(list, y, x, row + y, col + x, rest)
    else
      false
    end
  end

  def run_part1 do
    dirs = [
      # up
      {-1, 0},
      # up right
      {-1, 1},
      # up left
      {-1, -1},
      # down
      {1, 0},
      # down right
      {1, 1},
      # down left
      {1, -1},
      # left
      {-1, 0},
      # right
      {0, 1}
    ]

    {time, result} =
      :timer.tc(fn ->
        File.read!("day04.input")
        |> String.split("\n", trim: true)
        |> Enum.map(&String.graphemes/1)
        |> then(fn list ->
          dirs
          |> Enum.map(fn {y, x} ->
            list
            |> matches({y, x})
            # |> IO.inspect(label: "matches")
            |> List.flatten()
            # |> IO.inspect(label: "flat")
            |> Enum.filter(fn el -> el == true end)
            # |> IO.inspect(label: "filtered")
            |> Enum.count()
          end)

          # |> IO.inspect(label: "match counts")
        end)
        |> Enum.sum()

        # |> IO.inspect(label: "sum")

        # |> Enum.chunk_every(4, 1)
        # |> IO.inspect(label: "Chunked")
        # |> Enum.each(fn chunk ->
        #   chunk
        #   |> hd()
        #   |> String.split("", trim: true)
        #   |> Enum.with_index(fn char, index ->
        #     char
        #     |> IO.inspect(label: "char at #{index}")

        #     matches_downwards = check_downward(index, chunk)
        #   end)
        # end)
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        File.read!("day04.sample")
        |> String.split("\n", trim: true)
        |> Enum.to_list()
        |> IO.inspect(label: "Map")
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result}")
  end
end

Day04.run_part1()
# Day04.run_part2()

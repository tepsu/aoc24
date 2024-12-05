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

  # def check_forward(from, chunk) do
  #   Enum.at(chunk, 0)
  #   |> IO.inspect(label: "Enum.at(chunk")
  #   |> String.slice(from, 4)
  #   |> IO.inspect(label: "Sliced forwards")
  #   |> xmas_or_samx?()
  # end

  # def check_downward(list, from) do
  #   list
  #   |> IO.inspect(label: "check_downward chunk")
  #   |> Enum.map(fn arr ->
  #     arr
  #     |> IO.inspect(label: "check_downward map")
  #     |> String.slice(from, 1)
  #   end)
  #   |> IO.inspect(label: "check_downward from")
  #   |> Enum.join("")
  #   |> IO.inspect(label: "check_downward join")
  #   |> xmas_or_samx?()
  # end

  # def move_up_and_take(list, -1, _), do: false

  # def move_up_and_take(list, cur_row, char_index) do
  #   list
  #   |> Enum.at(cur_row)
  #   |> case el do
  #     nil ->
  #       false

  #     el ->
  #       nil
  #   end
  # end

  # def match(line, <<>>), do: true
  # def match([]), do: true
  # def match(line, <<next_char, rest::binary>>) do
  #   # todo: get the char to compare to
  #   if String.at(line, char_index) == <<next_char>> do
  #     match(line, char_index + 1, rest)
  #   else
  #     false
  #   end
  # end

  # def move(list, current_string)

  # dir_y: -1 up, 1 down
  # dir-x: -1 left, 1 right
  # def gather_chars(list, [], []) do
  #   nil
  # end

  # def gather_chars(list, moves_y, moves_x) do
  #   # supports going up, down, left, right, or any xy combination (upright, downright, upleft, downleft)
  #   # row = Enum.at
  #   Enum.slice()
  #   [String.slice(el, Enum.at(moves_x, i), 1) | acc]
  #   # {_, chars} =
  #   #   moves_y
  #   #   |> Enum.reduce_while({Enum.at(moves_x, 0), []}, fn row, {x_i, acc} ->
  #   #     # first go up or down, Enum.at(...,..., nil) protects against out of bounds exceptions
  #   #     case Enum.at(list, row) do
  #   #       # we're out of bounds, return the accumulated array so far
  #   #       nil ->
  #   #         {:halt, {x_i, acc}}

  #   #       el ->
  #   #         IO.inspect(row, label: "row")
  #   #         IO.inspect(moves_x, label: "moves_x")
  #   #         IO.inspect(x_i, label: "x_i")

  #   #         case Enum.at(moves_x, x_i, nil) do
  #   #           nil -> {:halt, {x_i, acc}}
  #   #           i -> {:cont, {i + 1, [String.slice(el, Enum.at(moves_x, i), 1) | acc]}}
  #   #         end
  #   #     end
  #   #   end)

  #   # chars |> Enum.join()

  #   # (cur_row - 1)..(cur_row - 3)
  #   # |> Enum.reduce_while([char], fn row, acc ->
  #   #   case Enum.at(list, row, nil) do
  #   #     nil ->
  #   #       {:halt, acc}

  #   #     el ->
  #   #       col = row - cur_row
  #   #       next_char = String.slice(el, col, 1)
  #   #       {:cont, [next_char | acc]}
  #   #   end
  #   # end)
  #   # |> Enum.join("")
  # end

  def match(_col, _row, _dirs, _list, <<>>), do: true

  def match(col, row, {dir_y, dir_x}, list, <<next_char_to_match, rest::binary>>) do
    line = Enum.at(list, row)

    if col >= 0 and line != nil and next_char_to_match == String.at(line, col) do
      match(col + dir_x, row + dir_y, list, rest)
    else
      false
    end
  end

  # |> Enum.reduce(0, fn {_char, cur_col}, acc ->
  #   # down_count =
  #   #   (cur_row + 1)..(cur_row + 3)
  #   #   |> Enum.reduce_while([char], fn row, acc ->
  #   #     case Enum.at(list, row, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         {:cont, [String.slice(el, cur_col, 1) | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("down", cur_row, cur_col)

  #   # up_count =
  #   #   (cur_row - 1)..(cur_row - 3)
  #   #   |> Enum.reduce_while([char], fn row, acc ->
  #   #     case Enum.at(list, row, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         {:cont, [String.slice(el, cur_col, 1) | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("up", cur_row, cur_col)

  #   # right_count =
  #   #   (cur_col + 1)..(cur_col + 3)
  #   #   |> Enum.reduce_while([char], fn col, acc ->
  #   #     case Enum.at(list, col, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         next_char = String.slice(el, col, 1)
  #   #         {:cont, [next_char | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("right", cur_row, cur_col)

  #   # left_count =
  #   #   (cur_col - 1)..(cur_col - 3)
  #   #   |> Enum.reduce_while([char], fn col, acc ->
  #   #     case Enum.at(list, col, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         next_char = String.slice(el, col, 1)
  #   #         {:cont, [next_char | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("left", cur_row, cur_col)

  #   # up_right_count =
  #   #   (cur_row - 1)..(cur_row - 3)
  #   #   |> Enum.reduce_while([char], fn row, acc ->
  #   #     case Enum.at(list, row, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         col = row - cur_row
  #   #         next_char = String.slice(el, col, 1)
  #   #         {:cont, [next_char | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("up_right", cur_row, cur_col)

  #   # down_right_count =
  #   #   (cur_row + 1)..(cur_row + 3)
  #   #   |> Enum.reduce_while([char], fn row, acc ->
  #   #     case Enum.at(list, row, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         col = row - cur_row
  #   #         next_char = String.slice(el, col, 1)
  #   #         {:cont, [next_char | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("down_right", cur_row, cur_col)

  #   # down_left_count =
  #   #   (cur_row + 1)..(cur_row + 3)
  #   #   |> Enum.reduce_while([char], fn row, acc ->
  #   #     case Enum.at(list, row, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         col = cur_row - row
  #   #         next_char = String.slice(el, col, 1)
  #   #         {:cont, [next_char | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("down_left", cur_row, cur_col)

  #   # up_left_count =
  #   #   (cur_row - 1)..(cur_row - 3)
  #   #   |> Enum.reduce_while([char], fn row, acc ->
  #   #     case Enum.at(list, row, nil) do
  #   #       nil ->
  #   #         {:halt, acc}

  #   #       el ->
  #   #         col = cur_row - row
  #   #         next_char = String.slice(el, col, 1)
  #   #         {:cont, [next_char | acc]}
  #   #     end
  #   #   end)
  #   #   |> Enum.join("")
  #   #   |> xmas_or_samx?("up_left", cur_row, cur_col)

  #   right_count =
  #     gather_chars(
  #       list,
  #       List.duplicate(cur_row, 4),
  #       0..3 |> Enum.map(fn i -> cur_col + i end)
  #     )
  #     |> xmas_or_samx?("up_left", cur_row, cur_col)

  #   acc + right_count
  # end)

  def run_part1 do
    {time, result} =
      :timer.tc(fn ->
        File.read!("day04.sample")
        |> String.split("\n", trim: true)
        |> Enum.to_list()
        |> IO.inspect(label: "to_list")
        |> then(fn list ->
          list
          |> match(cur_row, {0, 1}, list, "XMAS")
        end)
        |> Enum.filter(&(&1 == true))
        |> Enum.sum()
        |> IO.inspect(label: "sum")

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

defmodule Day06 do
  def turn_right({dir_y, dir_x}) do
    # IO.inspect({dir_y, dir_x}, label: "turn_right from")
    # we can move 4 directiions
    # {-1, 0} == up     turn right  -> right  {0, 1}
    # {0, -1} == left   turn right  -> up     {-1, 0}
    # {1, 0}  == down   turn right  -> left   {0, -1}
    # {0, 1}  == right  turn right  -> down,  {1, 0}
    case {dir_y, dir_x} do
      {-1, 0} -> {0, 1}
      {0, -1} -> {-1, 0}
      {1, 0} -> {0, -1}
      {0, 1} -> {1, 0}
    end
  end

  # Terminating case, we're out of bounds
  def move_and_replace(input, {row, col}, _dirs)
      when row >= length(input) or row < 0 or col < 0 do
    input
  end

  def move_and_replace(input, {row, col}, {dir_y, dir_x}) do
    ch =
      input
      |> Enum.at(row)
      |> Enum.at(col)

    # |> IO.inspect(label: "ch row,col")

    if ch == "#" do
      {new_dir_y, new_dir_x} = turn_right({dir_y, dir_x})

      # we also need to backpedal one step because now we're ON the #, when we should be one step before it
      # to start moving again
      # can we just do row - 1 and col -1?
      # IO.inspect({new_dir_y, new_dir_x}, label: "new dir")
      new_row = row + -1 * dir_y + new_dir_y
      new_col = col + -1 * dir_x + new_dir_x
      # IO.inspect({new_row, new_col}, label: "new index")

      move_and_replace(input, {new_row, new_col}, {new_dir_y, new_dir_x})
    else
      replaced_list =
        input
        |> List.replace_at(row, List.replace_at(Enum.at(input, row), col, "X"))

      # |> IO.inspect(label: "replaced_list")

      new_row = row + dir_y
      new_col = col + dir_x
      # IO.inspect({new_row, new_col}, label: "new index")
      move_and_replace(replaced_list, {new_row, new_col}, {dir_y, dir_x})
    end
  end

  def run_part1 do
    {time, result} =
      :timer.tc(fn ->
        input =
          File.read!("day06.input")
          |> String.split("\n", trim: true)
          |> Enum.map(&String.graphemes/1)

        {start_row, start_col} =
          input
          |> Enum.with_index()
          |> Enum.reduce_while(nil, fn {r, row}, acc ->
            case Enum.find_index(r, fn ch -> ch == "^" end) do
              nil -> {:cont, acc}
              col -> {:halt, {row, col}}
            end
          end)

        # |> IO.inspect()

        input
        |> move_and_replace({start_row, start_col}, {-1, 0})
        # |> IO.inspect(label: "replaced")
        |> List.flatten()
        # |> IO.inspect(label: "flattened")
        |> Enum.filter(fn el -> el == "X" end)
        # |> IO.inspect(label: "filtered")
        |> Enum.count()
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        File.read!("day06.sample")
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result}")
  end
end

Day06.run_part1()
# Day06.run_part2()

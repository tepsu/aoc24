defmodule Day05 do
  # final call for element
  def check_element(_el, [], _rules), do: true

  # first call for element
  def check_element(el, [other_el | tail], rules) do
    if rules != nil and Enum.member?(rules, other_el) do
      false
    else
      check_element(el, tail, rules)
    end
  end

  # final call for list
  def check_list([], _), do: true

  # first call for list
  def check_list([el | tail], rules_map) do
    rules = rules_map[el]

    if check_element(el, tail, rules) do
      check_list(tail, rules_map)
    else
      false
    end
  end

  def at_middle(list) do
    len = length(list)
    i = div(len, 2)

    list |> Enum.at(i) |> String.to_integer()
  end

  def run_part1 do
    {time, result} =
      :timer.tc(fn ->
        [rules_arr, lists] =
          File.read!("day05.input")
          |> String.split("\n\n", trim: true)
          |> Enum.map(&String.split/1)

        rules_map =
          rules_arr
          |> Enum.reduce(%{}, fn string, acc ->
            [value, key] = String.split(string, "|")
            Map.put(acc, key, [value | acc[key] || []])
          end)

        lists
        |> Enum.map(fn list ->
          list
          |> String.split(",")
        end)
        |> Enum.filter(fn list ->
          check_list(list, rules_map)
        end)
        |> Enum.map(&at_middle/1)
        |> Enum.sum()
      end)

    IO.puts("PART ONE: Execution time: #{time / 1000} ms")
    IO.puts("PART ONE: Result: #{result}")
  end

  def run_part2 do
    {time, result} =
      :timer.tc(fn ->
        File.read!("day05.sample")
        |> String.split("\n\n", trim: true)
      end)

    IO.puts("PART TWO: Execution time: #{time / 1000} ms")
    IO.puts("PART TWO: Result: #{result}")
  end
end

Day05.run_part1()
# Day05.run_part2()

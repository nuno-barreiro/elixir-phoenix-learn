# Elixir learn
This repository contains source code related to my own personal learning of the Elixir programming language and the Phoenix framework. 

## Projects in the repo

- **cards**: Introductory project to elixir developed while taking the Udemy course "[The complete Elixir and Phoenix bootcamp and tutorial](https://www.udemy.com/course/the-complete-elixir-and-phoenix-bootcamp-and-tutorial)" by [Stephen Grider](https://twitter.com/ste_grider).


## Study Notes

### Keyword Lists
Creates a new keyword list and access a property
```elixir
iex> colors = [{:primary, "red"}, {:secondary, "blue"}]
iex> colors[:secondary]
"blue"
```

### Maps

Creating a map and accessing its values directly
```elixir
iex> colors = %{ primary: "red", secondary: "blue" }
iex> colors.secondary 
"blue"
```

Using pattern matching with a map
```elixir
iex> colors = %{ primary: "red", secondary: "blue" }
iex> %{secondary: secondary_color} = colors
iex> secondary_color
"blue"
```

Update a value in a map using a function of the Map type
```elixir
iex> colors = %{ primary: "red", secondary: "blue" }
iex> Map.put(colors, :primary, "yellow")
%{primary: "yellow", secondary: "blue"}
```

Update a value in a map using the pipe `|` symbol
```elixir
iex> colors = %{ primary: "red", secondary: "blue" }
iex> %{ colors | primary: "yellow" }
%{primary: "yellow", secondary: "blue"}
```

Put a new value to an existing map
```elixir
iex> colors = %{ primary: "red" }
iex> Map.put_new(colors, :secondary, "blue")
%{primary: "red", secondary: "blue"}
```

## Useful commands

### IEx (interactive shell)

Run interactive shell
```bash
$ iex -S mix
```

### Mix (build tool)

Get dependencies
```bash
$ mix deps.get
```

Generate documentation
```bash
$ mix docs
```

Execute tests
```bash
$ mix test
```

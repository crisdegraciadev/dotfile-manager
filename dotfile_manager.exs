# dotfiles_manager.exs

Mix.install([
  {:jason, "~> 1.4"}
])

home_dir = System.user_home!()

defmodule DotfilesManager do
  defp extract_data(parsed, script_dir) do
    parsed["dotfiles"]
    |> Enum.map(fn dotfile ->
      name = dotfile["name"]
      source = Path.expand(dotfile["source"], script_dir)
      destination = String.replace(dotfile["destination"], "$HOME", System.user_home!())
      {name, {source, destination}}
    end)
  end

  def load_dotfiles_from_json(json_file, script_dir) do
    case File.read(json_file) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, parsed} ->
            extract_data(parsed, script_dir)

          {:error, reason} ->
            IO.puts("Failed to parse JSON file: #{reason}")
            []
        end

      {:error, reason} ->
        IO.puts("Failed to read JSON file: #{reason}")
        []
    end
  end

  def copy_dotfile(source, destination) do
    if File.dir?(source) do
      File.cp_r!(source, destination)
      IO.puts("Copied directory: #{source} -> #{destination}")
    else
      File.copy!(source, destination)
      IO.puts("Copied file: #{source} -> #{destination}")
    end
  end

  def install_dotfiles(dotfiles) do
    Enum.each(dotfiles, fn {_, {source, destination}} ->
      copy_dotfile(source, destination)
    end)
  end
end

script_dir = Path.dirname(__ENV__.file)

dotfiles = DotfilesManager.load_dotfiles_from_json("dotfiles.json", script_dir)

DotfilesManager.install_dotfiles(dotfiles)

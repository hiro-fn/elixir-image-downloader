defmodule GetImage do
  def get_image(param) do
    HTTPoison.start

    user_name = param[:name]
    url = param[:url]
    file_name = hd(Enum.reverse(String.split(param[:url], "/")))

    IO.puts "Start Download #{url}"
    body = HTTPoison.get!(url).body
    File.write!("./img/#{user_name}@#{file_name}", body)
    IO.puts "Done! #{url}"
  end
end

defmodule ElixTwit do

  def get_url() do
    stream = ExTwitter.stream_sample(receive_message: true) |>
      Stream.filter(fn(x) -> is_nil(x.retweeted_status) end) |>
      Stream.filter(fn(x) -> Map.has_key?(x.entities, :media) end) |>
      Stream.filter(fn(x) -> x.lang === "ja" end) |>
      Stream.map(fn(x) -> %{name: x.user.screen_name, url: hd(x.entities.media).media_url} end) |>
      Stream.map(fn(x) -> GetImage.get_image(x) end)
    Enum.to_list(stream)
  end
end

ElixTwit.get_url()

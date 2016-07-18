defmodule GetImage do
  def get_image(url) do
    HTTPoison.start

    file_name = hd(Enum.reverse(String.split(url, "/")))

    IO.puts "Start Download #{url}"
    body = HTTPoison.get!(url).body
    File.write!("./img/#{file_name}", body)
    IO.puts "Done! #{url}"
  end
end

defmodule ElixTwit do

  def get_url() do
    stream = ExTwitter.stream_sample(receive_message: true) |>
      Stream.filter(fn(x) -> is_nil(x.retweeted_status) end) |>
      Stream.filter(fn(x) -> Map.has_key?(x.entities, :media) end) |>
      Stream.filter(fn(x) -> x.lang === "ja" end) |>
      Stream.map(fn(x) -> hd(x.entities.media).media_url end) |>
      Stream.map(fn(x) -> GetImage.get_image(x) end)
    Enum.to_list(stream)
  end
end

ElixTwit.get_url()

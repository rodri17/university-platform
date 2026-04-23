class UnsplashService
  include HTTParty
  base_uri "https://api.unsplash.com"

  ACCESS_KEY = ENV["UNSPLASH_ACCESS_KEY"]

  def self.fetch_image(query)
    response = get("/search/photos", query: {
      query: query,
      per_page: 1,
      orientation: "landscape"
    }, headers: {
      "Authorization" => "Client-ID #{ACCESS_KEY}"
    })

    return nil unless response.success?

    result = response.parsed_response.dig("results", 0)
    return nil unless result

    {
      url:          result.dig("urls", "regular"),
      thumb:        result.dig("urls", "thumb"),
      alt:          result.dig("alt_description"),
      photographer: result.dig("user", "name"),
      unsplash_link: result.dig("links", "html")
    }
  rescue StandardError => e
    Rails.logger.error("Unsplash error: #{e.message}")
    nil
  end
end

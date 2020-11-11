class Scraping

  def self.get_url
    agent = Mechanize.new
    page = agent.get("https://bestcarweb.jp/tags/%E3%83%9E%E3%82%A4%E3%83%8A%E3%83%BC%E3%83%81%E3%82%A7%E3%83%B3%E3%82%B8")
    elements = page.links_with(:href => /news/)
  end

end
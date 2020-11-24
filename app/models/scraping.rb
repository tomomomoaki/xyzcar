class Scraping
  def self.get_url
    agent = Mechanize.new
    page = agent.get('https://bestcarweb.jp/newcar')
    elements = page.links_with(href: /newcar/ )

  end
end

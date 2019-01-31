class LanguageLinkFilter < Banzai::Filter
  def call(input)
    @input = input

    document.css('a').each_with_index do |link, _index|
      if link['href']&.start_with?('/')
        link['href'] = "/en#{link['href']}"
      end
    end

    @document.to_html
  end

  private

  def document
    @document ||= Nokogiri::HTML::DocumentFragment.parse(@input)
  end
end

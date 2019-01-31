class LanguageLinkFilter < Banzai::Filter
  def call(input)
    @input = input

    document.css('a').each_with_index do |link, _index|
      link['href'] = "/#{options[:language]}#{link['href']}" if link['href']&.start_with?('/')
    end

    @document.to_html
  end

  private

  def document
    @document ||= Nokogiri::HTML::DocumentFragment.parse(@input)
  end
end

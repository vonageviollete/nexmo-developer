class LanguageConstraint
  def self.language_route
    { 'language' => languages.join('|') }
  end

  def self.languages
    ['en']
  end

  def self.default_language
    'en'
  end
end

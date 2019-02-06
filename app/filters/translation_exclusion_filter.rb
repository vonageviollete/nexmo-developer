class TranslationExclusionFilter < Banzai::Filter
  def call(input)
    input.gsub(/§§§(.+?)§§§/m) do |_s|
      $1
    end
  end
end

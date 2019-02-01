class BuildingBlock
  include ActiveModel::Model
  attr_accessor :title, :product, :category, :navigation_weight, :document_path, :url

  def self.by_product(product, language)
    all(language).select do |block|
      block.product == product
    end
  end

  def self.all(language)
    blocks = files(language).map do |document_path|
      document = File.read(document_path)
      product = extract_product(document_path, language)

      frontmatter = YAML.safe_load(document)

      BuildingBlock.new({
        title: frontmatter['title'],
        navigation_weight: frontmatter['navigation_weight'] || 999,
        product: product,
        document_path: document_path,
        category: extract_category(document_path, language),
        url: generate_url(document_path, language),
      })
    end

    blocks.sort_by(&:navigation_weight)
  end

  def self.path_without_prefix(path, language)
    path.gsub("#{origin}/#{language}/", '')
  end


  def self.generate_url(path, language)
    "/" + path_without_prefix(path, language).gsub('.md', '')
  end

  def self.extract_product(path, language)
    # Remove the prefix
    path = path_without_prefix(path, language)

    # Each file is in the form building-blocks/<title>.md, so let's remove everything after building-blocks
    path = path.gsub(%r{/building-blocks/.*}, '')

    path
  end

  def self.extract_category(path, language)
    # Each file is in the form building-blocks/<title>.md, so let's capture everything after building-blocks
    path = path.gsub(%r{.*/building-blocks/(.*)\.md$}, '\1')

    parts = path.split('/')
    parts = parts[0...-1]

    return nil if parts.empty?

    parts.join('/').tr('-', ' ').humanize
  end

  def self.files(language)
    Dir.glob("#{origin}/#{language}/**/building-blocks/**/*.md")
  end

  def self.origin
    "#{Rails.root}/_documentation"
  end
end

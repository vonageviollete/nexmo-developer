
PROJECT_ID = 'fd55d1395'

USER_ID = ''
USER_SECRET = ''
smartlingToken = ''

namespace :smartling do

  desc 'foo'
  task 'test' do
    res = sl.list
    p res
  end

  desc 'Find all documents that need translating'
  task 'translations_due': :environment  do
    document_paths =
      [
        "#{Rails.root}/_documentation/**/*.md",
      ]
    document_paths.each do |path|
      Dir.glob(path).each do |filename|
        document = File.read(filename)
        frontmatter = YAML.safe_load(document)
        if frontmatter['translated_languages']
          puts frontmatter

          # Run through our markdown pipeline to generate content
          content = SmartlingStringIO.new(filename, remove_untranslatable_content(document))

          file_uri = filename.gsub("#{Rails.root}/_documentation/en/", '')
          puts "Uploading file '#{filename}' using file URI '#{file_uri}' and file type markdown..."
          send_file(smartlingToken, content, file_uri)
        end
      end
    end
  end
end

def send_file(authToken, content, file_uri)
  url = "https://api.smartling.com/files-api/v2/projects/#{PROJECT_ID}/file"
  begin
    response = RestClient.post(
      url,
      {
        :file => content,
        :fileUri => file_uri,
        :fileType => 'markdown',
        :multipart => true
      },
      {
        Authorization: "Bearer #{authToken}",
        'Content-Type': 'multipart/form-data'
      }
    )

    puts response.body

  rescue Exception => e
    puts JSON.parse(e.response.body)
  end
end

def remove_untranslatable_content(document)
  document.gsub!(/^(\s*)```building_blocks(.+?)```/m, '')
  document.gsub!(/^(\s*)```concept_list(.+?)```/m, '')
  document.gsub!(/^(\s*)```building_block_list(.+?)```/m, '')
  document.gsub!(/^(\s*)```tutorials(.+?)```/m, '')
  document.gsub!(/^(\s*)```partial(.+?)```/m, '')
  document.gsub!(/§§§(.+?)§§§/m, '')
  document
end

class SmartlingStringIO < ::StringIO
  attr_accessor :path

  def initialize(*args)
    super(*args[1..-1])
    @path = args[0]
  end

  def content_type
    'text/markdown'
  end
end

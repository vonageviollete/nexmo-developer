require 'rails_helper'

RSpec.describe BuildingBlocksFilter do
  it 'returns tab content encoded with proper input' do
    input = <<~HEREDOC
      ```building_blocks
      source: '_examples/voice/handle-user-input-with-dtmf'
      language: node
      ```
    HEREDOC

    expect(BuildingBlocksFilter.call(input)).to include('FREEZESTART')
  end

  it 'returns input if input does not begin with "```building_blocks"' do
    input = <<~HEREDOC
      ```something_else
      source: '_examples/voice/handle-user-input-with-dtmf'
      language: node
      ```
    HEREDOC

    expect(BuildingBlocksFilter.call(input)).to include('```something_else')
  end

  it 'raises an error if source cannot be found in filesystem' do
    input = <<~HEREDOC
      ```building_blocks
      source: '_path/to/an-example'
      language: node
      ```
    HEREDOC

    expect { BuildingBlocksFilter.call(input) }.to raise_error(RuntimeError)
  end
end

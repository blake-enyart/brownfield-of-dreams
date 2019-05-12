require 'rails_helper'

describe DataParse::Repo do
  it 'has attributes' do
    attributes = {
     name: 'Michael Jackson',
     html_url: '5'
     }

    member = DataParse::Repo.new(attributes)
    expect(member.name).to eq('Michael Jackson')
    expect(member.html_url).to eq('5')
  end
end

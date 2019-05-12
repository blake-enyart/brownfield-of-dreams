require 'rails_helper'

describe DataParse::GithubUser do
  it 'has attributes' do
    attributes = {
     login: 'Michael Jackson',
     html_url: '5'
                  }

    member = DataParse::GithubUser.new(attributes)
    expect(member.handle).to eq('Michael Jackson')
    expect(member.github_url).to eq('5')
  end
end

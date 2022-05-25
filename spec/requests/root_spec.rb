# frozen_string_literal: true

describe 'Root', type: :request do

  let(:expected) { { success: true, message: 'Application server is up', env: 'test' } }
  it 'root return app up' do
    get '/'
    expect(response_body).to eq(expected)
  end
end

# frozen_string_literal: true

require_relative '../../app/services/create_user_service'

describe CreateUserService do
  subject(:call) { described_class.call(**params) }

  let(:email) { Faker::Internet.email }
  let(:blocked) { false }
  let(:params) { { email: email, blocked: blocked } }

  context 'with valid args' do
    it 'should create user' do
      expect { call }.to change { User.count }.by(1)
      role = User.last
      expect(role.email).to eq(params[:email])
      expect(role.blocked).to eq(params[:blocked])
    end
  end

  context 'with invalid args' do
    context 'without email' do
      let(:params) { { blocked: blocked } }

      it 'should not create user' do
        expect { call }.to raise_error(described_class::NotValidArgs)
      end
    end

    context 'with invalid email' do
      let(:email) { 'foobar.ru' }

      it 'should not create user' do
        expect { call }.to raise_error(described_class::NotValidUser)
      end
    end

    context 'with invalid blocked' do
      let(:blocked) { 1 }

      it 'should not create user' do
        expect { call }.to raise_error(described_class::NotValidArgs)
      end
    end
  end

  context 'when role exists' do
    it 'should not create role' do
      create(:user, **params)
      expect { call }.to raise_error(described_class::NotValidUser)
    end
  end
end

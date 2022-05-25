# frozen_string_literal: true

describe 'UsersController', type: :request do
  subject { get 'role/users', params }

  let(:key) { role.key }
  let(:limit) { nil }
  let(:offset) { nil }
  let(:params) { { key: key, limit: limit, offset: offset } }

  let(:users) { create_list(:user, 10) }
  let(:role) { create(:role) }

  before do
    users.each do |user|
      create(:user_role, user_id: user.id, role_id: role.id)
    end
  end

  before do
    subject
  end

  context 'when role not exits' do
    let(:key) { 'some_key' }

    it 'should return nothing' do
      expect(response_body).to eq([])
    end
  end

  context 'when user exits' do
    let(:serialized_users) do
      users.map { |item| to_sym_hash(item.to_json(only: %i[email uuid])) }
    end

    it 'should return all role users' do
      expect(response_body).to eq(serialized_users)
    end

    context 'with limit' do
      let(:limit) { 5 }

      it 'should return limited role users' do
        expect(response_body).to eq(serialized_users[0..limit - 1])
      end

      context 'with offset' do
        let(:offset) { 5 }

        it 'should return limited role users' do
          expect(response_body).to eq(serialized_users[offset..offset + limit])
        end
      end
    end
  end
end

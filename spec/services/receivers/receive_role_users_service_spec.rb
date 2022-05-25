# frozen_string_literal: true

require_relative '../../../app/services/receivers/receive_role_users_service'

describe ReceiveRoleUsersService do
  subject(:call) { described_class.call(**params) }

  let(:users) { create_list(:user, 10) }
  let(:role) { create(:role) }

  let(:key) { role.key }
  let(:limit) { nil }
  let(:offset) { nil }
  let(:params) { { key: key, limit: limit, offset: offset } }

  before do
    users.each do |user|
      create(:user_role, user_id: user.id, role_id: role.id)
    end
  end

  context 'when role not exits' do
    let(:key) { 'some_key' }

    it 'should raise error' do
      expect(call).to eq([])
    end
  end

  context 'when role exits' do
    let(:expected) { users.map { |item| to_sym_hash(item.to_json(only: %i[uuid email])) } }

    it 'should return all role users' do
      expect(call).to eq(expected)
    end

    context 'with limit' do
      let(:limit) { 5 }

      it 'should return limited role users' do
        expect(call).to eq(expected[0..limit - 1])
      end

      context 'with offset' do
        let(:offset) { 5 }

        it 'should return limited role users' do
          expect(call).to eq(expected[offset..offset + limit])
        end
      end
    end
  end
end

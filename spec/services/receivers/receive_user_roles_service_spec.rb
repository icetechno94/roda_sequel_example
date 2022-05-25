# frozen_string_literal: true

require_relative '../../../app/services/receivers/receive_user_roles_service'
require 'securerandom'

describe ReceiveUserRolesService do
  subject(:call) { described_class.call(**params) }

  let(:roles) { create_list(:role, 10) }
  let(:user) { create(:user) }

  let(:uuid) { user.uuid }
  let(:limit) { nil }
  let(:offset) { nil }
  let(:params) { { user_uuid: uuid, limit: limit, offset: offset } }

  before do
    roles.each do |role|
      create(:user_role, user_id: user.id, role_id: role.id)
    end
  end

  context 'when role not exits' do
    let(:uuid) { SecureRandom.uuid }

    it 'should return nothing' do
      expect(call).to eq([])
    end
  end

  context 'when user exits' do
    let(:expected) { roles.map { |item| to_sym_hash(item.to_json(only: %i[name key])) } }

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

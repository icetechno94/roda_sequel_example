# frozen_string_literal: true

describe 'UsersController', type: :request do
  subject { get 'user/roles', params }

  let(:uuid) { user.uuid }
  let(:limit) { nil }
  let(:offset) { nil }
  let(:params) { { uuid: uuid, limit: limit, offset: offset } }

  let(:roles) { create_list(:role, 10) }
  let(:user) { create(:user) }

  before do
    roles.each do |role|
      create(:user_role, user_id: user.id, role_id: role.id)
    end
  end

  before do
    subject
  end

  context 'when role not exits' do
    let(:uuid) { SecureRandom.uuid }

    it 'should return nothing' do
      expect(response_body).to eq([])
    end
  end

  context 'when user exits' do
    let(:serialized_roles) do
      roles.map { |item| JSON.parse(item.to_json(only: %i[name key]), symbolize_names: true) }
    end

    it 'should return all role users' do
      expect(response_body).to eq(serialized_roles)
    end

    context 'with limit' do
      let(:limit) { 5 }

      it 'should return limited user roles' do
        expect(response_body).to eq(serialized_roles[0..limit - 1])
      end

      context 'with offset' do
        let(:offset) { 5 }

        it 'should return limited user roles' do
          expect(response_body).to eq(serialized_roles[offset..offset + limit])
        end
      end
    end
  end
end

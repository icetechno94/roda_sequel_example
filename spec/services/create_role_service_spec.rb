# frozen_string_literal: true

require_relative '../../app/services/create_role_service'

describe CreateRoleService do
  subject(:call) { described_class.call(**params) }

  let(:params) { { name: Faker::Job.title } }

  context 'with valid args' do
    it 'should create role' do
      expect { call }.to change { Role.count }.by(1)
      role = Role.last
      expect(role.name).to eq(params[:name])
      expect(role.key).to eq(params[:name].underscore)
    end
  end

  context 'with invalid args' do
    context 'without name' do
      let(:params) { {} }

      it 'should not create role' do
        expect { call }.to raise_error(described_class::NotValidArgs)
      end
    end

    context 'without name' do
      let(:params) { { name: 1 } }

      it 'should not create role' do
        expect { call }.to raise_error(described_class::NotValidArgs)
      end
    end
  end

  context 'when role exists' do
    it 'should not create role' do
      create(:role, **params)
      expect { call }.to raise_error(described_class::NotValidRole)
    end
  end
end

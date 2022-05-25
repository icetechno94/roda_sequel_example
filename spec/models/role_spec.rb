# frozen_string_literal: true

describe 'Role' do
  let(:params) { { name: name, key: key } }
  let(:name) { Faker::Job.title }
  let(:key) { name.underscore }

  describe 'validate' do
    subject(:role) { build(:role, **params) }

    context 'with name' do
      it 'should be valid' do
        expect(role.valid?).to be_truthy
      end
    end

    context 'when same record exists' do
      before do
        create(:role, **params)
      end

      it 'should be valid' do
        expect(role.valid?).to be_falsey
      end
    end
  end

  describe 'save' do
    subject(:create_role!) { create(:role, **params) }

    context 'when uniq record' do
      it 'create record in db' do
        expect { create_role! }.to change { Role.count }.by(1)
      end
    end

    context 'when uniq record' do
      it 'create record in db' do
        create(:role, **params)
        expect { create_role! }.to raise_error(Sequel::ValidationFailed)
      end
    end
  end
end

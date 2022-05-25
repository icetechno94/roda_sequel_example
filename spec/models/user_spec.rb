# frozen_string_literal: true

describe 'User' do
  let(:params) { { email: email, blocked: blocked } }
  let(:email) { Faker::Internet.email }
  let(:blocked) { false }

  describe 'validate' do
    subject(:user) { build(:user, **params) }

    context 'with email' do
      context 'without blocked' do
        let(:params) { { email: email } }

        it 'should be valid' do
          expect(user.valid?).to be_truthy
          expect(user.blocked).to be_falsey
        end
      end

      context 'with blocked' do
        it 'should be valid' do
          expect(user.valid?).to be_truthy
        end
      end

      context 'with invalid email' do
        let(:email) { 'foobar.ru' }

        it 'should be invalid' do
          expect(user.valid?).to be_falsey
        end
      end

      context 'when record with same email exists' do
        let(:params) { { email: email } }

        before do
          create(:user, **params)
        end

        it 'should not be valid' do
          expect(user.valid?).to be_falsey
        end
      end

      context 'when record with same email exists' do
        let(:params) { { email: email } }

        before do
          create(:user, email: email, blocked: true)
        end

        it 'should be valid' do
          expect(user.valid?).to be_truthy
        end
      end
    end
  end

  describe 'save' do
    subject(:create_user!) { create(:user, **params) }

    context 'when uniq record' do
      it 'create record in db' do
        expect { create_user! }.to change { User.count }.by(1)
      end
    end

    context 'when uniq record' do
      it 'create record in db' do
        create(:user, **params)
        expect { create_user! }.to raise_error(Sequel::ValidationFailed)
      end
    end
  end
end

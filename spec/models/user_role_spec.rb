# frozen_string_literal: true

describe 'UserRole' do
  let(:user_role) { create(:user_role) }
  context 'when records exits' do
    it 'should create record' do
      expect { user_role }.to change { UserRole.count }.by(1)
      expect(user_role.user).to eq(User.last)
      expect(user_role.role).to eq(Role.last)
    end
  end
end

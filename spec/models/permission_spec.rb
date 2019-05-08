require 'rails_helper'

RSpec.describe Permission, type: :model do
  
  it { should belong_to(:user) }
  it { should validate_presence_of(:accept) }

  describe '#validations' do
      subject { Permission.new }

      context 'when is not valid' do
          it { expect(subject.valid?).to be_falsey }
      end

      context 'when is valid' do
          subject { build(:user) }

          it { expect(subject.valid?).to be_truthy }
      end
  end
end
